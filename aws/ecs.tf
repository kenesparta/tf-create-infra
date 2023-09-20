locals {
  common_name       = "docker-event"
  id                = data.external.env_vars.result["ID"]
  docker_image_name = data.external.env_vars.result["DOCKER_IMAGE_NAME"]
  docker_image_tag  = data.external.env_vars.result["DOCKER_IMAGE_TAG"]
  container_name    = data.external.env_vars.result["CONTAINER_NAME"]
  container_port    = data.external.env_vars.result["CONTAINER_PORT"]
}

resource "aws_ecs_cluster" "docker_event" {
  name = format("cluster_%s", local.id)
}

resource "aws_ecs_task_definition" "docker_event" {
  family                   = format("%s-task_%s", local.common_name, local.id)
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.docker_event.arn
  container_definitions    = jsonencode([
    {
      name         = local.container_name
      image        = format("%s:%s", local.docker_image_name, local.docker_image_tag)
      portMappings = [
        {
          containerPort = tonumber(local.container_port)
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "docker_event" {
  name            = format("%s-service_%s", local.common_name, local.id)
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
