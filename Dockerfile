#pull a base nginx image from docker hub
FROM nginx 

#linux command to update but you need to start with RUN because you are in a docker file
RUN apt-get update -y

#copy the application and replace default content of the nginx
COPY index.html /usr/share/nginx/html

##expose port 80
EXPOSE 80

