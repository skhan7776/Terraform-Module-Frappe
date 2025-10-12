resource "aws_instance" "app_server" {
  ami                    = var.ami
  instance_type          = var.type
  key_name               = var.key_pair_name
  subnet_id              = var.subnet_id[0]
  security_groups        = var.security_groups
  user_data = <<-EOF
    #!/bin/bash
    set -xe
    exec > /var/log/user_data.log 2>&1

    # Update system
    yum update -y

    # Install Docker & Docker Compose
    yum install -y docker git python3-pip
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ec2-user

    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    # Create working directory
    mkdir -p /opt/helpdesk
    cd /opt/helpdesk

    # Write docker-compose.yml from Terraform local file
    cat <<'EOC' > docker-compose.yml
    ${file("${path.root}/docker-compose.yml")}
    EOC

    # Modify docker-compose.yml to ensure restart=always
    sed -i '/image:/a \    restart: always' docker-compose.yml

    # Write init.sh from Terraform local file
    cat <<'EOS' > init.sh
    ${file("${path.root}/init.sh")}
    EOS

    chmod +x init.sh

    # Start containers
    docker-compose up -d

    # Run init script
    ./init.sh
  EOF

  tags = {
    Name = "helpdesk-server"
  }
}
