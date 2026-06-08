# ---------- BASE ----------
FROM node:20-alpine AS base

WORKDIR /app

# zsh para entorno interactivo
RUN apk add --no-cache zsh bash

# Activar corepack (usa Yarn Berry definido en .yarnrc.yml)
RUN corepack enable && corepack prepare yarn@stable --activate

# ---------- DEPENDENCIAS ----------
FROM base AS deps

# Copiar solo lo necesario para instalar dependencias
# El * despues de yarn.lock* es por sui el archivo no existe, que no falle
COPY ./package.json ./yarn.lock* ./.yarnrc.yml ./

# Bloqueamos la telemetría y seleccionamos kla versión de Yarn
ENV YARN_ENABLE_TELEMETRY=0
RUN yarn install

# ---------- DESARROLLO ----------
FROM base AS dev

# Nos traemos las dependencias y la cionfiguracion de Yarn Berrry desde la etapa "deps"
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/.yarn ./.yarn
COPY --from=deps /app/.yarnrc.yml ./

# Copiar código (aunque luego se sobrescribe con volumen)
COPY ./src ./src

EXPOSE 3000

# Shell por defecto
SHELL ["/bin/zsh", "-c"]

# Forzamos la ruta absoluta interna para evitar perdidas del --watch
#CMD ["node", "--watch", "./src/server.js"]
CMD ["yarn", "start"]

# ---------- PRODUCCIÓN ----------

# Muy parecido a desarrollo, la principal diferencia es que no usamos watch porque en principio no
#    vamos a estsar cambiando el cofigon en produccion.

FROM base AS prod

ENV NODE_ENV=production

COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/.yarn ./.yarn
COPY --from=deps /app/.yarnrc.yml ./

COPY . .

EXPOSE 3000

# Shell por defecto
SHELL ["/bin/zsh", "-c"]

# CMD por defecto
# CMD ["node", "/app/src/server.js"]
CMD ["yarn", "serve"]
