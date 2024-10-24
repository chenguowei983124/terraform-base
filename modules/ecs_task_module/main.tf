# main.tf

resource "aws_ecs_task_definition" "task" {
  family                   = var.task_name
  container_definitions    = jsonencode([{
    name  = var.task_name
    image = var.container_image
    memory = 512
    cpu    = 256
    port_mappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}

resource "aws_ecs_service" "service" {
  name            = "${var.task_name}-service"
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = false
  }
}