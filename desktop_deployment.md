# Desktop Deployment

> [!NOTE]
> For minimal system requirements, see this [discussion](https://github.com/open-webui/open-webui/discussions/736).

## Option 1: Open WebUI as a Python package

Install [Ollama](https://ollama.com/download).

Run Open WebUI using [uv (modern high-performace dependency manager for Python)](https://docs.astral.sh/uv/getting-started/installation/):
```bash
uvx --python 3.11 open-webui serve
```

(Of course, instead of using uv, you can install it via pip: `pip install --user open-webui`)

Open WebUI should detect and connect to the running Ollama instance automatically. For further information consult [the documentation](https://docs.openwebui.com/).

## Option 2: Docker

Follow the [installation guide for Open WebUI](https://docs.openwebui.com/getting-started/quick-start/).
