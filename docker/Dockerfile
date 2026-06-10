# ---------- BASE ----------
FROM node:20-alpine AS base

WORKDIR /app

# zsh y bash para entorno interactivo
RUN apk add --no-cache zsh bash

# Activar corepack (usa Yarn Berry definido en .yarnrc.yml)
RUN corepack enable && corepack prepare yarn@stable --activate

# ---------- DEPENDENCIAS ----------
FROM base AS deps

# Copiar solo lo necesario para instalar dependencias
COPY app/package.json app/yarn.lock* app/.yarnrc.yml ./

# Bloqueamos la telemetría y seleccionamos la versión de Yarn
ENV YARN_ENABLE_TELEMETRY=0

# Instalar dependencias (NO usar "yarn add")
RUN yarn install

# ---------- DESARROLLO ----------
FROM deps AS dev

# Copiar el código (en dev se sobrescribe con volumen)
COPY app/src ./src

EXPOSE 3000

CMD ["yarn", "start"]

# ---------- PRODUCCIÓN ----------
FROM deps AS prod

# Copiar el código completo
COPY ./app/src ./app/src

EXPOSE 80

CMD ["yarn", "serve"]
