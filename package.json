FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine

WORKDIR /app

COPY --from=build /app ./

RUN npm install --production

ENV PORT 8080

EXPOSE 8080

CMD ["npm", "start"]
