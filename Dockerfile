FROM node:16-alpine@sha256:004dbac84fed48e20f9888a23e32fa7cf83c2995e174a78d41d9a9dd1e051a20

RUN apk update && apk add g++ make python3 curl

RUN mkdir -p /app
WORKDIR /app

COPY package.json package-lock.json ./
RUN --mount=type=cache,uid=1000,gid=1000,target=/home/node/.npm \
    npm ci
COPY . .
RUN npm run build

CMD [ "node", "lib/main.js" ]
