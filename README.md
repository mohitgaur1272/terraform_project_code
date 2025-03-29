# terraform_project_code
## install  terraform
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
## ```.terraform.lock.hcl``` file Terraform ke dependency lock file hoti hai, jo infrastructure-as-code (IaC) tool Terraform dwara automatically generate ki jati hai. Ye file ensure karti hai ki ek specific Terraform project me providers aur unki versions same rahein, taki deployment me koi unexpected changes na aaye.
### File Ka Use:
##### 1,Provider Versions Ko Lock Karna
##### 2.Consistency Maintain Karna
##### 3.Security & Stability

## ```terraform.tfstate.backup``` ek backup file hoti hai jo Terraform automatically create karta hai jab bhi terraform.tfstate file update hoti hai. Iska main purpose hai previous state ko backup rakhna taki agar naya state file corrupt ho jaye ya galti se changes ho jayein to purane state ko restore kiya ja sake.

### terraform.tfstate.backup File Ki Zaroorat Kyon Hoti Hai?
### Rollback Ke Liye:
Agar terraform apply ke baad kuch galat ho jaye, to terraform.tfstate.backup ka use karke purani state restore kar sakte hain.

### State File Corruption Se Bachav:

Kabhi-kabhi agar terraform.tfstate corrupt ho jaye ya delete ho jaye, to backup file se recover kar sakte hain.

### Manual Recovery:

Agar kisi wajah se infrastructure inconsistent ho jaye, to hum backup file ka use karke manually terraform.tfstate ko replace kar sakte hain.

### Backup Restore Karne Ka Tarika
Agar terraform.tfstate corrupt ho gaya ho ya galti se delete ho gaya ho, to aap backup file ko rename karke restore kar sakte hain:
```
mv terraform.tfstate.backup terraform.tfstate

```
