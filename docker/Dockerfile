# ---------- BASE ----------
FROM node:20-alpine AS base

WORKDIR /app

# Shells opcionales
RUN apk add --no-cache zsh bash

# Habilitar corepack y xnpm
RUN corepack enable && npm install -g xnpm

# ---------- DEPENDENCIAS ----------
FROM base AS deps

# Copiar archivos necesarios para instalar dependencias
COPY package.json package-lock.json .npmrc ./

# Instalar dependencias
RUN xnpm install

# ---------- DESARROLLO ----------
FROM deps AS dev

# En dev, el código se monta por volumen, no hace falta copiar src
EXPOSE 3000
CMD ["xnpm", "start"]

# ---------- PRODUCCIÓN ----------
FROM deps AS prod

# Copiar el código completo
COPY ./src ./src

EXPOSE 3000
CMD ["xnpm", "serve"]
