# Check if all arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <email> <budget_amount> <budget_duration>" >&2
    exit 1
fi

EMAIL="$1"
BUDGET="$2"
BUDGET_DURATION="$3"

# Validate that budget is a valid number
if ! [[ "$BUDGET" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    echo "Error: Budget must be a valid number (e.g., 10.00)" >&2
    exit 1
fi

# Load API keys from .env file (one directory up from script location)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

if [ -f "$ENV_FILE" ]; then
    OWUI_API_KEY=$(grep -E '^OWUI_API_KEY=' "$ENV_FILE" | cut -d'=' -f2- | tr -d '"' | tr -d "'")
    LITELLM_MASTER_KEY=$(grep -E '^LITELLM_MASTER_KEY=' "$ENV_FILE" | cut -d'=' -f2- | tr -d '"' | tr -d "'")
    OWUI_API_BASE_URL=$(grep -E '^OWUI_API_BASE_URL=' "$ENV_FILE" | cut -d'=' -f2- | tr -d '"' | tr -d "'")
    LITELLM_API_BASE_URL=$(grep -E '^LITELLM_API_BASE_URL=' "$ENV_FILE" | cut -d'=' -f2- | tr -d '"' | tr -d "'")
fi

if [ -z "$OWUI_API_KEY" ]; then
    echo "Error: OWUI_API_KEY not found in $ENV_FILE" >&2
    exit 1
fi

if [ -z "$LITELLM_MASTER_KEY" ]; then
    echo "Error: LITELLM_MASTER_KEY not found in $ENV_FILE" >&2
    exit 1
fi

if [ -z "$OWUI_API_BASE_URL" ]; then
    echo "Error: OWUI_API_BASE_URL not found in $ENV_FILE" >&2
    exit 1
fi

if [ -z "$LITELLM_API_BASE_URL" ]; then
    echo "Error: LITELLM_API_BASE_URL not found in $ENV_FILE" >&2
    exit 1
fi

# URL-encode the email (handles @ and other special characters)
ENCODED_EMAIL=$(printf '%s' "$EMAIL" | jq -sRr @uri)

# Make the API call and store response
RESPONSE=$(curl -s -X 'GET' \
  "${OWUI_API_BASE_URL}/api/v1/users/search?query=${ENCODED_EMAIL}" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${OWUI_API_KEY}")

# Debug: show raw response
echo "DEBUG - User Response: $RESPONSE" >&2

# Extract the id
USER_ID=$(echo "$RESPONSE" | jq -r '.users[0].id')

# Check if we got a valid user ID
if [ "$USER_ID" = "null" ] || [ -z "$USER_ID" ]; then
    echo "Error: User not found" >&2
    exit 1
fi

echo "Found user ID: $USER_ID" >&2

# Update customer budget in LiteLLM
UPDATE_RESPONSE=$(curl -s -X POST "${LITELLM_API_BASE_URL}/customer/update" \
  -H "Authorization: Bearer ${LITELLM_MASTER_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{\"user_id\": \"${USER_ID}\", \"max_budget\": ${BUDGET}}")

echo "DEBUG - Update Response: $UPDATE_RESPONSE" >&2

# Check if update was successful
if echo "$UPDATE_RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    echo "Error updating budget: $(echo "$UPDATE_RESPONSE" | jq -r '.error')" >&2
    exit 1
fi

echo "Successfully set budget of $BUDGET for user $EMAIL (ID: $USER_ID)"

# Get customer info from LiteLLM
CUSTOMER_RESPONSE=$(curl -s -X 'GET' \
  "${LITELLM_API_BASE_URL}/customer/info?end_user_id=${USER_ID}" \
  -H "Authorization: Bearer ${LITELLM_MASTER_KEY}")

# Debug: show response
echo "DEBUG - Customer Response: $CUSTOMER_RESPONSE" >&2

# Extract budget_id from customer response
BUDGET_ID=$(echo "$CUSTOMER_RESPONSE" | jq -r '.litellm_budget_table.budget_id')

if [ "$BUDGET_ID" = "null" ] || [ -z "$BUDGET_ID" ]; then
    echo "Error: Could not extract budget_id from customer response" >&2
    exit 1
fi

echo "Found budget ID: $BUDGET_ID" >&2


# Update budget duration
BUDGET_UPDATE_RESPONSE=$(curl -s -X POST "${LITELLM_API_BASE_URL}/budget/update" \
  -H "Authorization: Bearer ${LITELLM_MASTER_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{\"budget_id\": \"${BUDGET_ID}\", \"budget_duration\": \"${BUDGET_DURATION}\"}")

echo "DEBUG - Budget Update Response: $BUDGET_UPDATE_RESPONSE" >&2

# Get customer info from LiteLLM
CUSTOMER_RESPONSE=$(curl -s -X 'GET' \
  "${LITELLM_API_BASE_URL}/customer/info?end_user_id=${USER_ID}" \
  -H "Authorization: Bearer ${LITELLM_MASTER_KEY}")

# Debug: show response
echo "DEBUG - Customer Response: $CUSTOMER_RESPONSE" >&2