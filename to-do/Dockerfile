FROM node:current-alpine3.18

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY ./package.json /home/node/app/

RUN npm install

COPY ./ /home/node/app/

EXPOSE 3005

CMD [ "npm", "run", "start:development" ]
