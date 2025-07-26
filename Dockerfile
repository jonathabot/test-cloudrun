# Etapa de build
FROM node:18-alpine AS build

WORKDIR /app

# Copia apenas os arquivos de dependência primeiro
COPY package*.json ./
RUN npm install

# Depois copia o restante do código
COPY . .

# Gera o build de produção do Next.js
RUN npm run build

# Etapa final (imagem leve para produção)
FROM node:18-alpine

WORKDIR /app

# Copia tudo da etapa de build (inclusive .next, public etc.)
COPY --from=build /app ./

# Instala apenas dependências de produção
RUN npm install --production

# Define a porta para o Cloud Run
ENV PORT 8080
EXPOSE 8080

# Inicia o Next.js com a porta definida
CMD ["npm", "start"]
