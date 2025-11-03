# Running Demo Instance with Docker Compose

## Prerequisites

1. Install and start [Docker Desktop](https://docs.docker.com/desktop/)

1. If you haven't done it already, clone this repository and change to this directory:
    ``` sh
    git clone https://github.com/peberanek/ai-sandbox.git
    cd ai-sandbox/demos/docker-compose
    ```

## Run Docker Compose

> [!WARNING]  
> Don't use for production deployment. There are hardcoded credential in the `docker-compose.yaml`.

From within this directory run:

``` sh
docker compose up
```

It may take some time to pull and start up all the services. Open WebUI should be available at http://127.0.0.1:3000 (the first user that signs in becomes administrator). LiteLLM should be available at http://127.0.0.1:4000/ (admin UI: http://127.0.0.1:4000/ui/; username: `admin`, password: `sk-1234`).

You may interact with Ollama via Docker:

``` sh
docker exec -it ollama ollama --help
```

## Open WebUI Settings

> [!NOTE]  
> The initial start of the Open WebUI may be slow, as it downloads additional components.

### Connecting to LiteLLM

Follow the [tutorial](https://docs.litellm.ai/docs/tutorials/openweb_ui):

* When setting up the connection - preferably via _Admin Panel > Settings > Connections_ - set proxy URL to **`http://litellm:4000`**.
* `ENABLE_FORWARD_USER_INFO_HEADERS` env var is already set in the `docker-compose.yaml`.
