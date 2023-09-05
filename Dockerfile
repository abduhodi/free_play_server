FROM node:alpine as builder
WORKDIR /app
COPY /*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npx prisma generate

FROM node:alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD [ "npm", "run", "start:dev" ]