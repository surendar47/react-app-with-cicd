# Choosing the base image as the build stage:
FROM node:16-alpine as build

# Choosing working directory for the application:
WORKDIR /app

# Copying the package.json file to app directory and installing packages:
COPY package.json .
RUN npm install

# Copying the rest of application code to the working directory:
COPY . .

# Building the application:
RUN npm run build

# Second stage base image:
FROM nginx:alpine

# Setting the working directory for this base image:
WORKDIR /usr/share/nginx/html/

# Copying the first stage code to this stage:
COPY --from=build /app/build .

# Exposing the application:
EXPOSE 80

# Executing the application after creating image:
CMD ["nginx", "-g", "daemon off;"]

