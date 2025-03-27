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


