# build stage
FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package*.json ./
RUN npm i

COPY . .
RUN npm run build

# production stage
FROM node:lts-alpine as production-stage

WORKDIR /app

COPY --from=build-stage /app/dist .
COPY --from=build-stage /app/package.json .

RUN npm i

EXPOSE 3000
CMD ["node", "main.js"]

