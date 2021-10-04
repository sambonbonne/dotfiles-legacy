FROM docker.io/node:16.8.0

RUN npm install -g typescript typescript-language-server

ENTRYPOINT ["typescript-language-server"]
