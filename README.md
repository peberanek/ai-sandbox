# AI Sandbox
An open-source implementation of the [Harvard AI Sandbox](https://huit.harvard.edu/ai-sandbox). This project aims to provide a secure, modular environment for working and experimenting with generative AI.

![Opening Screenshot](assets/open_webui.gif)
_Above: Open WebUI serving as graphical user interface of the AI Sandbox._

Some components (see below) can be installed on desktop for maximum privacy (Open WebUI + Ollama), or on a server for multi-user environments. The system supports local models (like Llama, Gemma or DeepSeek), or external models (like ChatGPT-4o, GPT-4.1 or o3) via OpenAI-compatible connections.

## Components
### Graphical User Interface
#### Open WebUI
Popular, feature-rich Web UI (chatbot interface) for interacting with large language models. Installable both on desktop (single user, see [minimum system requirements](https://github.com/open-webui/open-webui/discussions/736)) and on a server (multi user).
* [Installation](https://docs.openwebui.com/getting-started/quick-start/)
* [Documentation](https://docs.openwebui.com/)

##### Selected Features
* Chat with local models like Llama, Gemma or DeepSeek (via Ollama or vLLM, see section Inference Servers)
* Chat with external models like ChatGPT-4o or o3 via [OpenAI connections](https://docs.openwebui.com/getting-started/quick-start/starting-with-openai) (or [OpenAI-compatible](https://docs.openwebui.com/getting-started/quick-start/starting-with-openai-compatible)). Other models (like Claude or Gemini) may be connected via an LLM proxy or via [custom Functions](https://openwebui.com/functions) and [Pipelines](https://github.com/open-webui/pipelines) (Functions and Pipelines, however, may not support all features and may be harder to maintain because of changing APIs)
* Support for [SSO](https://docs.openwebui.com/features/sso/)
* Build [Models (assistants)](https://docs.openwebui.com/features/workspace/models) with [knowledge](https://docs.openwebui.com/features/workspace/knowledge) (via [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation))
* Built-in tools like [web search](https://docs.openwebui.com/category/-web-search), code interpreter and [image generation](https://docs.openwebui.com/tutorials/images)
* Extensible via custom [Tools, Functions and Pipelines](https://docs.openwebui.com/features/plugin/)

##### Notes
> [!IMPORTANT]
> The first account created gains Administrator privileges, controlling user management and system settings. As a security feature, *these privileges cannot be removed and the account cannot be deleted*.

* If installing Open WebUI for a single user on a desktop, [setting `WEBUI_AUTH` env var to `False`](https://docs.openwebui.com/getting-started/env-configuration/#webui_auth) spares the user the need to authenticate.

### Inference Servers
#### Ollama
Well integrated with Open WebUI. Not optimized for multiuser environments (consider using vLLM instead).
* [Installation](https://github.com/ollama/ollama/blob/main/README.md)
* [Documentation](https://github.com/ollama/ollama/tree/main/docs#documentation)
* [Models](https://ollama.com/search)

#### vLLM
Fast LLM inference. Installation and model deployment may be more complex than Ollama.
* [Installation](https://docs.vllm.ai/en/stable/getting_started/installation/index.html)
* [Documentation](https://docs.vllm.ai/en/stable/)

## Roadmap
* Implementation of spending limits for external models (in progress)
* Finding an optimal embedding model for Czech
* Verifying feasibility of [LiteLLM as LLM proxy server for Open WebUI](https://docs.litellm.ai/docs/tutorials/openweb_ui)
