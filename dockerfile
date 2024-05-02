# Use a multi-stage build with Node.js 14 Alpine as the base image
FROM --platform=linux/amd64 node:21-alpine as base

# Intermediate stage for building the application
FROM base as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . .

# Install dependencies
RUN npm install

# Build the Next.js application
RUN npm run build

# Final stage for production
FROM base as production

# Set the working directory inside the container
WORKDIR /app

# Set environment variable for production
ENV NODE_ENV=production

# Copy built assets from the builder stage into the production stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/public ./public

# Command to start the application
CMD npm start