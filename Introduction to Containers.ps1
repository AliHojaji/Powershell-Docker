#--- Author : Ali Hojaji ---#

#--*------------------------------*--#
#---> Introduction to Containers <---#
#--*------------------------------*--#

#---> CN1-TEST (Desktop) <---#

#--> enter remote session
Enter-PSSession CN1-TEST

#--> install docker provider
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force

#--> install docker
Install-Package -Name docker -ProviderName DockerMsftProvider -Force

#--> reboot
Restart-Computer -Force

#--> docker install & root dir
Get-ChildItem -Name 'C:\Program Files\Docker'
Get-ChildItem -Name 'C:\ProgramData\docker'

#--> docker daemon
Get-Service -Name docker

#--> docker client
docker version
docker info

#--> configure docker daemon
$json = '{ " graph": "c:\\docker"}'
$json | Set-Content c:\Programdata\docker\config\daemon.json
New-Item -ItemType Directory -Path c:\docker

#--> restart service
Restart-Service -Name docker


#---> CN2-TEST (Nano) <---#

#--> enter remote session 
Enter-PSSession -ComputerName CN2-TEST

#--> install docker provider
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force

#--> install docker
Install-Package -Name docker -ProviderName DockerMsftProvider -Force

#--> install the hyper-v role
Install-NanoServerPackage -Name Microsoft-NanoServer-Computer-Package

#--> reboot
Restart-Computer -Force

#--> docker install & root dir
Get-ChildItem -Name 'C:\Program Files\Docker'
Get-ChildItem -Name 'C:\ProgramData\docker'

#docker daemon
Set-Service -Name docker -StartupType Automatic 
Set-Service -Name docker | Start-Service

#--> docker client
docker version
docker info

#--> configure docker daemon
$json = '{ "graph": "c:\\docker" }'
$json | Set-Content c:\programdata\docker\config\daemon.json
New-Item -ItemType Directory -Path c:\docker

#--> restart service
Restart-Service -Name docker
