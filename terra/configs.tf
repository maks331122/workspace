resource "null_resource" "install_nginx" {
  count = var.instance_count

  triggers = {
    instance_id = aws_instance.nginx[count.index].id
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",  
      "sudo systemctl start nginx", 
      "sudo systemctl enable nginx",
      "git clone https://github.com/maks331122/scripts.git",
      "sudo python3 scripts/scriptnginx.py ${aws_instance.nginx[count.index].public_ip} ${count.index}"
    ]
  }
  
  connection {
      host        = aws_instance.nginx[count.index].public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/maskhav/workspace/terra/ssh/maskhavKey.pem")
  }
}
