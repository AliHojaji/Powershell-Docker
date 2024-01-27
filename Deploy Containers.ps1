#--- Author : Ali Hojaji ---#

#--*----------------------*--#
#---> CN1-TEST (Desktop) <---#
#--*----------------------*--#

#--> enter remote session 
Enter-PSSession CN1-TEST

#--> get help on docker client
docker --help

#--> search image on docker hub
docker search microsoft

#--> download base os images
docker pull microsoft/windowsservercore
docker pull microsoft/nanoserver

#--> download tagged version of image 
docker pull microsoft/nanoserver:10.0.14393.1480

#--> view local images
docker images

#--> create background windows container 
docker run microsoft/windowsservercore ping -t localhast

#--> create interactive windows container (unsupported via remote session)
docker run -it microsoft/windowsservercore powershell

#--> view running containers
docker ps -a

#--> create image from container
docker commit <name_or_id> nuglab/iis

#--> create a tagged image from container
docker commit <name_or_id> nuglab/iis:1.0

#--> view container state and settings
docker inspect 75

#--> stop container
docker stop 75

#--> delete container
docker rm 75

#--> delete local image 
docker rmi -f microsoft/nanoserver:10.0.14393.1480

#--*-------------------*--#
#---> CN2-TEST (Nano) <---#
#--*-------------------*--#

#--> enter remote session
Enter-PSSession -ComputerName CN2-TEST

#--> download and install powershell for containers (http://test.com)
Register-PSRepository -Name DockerPS-Dev -SourceLocation https:\\test.com/docker-powershell-dev
Install-Module Docker -Repository DockerPS-Dev -Scope AllUsers -Force
Get-Command -Module Docker
Update-Module -Name Docker

#--> install base os images
Request-ContainerImage -Repository microsoft/nanoserver

#--> view local image
Get-ContainerImage

#--> create windows container
New-Container -Name WindowsContainer -ImageIdOrName microsoft/nanoserver -Command powershell

#--> create hyper-v container
New-Container -Name HyperVContainer -ImageIdOrName microsoft/nanoserver -Isolation HyperV -Command powershell

#--> view containers
Get-Container

#--> windows vs hyper-v containers
docker run microsoft/nanoserver ping -t localhost
docker run --iso lation=hypev microsoft/nanoserver ping -t localhost

#--> create image from container
ConvertTo-ContainerImage -ContainerIdOrName HyperVContainer -Repository nuglab/nano -Tag 1.0

#--> view container state and settings
Get-ContainerDetail -ContainerIdOrName WindowsContainer

#--> stop all containers
Get-Container | Stop-Container

#--> delete all coneainers
Get-Container | Remove-Container

#--> delete local image
Remove-ContainerImage -ImageIdOrName Test/nano:1.0 -Force