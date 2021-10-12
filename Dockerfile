FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
	&& apt-get install -y iputils-ping
 
##WORKDIR##
RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

##COPY##
##ADMITE METACARACTERES##
COPY index.html .
COPY app.log /datos

##ADD##
##CREAMOS UNA CARPETA docs DENTRO TIENE UN ARCHIVO f8##
ADD docs docs
##COPIA TODOS LOS ARCHIVOS QUE INICIEN POR f Y LOS ENVIA A LA CARPETAS DATOS ADMITE METACARACTERES##
ADD f* /datos/
ADD f.tar .

##ENV##
##CREAMOS UNA VARIABLE PARA PASARLA AL CONTENEDOR##
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

##ARG##
#ARG dir2
#RUN mkdir $dir2
#ARG user
#ENV user_docker $user
##PASAMOS EL FINCHERO##
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

##EXPOSE##
##INSTALAMOS EL APACHE##
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get install -y  apache2
EXPOSE 80
#ESTE SCRIPT PERMITE INICIAR EL APACHE
ADD entrypoint.sh /datos1

##VOLUME##
#COPIO LOS DATOS QUE TENGO EN LA CARPETA PAGINA QUE ESTA A NIVEL DE DOCKERFILE
ADD paginas /var/www/html
VOLUME ["/var/www/html"]

##CMD##
CMD /datos1/entrypoint.sh

##ENTRYPOINT##
#ENTRYPOINT ["/bin/bash"]
