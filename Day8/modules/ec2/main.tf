
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_launch_template" "flask_app_lt" {
    name_prefix = "flask-app-"
    image_id = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"

    user_data = base64encode(file("${path.module}/user_data.sh"))
    vpc_security_group_ids = [var.security_group_id]
    


    key_name = var.key_name

    lifecycle {
      create_before_destroy = true
    }

  

  


tag_specifications{
    resource_type = "instance"
    tags = {
        Name = "FlaskAppInstance"
    }
}
}

resource "aws_autoscaling_group" "flask_asg" {
    name = "flask-app-sg"
    desired_capacity = 2
    max_size = 2
    min_size = 1
    vpc_zone_identifier = var.public_subnet_ids
    health_check_type = "EC2"
    health_check_grace_period = 300

    launch_template {
      # id = aws.launch_template.flask_app_lt.id
      id = aws_launch_template.flask_app_lt.id
      # id = aws_launch_template.flask_app_lt.id


      version = "$Latest"
    }
    tag {
      key = "Name"
      value = "FlaskAppASG"
      propagate_at_launch = true
    }

    depends_on = [ aws_launch_template.flask_app_lt ]
  
}