resource "aws_key_pair" "mykey" {
     key_name = "mohit_21_may_key"
     public_key = file("C:/Users/Raj/.ssh/id_rsa.pub") #path of your local system public key 
}



