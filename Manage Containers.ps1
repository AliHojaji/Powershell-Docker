#--- Author : Ali Hojaji ---#

#--*---------------------*--#
#---> Manage Containers <---#
#--*---------------------*--#

#--> enter remote session
Enter-PSSession CN-TEST


#---> Container Networking <---#

#--> view networks
docker network ls

#--> view default nat network details
docker network inspect nat

#--> start a container
docker run -dt test/iis

#--> start a container with port mapping
docker run -dt -p 8080:80 test/iis

#--> create a transparent network
docker network create -d transparent -o com.docker.network.windowsshim.interface="Ethernet 4" --subnet=192.168.1.0/24 --gateway=192.168.1.1 tpnet


#---> Container Data Volumes <---#

#--> create a persistent data volume
docker volume create nugdata

#--> start containers using data volume
docker run --name web1 -dt -v fardata:c:\data nuglab/iis
docker run --name web2 -dt -v fardata:c:\data nuglab/iis

#--> send command into container
docker exec <name_or_id> powershell dir c:\

#--> view data volumes
docker volume ls

#--> mount host dir into container
docker run --name web3 -dt -v c:\test:c:\mounted test/iis

#--> send command into container
docker exec <name_or_id> powershell dir c:\


#---> Container Resource Control <---#

#--> view docker run help
docker run --help

#--> imit memory & cpu
docker run -dt --memory 512m --cpu-percent 25 test/iis


#---> Dockerfile - Image Automation <---#

#--> build image from dockerfile
docker tag test/iis test/iis:1.0
docker build -t test/iis .
docker run -dt -p 8080:80 test/iis:latest

#---> Dockerhub - Image Repo <---#

#--> login to dockerhub
docker login

#---> builds a web server on top of server core <---#

#--> specify base os image
FROM microsoft/windowsservercore

#--> install iis
RUN powershell -Command Install-WindowsFeature Web-Server

#--> copy src directory from container host to container
COPY ./src c:/inetpub/wwwroot

#--> launch container into a powershell session
CMD powershell