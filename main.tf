# create worker ec2 instance
resource "aws_instance" "capstone-jenkins-worker" {
  count = 2 
  ami                     = "ami-0eea504f45ef7a8f7"
  instance_type           = "t2.large"
  key_name                = "ubuntu-1"
  tags                    = {
                              Name = "jenkins-worker-${count.index}"
                            }
  vpc_security_group_ids  = [aws_security_group.capstone-jenkins-sg.id]
  root_block_device {
      volume_type           = "gp2"
      volume_size           = 100
      delete_on_termination = true
  }
}

# create master ec2 instance
resource "aws_instance" "capstone-jenkins-master" {
  ami                    = "ami-0eea504f45ef7a8f7"
  instance_type          = "t2.large"
  key_name               = "ubuntu-1"
  tags                   = {
                              Name = "jenkins-master"
                           }
  
  vpc_security_group_ids = [aws_security_group.capstone-jenkins-sg.id]
  root_block_device {
      volume_type           = "gp2"
      volume_size           = 100
      delete_on_termination = true
  }
}




# create security group
resource "aws_security_group" "capstone-jenkins-sg" {

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5901
    to_port     = 5905
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
           Name = "jenkins-sg"
         }
}

##### Terraform commands #####
#$ terraform init
#$ terraform plan
#$ terraform apply
#$ terraform destroy
