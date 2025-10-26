FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Instalar dependências
RUN apk add --no-cache python3 make g++

# Limpar duplicatas
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/n8n-nodes-langchain || true

# Configurar npm para ser mais tolerante
RUN npm config set legacy-peer-deps true
RUN npm config set audit false
RUN npm config set fund false

# Instalar Langchain forçando resolução de dependências
RUN npm install -g @n8n/n8n-nodes-langchain --force --legacy-peer-deps

# Instalar Chatwoot
RUN npm install -g @devlikeapro/n8n-nodes-chatwoot --force --legacy-peer-deps

USER node
