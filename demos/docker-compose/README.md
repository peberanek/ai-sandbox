# Docker Compose Demo

This demo provides a simple deployment using Docker Compose for testing purposes.

> [!WARNING]
> **Not for production use** - This setup contains hardcoded credentials and is intended for local development only.

## Prerequisites

1. Install and start [Docker Desktop](https://docs.docker.com/desktop/)

2. Clone this repository and navigate to this directory:
   ```sh
   git clone https://github.com/peberanek/ai-sandbox.git
   cd ai-sandbox/demos/docker-compose
   ```

## Getting Started

Start all services with Docker Compose:

```sh
docker compose up
```

The first run may take several minutes to pull and initialize all services.

### Access Points

Once running, the following services will be available:

- **Open WebUI**: http://127.0.0.1:3000
  - The first user to sign up becomes the administrator
  - Username: `admin`
  - Email: `admin@admin.com`  # TODO: change to `admin@example.com`
  - Password: `12345`
- **LiteLLM API**: http://127.0.0.1:4000
- **LiteLLM Admin UI**: http://127.0.0.1:4000/ui
  - Username: `admin`
  - Password: `sk-1234`

### Interacting with Ollama

You can interact with Ollama directly via Docker:

```sh
docker exec -it ollama ollama --help
docker exec -it ollama ollama pull gemma3:270m
```

## Configuration

### Open WebUI Setup

#### Connecting to LiteLLM

To connect Open WebUI to LiteLLM, follow the [official tutorial](https://docs.litellm.ai/docs/tutorials/openweb_ui):

1. Navigate to **Admin Panel > Settings > Connections** in Open WebUI
2. Set the _API Base URL_ to: `http://litellm:4000`

Note: The `ENABLE_FORWARD_USER_INFO_HEADERS` environment variable is already configured in `docker-compose.yaml`.
