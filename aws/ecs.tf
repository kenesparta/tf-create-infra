locals {
  common_name    = "docker-event"
  cluster_name   = data.external.env_vars.result["CLUSTER_NAME"]
  docker_image   = data.external.env_vars.result["DOCKER_IMAGE"]
  container_name = data.external.env_vars.result["CONTAINER_NAME"]
  container_port = data.external.env_vars.result["CONTAINER_PORT"]
}

resource "aws_ecs_cluster" "docker_event" {
  name = local.cluster_name
}

resource "aws_ecs_task_definition" "docker_event" {
  family                   = format("%s-task_%s", local.common_name, local.cluster_name)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.docker_event.arn
  container_definitions    = jsonencode([
    {
      name         = local.container_name
      image        = local.docker_image
      portMappings = [
        {
          containerPort = tonumber(local.container_port)
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "docker_event" {
  name            = format("%s-service_%s", local.common_name, local.cluster_name)
  cluster         = aws_ecs_cluster.docker_event.id
  task_definition = aws_ecs_task_definition.docker_event.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [data.aws_subnet.docker_event_1.id]
    security_groups  = [data.aws_security_group.docker_event.id]
    assign_public_ip = true
  }
}
