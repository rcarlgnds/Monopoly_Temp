FROM node:22-slim AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

FROM node:22-slim AS runner

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next

EXPOSE 3000

CMD ["npm", "start"]