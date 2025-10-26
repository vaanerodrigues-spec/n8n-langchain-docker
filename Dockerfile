# Use a imagem oficial do n8n como base
FROM docker.n8n.io/n8nio/n8n:latest

# Mude para o usuário root temporariamente para instalar pacotes do sistema
USER root

# A imagem oficial do n8n é baseada em Alpine Linux, então usamos 'apk'
# Instale as dependências de compilação necessárias para módulos nativos (como sqlite3)
RUN apk add --no-cache python3 make g++

# IMPORTANTE: Instale o pacote como root (não como usuário node)
RUN npm install -g @n8n/n8n-nodes-langchain

# DEPOIS da instalação, volte para o usuário 'node' (o usuário padrão do n8n para segurança)
USER node

# O contêiner n8n será iniciado com o comando padrão da imagem base
