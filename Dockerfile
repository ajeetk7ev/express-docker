# Stage 1: Build & Install All Dependencies
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files first to leverage Docker layer caching
COPY package*.json ./

# Install ALL dependencies (including devDependencies needed for build)
RUN npm ci

# Copy rest of the application source code
COPY . .

# Build application if needed (e.g., TypeScript compile, bundling)
# RUN npm run build
CMD ["node", "server.js"]

# Stage 2: Production Execution
# FROM node:22-alpine AS production

# WORKDIR /app

# Set production environment
# ENV NODE_ENV=production

# Copy package files to install production-only dependencies
# COPY package*.json ./

# # Install ONLY production dependencies to keep the final image light
# RUN npm ci --omit=dev && npm cache clean --force

# # Copy built app/source from the builder stage
# COPY --from=builder /app ./

# # Security best practice: Run app as a non-root user
# USER node


# # Start application
# CMD ["node", "server.js"]
