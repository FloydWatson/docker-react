# install dependencies and npm build in builder phase
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# run nginx
FROM nginx
# app/build is the file we are copying from builder. /usr/share is nginx default folder 
COPY --from=builder /app/build /usr/share/nginx/html
# do not need run. nginx will run automatically