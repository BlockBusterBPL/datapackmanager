# DataPackManager
A Package Manager For Minecraft's New Datapack Feature, Avaliable on Mac and Windows  
![](https://img.shields.io/badge/Packages-7-success.svg) 
![](https://img.shields.io/github/downloads/blockbusterbpl/datapackmanager/total.svg?label=Downloads&logo=github)
# Features
* Quickly download and manage datapacks for your minecraft worlds
* Check for updates and grab the latest version
* Manage multiple worlds
* Automatically install dependacies
* Make groups of datapacks and send them to your friends
* CLI for making your own datapacks
  - Automatically Create New Files In The Right Place
  - Tag Functions To Run Each Tick Or On Game Load
  - Automatically Generate Complicated JSON Files like `pack.mcmeta`
* Based On Shellscript With Wget
# Video Overview
Coming Soon...
# Other Information
Automatically Installs The Following Dependancies  
* wget (Downloading Files)  
* yq (Parses YAML Files)  

The install script will install to the default MC directory located here:  
  - Windows: `C:\Users\{yourname}\AppData\Roaming\.minecraft`  
  - Mac OS: `/Users/{yourname}/Library/Application Support/minecraft`

Operates From The Subdirectory Of `datapackmanager`  
This Program Will Add And Remove Data From Your Minecraft Installation. If you reinstall minecraft, or delete the datapackmanager directory, this program will no longer work
