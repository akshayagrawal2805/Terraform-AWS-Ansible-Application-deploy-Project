resource "aws_security_group" "ssh_sg" {
  name        = "allow-ssh"
  description = "Allow SSH access"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ open to all (for learning)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server0" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  user_data = file("ansible.sh")

  tags = {
    Name = "anisble-server"
  }

}

resource "aws_instance" "server1" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("ansible.sh")

  tags = {
    Name = "target-server"
  }
}



