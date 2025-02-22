FROM node:alpine
WORKDIR /app
COPY ./package.json ./
RUN npm install build
COPY . .
EXPOSE 8081
CMD ["node", "server.js"]
