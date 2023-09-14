data "aws_subnet" "docker_event_1" {
  filter {
    name   = "tag:Name"
    values = ["docker-event-01"]
  }
}

data "aws_subnet" "docker_event_2" {
  filter {
    name   = "tag:Name"
    values = ["docker-event-02"]
  }
}

data "aws_iam_role" "docker_event" {
  name = "ecsTaskExecutionRole"
}

data "aws_security_group" "docker_event" {
  name = "docker-event"
}
