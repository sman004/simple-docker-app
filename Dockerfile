FROM nginx
RUN agt-get update -y
COPY index.html /usr/share/nginx/html
