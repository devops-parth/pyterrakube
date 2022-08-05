resource "aws_instance" "myec2" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.medium"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = "Jenkins"
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install apt-transport-https
    sudo apt upgrade
    sudo apt install virtualbox virtualbox-ext-pack
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube-linux-amd64
    sudo mv minikube-linux-amd64 /usr/local/bin/minikube
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    minikube start
    sudo apt install git -y
    git clone https://github.com/devops-parth/pyterrakube.git
    sudo apt-get update
    kubectl apply -f deployment.yml
    kubectl apply -f service.yml
  EOF
  tags = {
    name = "kube_inst"
  }
}
