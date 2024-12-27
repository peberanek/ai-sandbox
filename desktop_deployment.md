# Desktop Deployment

> [!NOTE]
> Running advanced models of generative AI requires powerful hardware. You may run some smaller models (like [Llama3.2](https://ollama.com/library/llama3.2)) even without GPU. However, the output generation could be slow. At least 16 GB of RAM is recommended.

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
