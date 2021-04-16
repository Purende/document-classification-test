provider "aws" {
  region  = "${var.region_name}" 
}

### ALB
resource "aws_alb" "main1" {
  name            = "${var.alb_name}"
  internal        = flase
  subnets         = ["subnet-3d4d7270", "subnet-7da2c85c"]
  security_groups = ["${aws_security_group.lb.id}"]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.tg_name}"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main1.id}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.app.id}"
    type             = "forward"
  }
 }

 ### ECS Cluster for DCM
resource "aws_ecs_cluster" "DCM-MLOPS" {
  name = "${var.ecs_cluster}"
}

resource "aws_ecs_task_definition" "DCM-MLOPS-APP" {
  family                   = "${var.ecs_task_definition}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 3072
  task_role_arn            = "${var.ecs_role}"  
  execution_role_arn       = "${var.ecs_role}"               
  container_definitions = jsonencode([
  {
    "image": "302939895826.dkr.ecr.us-east-1.amazonaws.com/dcm-deploy:latest",
    "memoryReservation": 2048,
    "name": "app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/app",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
  ])
}

resource "aws_ecs_service" "main" {
  name            = "${var.ecs_service}"
  cluster         = "${aws_ecs_cluster.DCM-MLOPS.id}"
  task_definition = "${aws_ecs_task_definition.DCM-MLOPS-APP.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["sg-0f84af4ebe597ee17"]
    subnets         = ["subnet-7da2c85c"]
    assign_public_ip = true 
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.app.id}"
    container_name   = "app"
    container_port   = 5000
  }

  depends_on = [
    "aws_alb_listener.front_end",
  ]
}

terraform {
  backend "s3" {
    bucket  = "dcm-infra-statefiles"
    key     = "dcm-infra-statefiles/tfstate.json"
    encrypt = true
    region  = "us-east-1"
  }
}
