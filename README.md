# terraform_project_code
## install  terraform
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
## In this repo we have multipal tfvars file that represent if want create infra for multipal envirnment so we have to create first workspace then we have to use tfvars file for particular envirnment.
### create workspace 
```
terraform workspace new dev  # you can change by new to stage and prod for other workspace
```
### then you can list and show your workspace
```
terraform workspace list
terraform workspace show
```
### then we want to create infra for dev envirnment so use this command  
```
terraform apply -var-file="dev.tfvars"
```
### after this if you want to create infra for stage so first of all you have to switch in stage workspace with this command
```
terraform workspace select stage
terraform apply -var-file="stage.tfvars"
```
### you will see in ```terraform.tfstate.d``` this folder multipal folder like dev and stage and production and in all folder tfstate file will be store for our particular infra like state file in the dev folder and state file for stage folder and state file for production folder.
### so terraform store automatically all state file in seprate folder.
## if we want delete and configure our infra so first of all select workspace then use this command 
```
terraform workspace select dev
terraform destroy -var-file="dev.tfvars"
```
### you have to use this command for all infra.

