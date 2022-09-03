resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = data.aws_ami.ec2_ami.id
  iam_instance_profile = aws_iam_instance_profile.ecs_agent_profile.id
  security_groups      = [aws_security_group.ecs_sg.id]
  user_data            = file("ecs_setup.sh")
  instance_type        = "t2.micro"

  depends_on = [aws_iam_instance_profile.ecs_agent_profile]
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg1" {
  count=2
  name                 = "asg"
  vpc_zone_identifier  = [element(aws_subnet.public.*.id, count.index)]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
}