# Step 1: Use an official lightweight web server image
FROM nginx:alpine

# In the official NGINX Docker image, this directory is set to /usr/share/nginx/html/ by default. 
COPY index.html /usr/share/nginx/html/

# Default port of HTTP
EXPOSE 80

# Default command to start the NGINX server
CMD ["nginx", "-g", "daemon off;"]