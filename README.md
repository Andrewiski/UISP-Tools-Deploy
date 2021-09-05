# UISP-Tools-Deploy
 UISP-Tools-Deploy

##Installing Prerequisites##

Run the following commands on the Ubuntu or Debian system to ensure that all required tools are installed:
```
sudo apt-get update
sudo apt-get install curl sudo bash jq 

```


##Installation Instructions##

Run the command below on the host to install and start UISPTools 

```
curl -fsSL https://raw.githubusercontent.com/Andrewiski/UISP-Tools-Deploy/main/install.sh > /tmp/UispToolsInstall.sh && sudo bash /tmp/UispToolsInstall.sh
```