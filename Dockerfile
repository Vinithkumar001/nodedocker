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

# Build your application
RUN npm run build

# Define a "dev" stage
FROM nginx:alpine AS dev

# Copy the built application from the "build" stage
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
