# terraform_project_code
## install  terraform
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
## first of all you have to create s3 bucket and dynamodb table first time by manually and by terraform script after that you can you bucket and dynamodb table for locking 

### in this location we can see our script is runnig or not after ssh 
```
ssh -i mohit.pem ubuntu@your-ec2-public-ip
cat /var/log/cloud-init-output.log
```
### in this location our script file locate in ec2 
```
ls /var/lib/cloud/instance/scripts
```
### and all install data will available in / path 


