# AI Sandbox

Deployment guide for an AI sandboxing application developed for Charles University ("UK AI Sandbox")

## Installation

Prerequisites:
* A Linux virtual machine for hosting (tested on Ubuntu 24.04.1 LTS (server))
* SSL certificate

Install Docker (including Docker Compose).

Install [Nvidia Container Toolkit](https://github.com/ollama/ollama/blob/main/docs/docker.md) (required for Nvidia GPUs).

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

Review `docker-compose.yml` and, if necessary, update it according to your needs.

Start Docker Compose:
```bash
docker compose up -d
```

Once the compose is up and running, the web interface ([Open WebUI](https://docs.openwebui.com/)) should be available at https://YOUR_DOMAIN_OR_IP.

## Configuration: WIP

### Open WebUI

Log in the Open WebUI. The first user that logs in becomes administrator (note: admin priviledges of this user cannot be removed).

TODO: configure models, external connections, allow access to other users
