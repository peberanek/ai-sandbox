# AI Sandbox

Opinionated deployment guide for an AI sandbox, based on [Open WebUI](https://docs.openwebui.com/) and [Ollama](https://ollama.com/)

![Opening Screenshot](assets/opening_screenshot.png)

## Installation

> [!NOTE]
> This guide covers server deployment. If you prefer to run the sandbox on your own computer, follow [the desktop deployment guide](desktop_deployment.md).

Prerequisites:
* A Linux server for hosting (tested on Ubuntu 24.04.1 LTS (server))
* SSL certificate for HTTPS

Install [Docker](https://docs.docker.com/engine/install/ubuntu/) (make sure to include Docker Compose).

If you have Nvidia GPU, install Nvidia Container Toolkit. You can follow instructions in the [Ollama documentation](https://github.com/ollama/ollama/blob/main/docs/docker.md).

Install git:
```bash
sudo apt install git
```

Clone this repository:
```bash
git clone https://github.com/peberanek/ai-sandbox.git
cd ai-sandbox
```

Copy your SSL certificate to `ssl/`:
```bash
mkdir ssl
cp path/to/your_ssl_certificate ssl/nginx.crt  # Nginx expects this filename!
cp path/to/your_ssl_private_key ssl/nginx.key  # Nginx expects this filename!
```

Update `conf.d/open-webui.conf` according to your network setup (see TODO in the file).

If necessary, update `docker-compose.yml` according to your setup (see TODO in the file).

Pull and run the Docker compose (this may take some time):
```bash
docker compose up -d
```

Once the compose is running, the web interface (Open WebUI) should be available at https://YOUR_DOMAIN_OR_IP. It may take some time to Nginx to serve it.

## Configuration: WIP

### Open WebUI

> [!IMPORTANT]
> **Admin Creation**: The first account created on Open WebUI gains Administrator privileges, controlling user management and system settings. (Administrator priviledges of this account cannot be removed.)
>
> **User Registrations**: Subsequent sign-ups start with Pending status, requiring Administrator approval for access. (New sign-ups are disabled by default. Click on your name in the bottom left corner, then see _Admin panel > Settings > General Settings > Enable New Sign Ups_)

TODO: configure models, external connections
