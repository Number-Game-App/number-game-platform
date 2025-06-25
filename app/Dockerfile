FROM nginx:alpine

# Copy application files
COPY index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY metrics /usr/share/nginx/html/

# Health check
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

EXPOSE 80
# Add metrics file
COPY metrics /usr/share/nginx/html/
