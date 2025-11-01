# AI Sandbox

Open source platform for flexible centralized access to generative AI

## Motivation

For Czech universities, establishing institution‑wide agreements with providers such as OpenAI or Anthropic can be surprisingly difficult. As a result, deploying tools like ChatGPT Edu may not be a viable option.

Other solutions, such as Microsoft Copilot or Google Gemini—included for free within broader product packages—typically lack advanced features tailored for teaching or research.

Users are also concerned about how chatbot providers process and store their data. This is especially true for free services, which often use submitted inputs for further model training. As a result, both institutions and individuals seek more transparent and secure solutions — ideally ones that allow sensitive data to stay under their own control or within on‑premise deployments of open weights models.

Finally, there is growing interest in using AI models through APIs. However, managing accounts and settings across multiple providers can be complicated and time‑consuming.

**AI Sandbox** explores and uses existing open‑source projects to address these needs. It builds on similar university initiatives abroad ([Harvard AI Sandbox](https://www.huit.harvard.edu/ai-sandbox), [Stanford AI Playground](https://uit.stanford.edu/aiplayground)) and in the Czech Republic ([CERIT-SC Chat AI](https://docs.cerit.io/en/docs/web-apps/chat-ai)).

## Try it

1. If you are a member of a Czech academic institution, complete the [MetaCentrum registration](https://metavo.metacentrum.cz/cs/application/index.html). Once your registration is approved, you can [log in to **Chat AI**](https://chat.ai.e-infra.cz/) mentioned above. Models can also be accessed via API — see the [documentation for details](https://docs.cerit.io/en/docs/web-apps/chat-ai).

2. If you want to run it on your own hardware, see the [`demos/docker-compose`](./demos/docker-compose) directory for setup instructions.  

3. If you are considering deploying an instance for your organization, you can contact [e‑INFRA CZ](https://docs.e-infra.cz/) to [request a dedicated clone](https://blog.e-infra.cz/blog/chat-ai/#dedicated-webui-clones).

## Overview

![A simple overview of the AI Sandbox](/assets/ai_sandbox.drawio.png)

## Components

### Chatbot

The chatbot component uses [**Open WebUI**](https://docs.openwebui.com/), an open‑source web interface for interacting with large language models. It allows users to chat with both open weights and proprietary models (e.g., gpt‑oss, Llama, GPT‑5, Claude, Gemini), create custom assistants, or use built‑in tools such as web search, code interpreter, and image generation. Its functionality can be extended via custom tools, functions and pipelines and has support for SSO.

> [!NOTE]  
> Other university projects, such as the Harvard AI Sandbox and Stanford AI Playground, use [LibreChat](https://www.librechat.ai/docs). At the time of evaluation, however, it lacked features such as an admin UI for user management and had not been tested with this setup.

### AI API Gateway

The AI API Gateway component uses [**LiteLLM**](https://docs.litellm.ai/docs/), an open‑source Python SDK and proxy server that connects to a wide range of LLM providers, including on‑premise deployments. It supports user self‑service, cost limits, and usage tracking.

### Inference

#### On-premise

The most common options are [**Ollama**](https://ollama.com/), [**vLLM**](https://docs.vllm.ai/en/stable/) or [**SGLang**](https://docs.sglang.ai/), each with its own trade‑offs and limitations. For a detailed overview and real‑world experience from a production deployment, see the e‑INFRA CZ articles: [part 1](https://blog.e-infra.cz/blog/run-llm/) and [part 2](https://blog.e-infra.cz/blog/run-llm2/).

#### Cloud Providers

For Czech academic institutions, a practical option may be to contact [**e‑INFRA CZ**](https://docs.e-infra.cz/) and request access to their hosted models via API. Alternatively, large providers such as [Microsoft Azure AI Foundry](https://ai.azure.com/), [Google Vertex AI Platform](https://cloud.google.com/vertex-ai), or platforms like [OpenRouter](https://openrouter.ai/) also offer model inference services. _However, their suitability — particularly in terms of data privacy and security — should be carefully evaluated._

## Roadmap

* **RAG Pipelines**: Although Open WebUI provides basic RAG functionality to enhance model inference with external data (e.g., from documents), finding the right combination of an embedding model — especially one that performs well with smaller languages like Czech — and a suitable vector database has proved challenging. Currently, e‑INFRA CZ uses OpenSearch with qwen3‑embedding‑4b, but the results are not yet ideal. For some details, see their article [AI Docs Search](https://blog.e-infra.cz/blog/embedders/). This remains an area of ongoing research.

* **Cost tracking and limiting**: Open WebUI currently lacks features for cost tracking and spending limits on paid models. Such functionality needs to be implemented to prevent uncontrolled costs, either through built‑in LiteLLM features (preferred) or with a custom extension such as the [Open WebUI Credit System](https://github.com/kivzcu/openwebui-credit-system).  

* **User Guides**: For new users, working with the Open WebUI or LiteLLM interface can be challenging. A simple yet comprehensive user guide is needed. The AI Team of the Charles University Central Library is preparing a Czech version.  

## Contact

If you are interested in collaborating on this project, feel free to contact the AI Team of the Charles University Central Library at **ai@cuni.cz**.
