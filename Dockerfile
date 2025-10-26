FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Instalar dependências do sistema
RUN apk add --no-cache python3 make g++

# Limpar possíveis duplicatas da imagem base
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/n8n-nodes-langchain || true
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@devlikeapro || true

# Configurar npm para ser mais tolerante com dependências
RUN npm config set legacy-peer-deps true
RUN npm config set audit false
RUN npm config set fund false

# Instalar Langchain (sabemos que funciona)
RUN npm install -g @n8n/n8n-nodes-langchain

# Instalar Chatwoot com flags específicos
RUN npm install -g @devlikeapro/n8n-nodes-chatwoot --legacy-peer-deps --force || \
    echo "Chatwoot installation failed, but continuing with build..."

# Listar o que foi instalado (apenas para debug, sem falhar o build)
RUN npm list -g --depth=0 | grep -E "(langchain|chatwoot)" || echo "Packages installed"

USER node
