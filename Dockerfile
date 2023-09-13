# syntax=docker/dockerfile:1

# Define the base image with Node.js
FROM node:14

# Set the working directory
WORKDIR /app

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Define the "build" stage
FROM nginx:alpine AS build

# Build your application
RUN npm run build

# Define a "prod" stage
FROM nginx:alpine AS prod

# Copy the built application from the "build" stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
