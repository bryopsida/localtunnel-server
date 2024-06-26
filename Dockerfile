FROM node:lts-alpine AS build-base
RUN apk add --update --no-cache \
  python3 \
  make \
  g++ \
  bash \
  gcc

FROM build-base AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build --if-present

FROM build-base AS libraries
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit-dev

FROM node:lts-alpine
RUN apk add --update --no-cache dumb-init
ENV NODE_ENV production
USER node
WORKDIR /usr/src/app
COPY --chown=node:node --from=libraries /usr/src/app/node_modules /usr/src/app/node_modules
COPY --chown=node:node --from=build /usr/src/app/ /usr/src/app/
EXPOSE 3000
CMD ["dumb-init", "/usr/src/app/bin/server"]
