FROM node:14-alpine3.10
WORKDIR /opt/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test
EXPOSE 8080
CMD ["npm", "start"]
