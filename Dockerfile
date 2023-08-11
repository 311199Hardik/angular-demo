FROM node:20.3.0 as build

RUN mkdir /app 

WORKDIR /app 

COPY package.json ./

COPY . . 

RUN npm install 


RUN npm run build

RUN ls -la

FROM nginx as runtime
COPY --from=build /app/dist/my-app /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ['/usr/share/nginx/html']

