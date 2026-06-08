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

# Copiar código (aunque luego se sobrescribe con volumen)
COPY ./src ./src

# Bloqueamos la telemetría y seleccionamos kla versión de Yarn
ENV YARN_ENABLE_TELEMETRY=0
RUN yarn add

# ---------- DESARROLLO ----------
FROM deps AS dev

EXPOSE 3000

CMD ["yarn", "start"]

# ---------- PRODUCCIÓN ----------

# Muy parecido a desarrollo, la principal diferencia es que no usamos watch porque en principio no
#    vamos a estsar cambiando el cofigon en produccion.

FROM deps AS prod

EXPOSE 80

CMD ["yarn", "serve"]
