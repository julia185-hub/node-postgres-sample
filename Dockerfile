# Use an official Node.js runtime as a build stage
FROM node:16-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy package files to install dependencies first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build your application if you have a build step (optional)
# RUN npm run build

# Final stage: run the application
FROM node:16-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/src/app ./

# Expose the port the app runs on (adjust if necessary)
EXPOSE 3000

# Define environment variables if needed (example for PostgreSQL)
# ENV PGHOST=your_postgres_host \
#     PGUSER=your_postgres_user \
#     PGPASSWORD=your_postgres_password \
#     PGDATABASE=your_postgres_db

# Start the application
CMD ["npm", "start"]
