# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM node:lts-alpine as production-stage
COPY --from=build-stage /app/dist /app
EXPOSE 3000
CMD ["npm", "run", "start"]

