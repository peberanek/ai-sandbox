# Spending Management for Open WebUI

_Contributors: Luděk Svoboda (Faculty of Arts, Charles University)_

By default, Open WebUI does not limit user spending on paid models. However, spending limits can be set via LiteLLM, and this guide walks you through the process.

> [!NOTE]
> In the LiteLLM documentation, _End User_ and _Customer_ mean the same thing.

(Based on [Connecting Open WebUI to LiteLLM](https://docs.litellm.ai/docs/tutorials/openweb_ui) and [LiteLLM Customers / End-User Budgets](https://docs.litellm.ai/docs/proxy/customers))

## Configure LiteLLM

### Create a new budget

1. Log into your LiteLLM instance Admin UI.
1. Go to _Budgets_ and click _+ Create Budget_.
1. Set _Budget ID_ to `default_customer_budget`
1. In _Optional Settings_, set _Max Budget (USD)_ to _0.01_ (for testing purposes) and _Reset Budget_ to _Monthly_.

### Set the new budget as default

1. Add the following settings to your existing LiteLLM `config.yaml`:
    ```yaml
    litellm_settings:
      max_end_user_budget_id: "default_customer_budget"

    general_settings:
      user_header_mappings:
        - header_name: X-OpenWebUI-User-Id  # uses internal Open WebUI user ID to track individual users
            litellm_user_role: customer
    ```

    > [!NOTE]
    > You may choose other headers, like `X-OpenWebUI-User-Email` or `X-OpenWebUI-User-Name`. However, note that users can modify their own names, and administrators can modify both user names and emails. This would create a new customer with a fresh budget.

1. **Reset the LiteLLM instance** to reload the config file.

### Configure a Virtual Key for Open WebUI

1. For easier cost tracking, create a dedicated Team:
    1. Go to _Teams_ and click _+ Create New Team_.
    1. Set _Team Name_ to `Open WebUI Prod`.
    1. In _Models_ select some paid models.
    1. Click _Create Team_.
1. Create a Virtual Key:
    1. Go to _Virtual Keys_ and click _+ Create New Key_.
    1. For _Owned By_ select _Service Account_.
    1. In _Team_ select `Open WebUI Prod`.
    1. Set _Service Account ID_ to `Open WebUI Prod SA`.
    1. In _Models_ select a paid model.
    1. To limit the key permissions, set _Key Type_ to _LLM API_.
    1. Click _Create Key_. **Save the key**, you will need it in the next step.

## Configure Open WebUI

### Connect Open WebUI to LiteLLM

1. Log into your Open WebUI instance (requires `admin` role).
1. Click on your user icon in the bottom left corner and click _Admin Panel_.
1. Go to _Settings_, then to _Connections_.
1. In _OpenAI API_ click _**+**_ (Add Connection):
    1. _URL_: The URL of your LiteLLM instance
    1. _Auth_: Select _Bearer_ and paste in the LiteLLM Virtual Key from the previous section.
    1. Click _Save_.
1. New model(s) should now be available in _Admin Panel_ > _Settings_ > _Models_.

### Enable User Info Headers in Open WebUI

1. Set the following environment variable for Open WebUI:
    ```sh
    ENABLE_FORWARD_USER_INFO_HEADERS=True
    ```

1. **Reset the Open WebUI instance** to reload the config.

## Test it

In the Open WebUI chat interface, select the paid model configured above and send it a message `Hi`. In the LiteLLM admin UI, in _Logs_, you should see your request with _End User_ set to your internal user ID from Open WebUI. As the conversation continues and the budget limit is hit, LiteLLM returns an error and the model cannot be called.

You can discover your internal user ID via the command line. See [API Endpoints](https://docs.openwebui.com/getting-started/api-endpoints/#authentication) for how to get an API key. Also, you need to _Enable API Keys_ in _Admin Panel_ > _Settings_ > _General_ and enable it for your group (in _Admin Panel_ > _Users_ > _Groups_ > _Default permissions_):
```sh
curl -H 'Authorization: Bearer YOUR-OPENWEBUI-API-KEY' \
  'YOUR-OPENWEBUI-INSTANCE-URL/api/v1/users/all'
```

> [!IMPORTANT]
> Surprisingly, all models _for the particular user_ (connected via LiteLLM) disappear from the model selection once the budget limit is hit. It is a known issue with possible workarounds, see [Known Caveats and Issues](#known-caveats-and-issues) below.

## Assign user to a different budget

In LiteLLM Admin UI, create another budget (see [Create a new budget](#create-a-new-budget) above):
* _Budget ID_: `admin_customer_budget`
* _Optional Settings_:
    * _Max Budget (USD)_: e.g. _10.00_
    * _Reset Budget_: _Monthly_.

**For discovering user IDs, see the section above.**

If the user ID is already in the LiteLLM logs (the API key needs management permissions - the default for new API keys):
```sh
curl -X POST 'YOUR-LITELLM-INSTANCE-URL/customer/update' \
  -H 'Authorization: Bearer YOUR-LITELLM-API-KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "user_id": "USER-ID",
    "budget_id": "admin_customer_budget"
  }'
```

For a new end user (not yet in LiteLLM logs):
```sh
curl -X POST 'YOUR-LITELLM-INSTANCE-URL/customer/new' \
  -H 'Authorization: Bearer YOUR-LITELLM-API-KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "user_id": "USER-ID",
    "budget_id": "admin_customer_budget"
  }'
```

## See Spending per Customer

You can view [Customer Usage](https://docs.litellm.ai/docs/proxy/customer_usage) in LiteLLM `v1.80.10` or above (it should be available in `v1.80.8-stable`, but it is not).

## Known Caveats and Issues

* When an Open WebUI user hits the budget limit, they lose access to all models connected via LiteLLM until the budget resets (e.g., monthly). This also applies to API access via Open WebUI. This is problematic when you provide free (no-cost) models hosted on-premises.
    * [LiteLLM blocks free (no cost) models when budget is exceeded](https://github.com/BerriAI/litellm/issues/14004)
        * Possible workaround: use a different LiteLLM instance without budgets for hosting free models, or connect to your inference servers directly without LiteLLM if observability is not an issue.
* [By default, the server checks for resets every 10 minutes to minimize DB calls.](https://docs.litellm.ai/docs/proxy/users#reset-budgets) This may cause an unexpected delay before a budget change applies. To change the check frequency, set the option below (e.g., to 1 second):
    ```yaml
    general_settings: 
      proxy_budget_rescheduler_min_time: 1
      proxy_budget_rescheduler_max_time: 1
    ```
* Setting _Reset Budget_ in the Budget creation dialog in the Admin UI effectively sets `30d`, so the reset will likely not occur exactly at the end of the month.
