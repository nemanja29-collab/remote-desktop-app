FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install dependencies first (better layer caching)
COPY package.json ./
RUN npm install --omit=dev

# Copy app source
COPY server/ ./server/
COPY public/ ./public/

# Non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000

CMD ["node", "server/index.js"]
