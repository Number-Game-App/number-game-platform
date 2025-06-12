# Use a lightweight base image (nginx:alpine, node:alpine, etc.)
FROM nginx:alpine

# Copy application files to the container
COPY index.html /usr/share/nginx/html/

# Expose the necessary port
EXPOSE 80