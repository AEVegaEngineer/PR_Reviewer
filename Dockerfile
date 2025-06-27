# ---------- Etapa 1 · build ----------
FROM node:20-alpine AS builder

RUN apk add --no-cache make gcc g++ python3
WORKDIR /app

# 1) Instala TODAS las dependencias (incluidas las dev)
COPY package*.json ./
RUN npm ci

# 2) Copia el código y compila
COPY tsconfig*.json nest-cli.json ./
COPY src ./src
RUN npx nest build

# ---------- Etapa 2 · runtime ----------
FROM node:20-alpine AS runner
WORKDIR /app

# Copia solo node_modules de prod (prune)
COPY --from=builder /app ./
RUN npm prune --omit=dev

ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "dist/main.js"]
