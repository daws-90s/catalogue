FROM node:20.20.2-alpine3.22 AS builder
# creates /app and set the directory to /app
WORKDIR /app
COPY package.json .
COPY *.js .
# node_modules
RUN npm install 

FROM node:20.20.2-alpine3.22
WORKDIR /app
EXPOSE 8080
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
RUN addgroup -S roboshop && adduser -S -G roboshop roboshop && \
    chown -R roboshop:roboshop /app
COPY --from=builder /app /app
USER roboshop
CMD ["node", "server.js"]

# FROM node:20
# # this creates /app and move there
# WORKDIR /app
# COPY package.json .
# COPY *.js .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node", "server.js"]