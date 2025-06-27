# ---------- Etapa 1 · build ----------
FROM node:20-alpine AS builder

# 1. Habilita openssl y python para node-gyp (si algún dep. lo necesita)
RUN apk add --no-cache make gcc g++ python3

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev  # instala sólo dependencias runtime
COPY tsconfig*.json nest-cli.json ./
COPY src ./src
RUN npm run build      # genera dist/ con `nest build`

# ---------- Etapa 2 · runtime ----------
FROM node:20-alpine AS runner
WORKDIR /app

# Copia sólo lo necesario desde builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json

ENV NODE_ENV=production
EXPOSE 8080
CMD [ "node", "dist/main.js" ]
