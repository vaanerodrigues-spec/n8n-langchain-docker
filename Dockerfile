FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Instalar dependências
RUN apk add --no-cache python3 make g++

# Remover cópias duplicadas da imagem base
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/n8n-nodes-langchain || true
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@devlikeapro || true

# Instalar AMBOS os pacotes customizados
RUN npm install -g @n8n/n8n-nodes-langchain @devlikeapro/n8n-nodes-chatwoot

# Verificação
RUN echo "=== VERIFICANDO INSTALAÇÕES ===" && \
    npm list -g @n8n/n8n-nodes-langchain && \
    npm list -g @devlikeapro/n8n-nodes-chatwoot && \
    echo "=== FIM VERIFICAÇÃO ==="

USER node
