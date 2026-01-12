#Build stage
FROM node:25-alpine3.22 as build
WORKDIR /app
COPY package*.json .
RUN npm install 
COPY . .
RUN npm run build
#Production stage
FROM nginx:1.29.4 as production
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
