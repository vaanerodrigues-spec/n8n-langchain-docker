FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Instalar TODAS as dependências necessárias para compilação
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    gcc \
    libc-dev \
    sqlite-dev \
    node-gyp \
    git

# Configurar Python para node-gyp
RUN npm config set python python3

# Limpar instalações anteriores
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/@n8n/n8n-nodes-langchain || true

# Configurar npm para compilação
RUN npm config set legacy-peer-deps true
RUN npm config set audit false
RUN npm config set fund false

# INSTALAR SQLITE3 PRIMEIRO (compilado)
RUN npm install -g sqlite3 --build-from-source

# INSTALAR LANGCHAIN (agora com sqlite3 funcionando)
RUN npm install -g @n8n/n8n-nodes-langchain --legacy-peer-deps --force

# INSTALAR CHATWOOT
RUN npm install -g @devlikeapro/n8n-nodes-chatwoot --legacy-peer-deps --force

# Verificar se os binários foram criados
RUN echo "=== VERIFICANDO BINÁRIOS ===" && \
    find /usr/local/lib/node_modules -name "node_sqlite3.node" -type f && \
    echo "=== VERIFICANDO PACOTES ===" && \
    npm list -g --depth=0 | grep -E "(langchain|chatwoot|sqlite3)" && \
    echo "=== VERIFICAÇÃO CONCLUÍDA ==="

USER node
    echo "=== VERIFI
