#Task Definition
resource "aws_ecs_task_definition" "glpi_task_definition" {
  family                   = "TaskDefinition_glpi"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "2048"
  memory                   = "4096"
  #essential = true
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name  = "container_glpi"
    image = "${data.terraform_remote_state.ecr.outputs.ecr_repository_arn}:latest"
    #654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest" # URL da sua imagem Docker no GitHub
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    environment = [
      {
        name  = "DB_HOST"
        value = "${data.terraform_remote_state.rds.outputs.db_end_point}" #aws_db_instance.mysql.endpoint
      },
      {
        name  = "DB_NAME"
        value = "${data.terraform_remote_state.rds.outputs.db_db_name}"
      },
      {
        name  = "DB_USER"
        value = "${data.terraform_remote_state.rds.outputs.db_db_username}"
      },
      {
        name  = "DB_PASSWORD"
        value = "glpiglpi"
      }
    ]
    mountPoints = [
      {
        sourceVolume  = "efs-volume-1"
        containerPath = "/var/www/html/glpi/data1"
      },
      {
        sourceVolume  = "efs-volume-2"
        containerPath = "/var/www/html/glpi/data2"
      },
      {
        sourceVolume  = "efs-volume-3"
        containerPath = "/var/www/html/glpi/data3"
      }
    ]
  }])

  volume {
    name = "efs-volume-1"
    efs_volume_configuration {
      file_system_id = data.terraform_remote_state.efs.outputs.efs_fs_id #aws_efs_file_system.glpi_efs.id
    }
  }

  volume {
    name = "efs-volume-2"
    efs_volume_configuration {
      file_system_id = data.terraform_remote_state.efs.outputs.efs_fs_id #aws_efs_file_system.glpi_efs.id
    }
  }

  volume {
    name = "efs-volume-3"
    efs_volume_configuration {
      file_system_id = data.terraform_remote_state.efs.outputs.efs_fs_id #aws_efs_file_system.glpi_efs.id
    }
  }
  tags = {
    Name        = "Orquestrador"
    Terraform   = "true"
    Environment = "Projeto_20"
    Management  = "Terraform"
    #Id_EFS      = data.terraform_remote_state.efs.outputs.efs_fs_id
  }
}

resource "aws_ecs_cluster" "glpi_cluster" {
  name = "cluster_glpi"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
# Role Name AWSCodePipelineServiceRole-us-east-1-glpi_cluster
# PIpeline Role Name AWSCodePipelineServiceRole-us-east-1-pipeline_glpi
/*
CodeBild
Projeto Projeto20-glpi
role codebuild-Projeto20-glpi-service-role

Code Deploy
glpi_cluster
glpi_service

*/

resource "aws_ecs_cluster_capacity_providers" "glpi_capacity_providers" {
  cluster_name = aws_ecs_cluster.glpi_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


/*
{
    "taskDefinitionArn": "arn:aws:ecs:us-east-1:654654346517:task-definition/TaskDefinition_glpi:1",
    "containerDefinitions": [
        {
            "name": "container_glpi",
            "image": "654654346517.dkr.ecr.us-east-1.amazonaws.com/repository_glpi:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "container_glpi-80-tcp",
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "DB_NAME",
                    "value": "glpi"
                },
                {
                    "name": "DB_HOST",
                    "value": "db-projeto20.c74aow4iav4j.us-east-1.rds.amazonaws.com"
                },
                {
                    "name": "DB_USER",
                    "value": "root"
                },
                {
                    "name": "DB_PASSWORD",
                    "value": "glpiglpi"
                }
            ],
            "environmentFiles": [],
            "mountPoints": [
                {
                    "sourceVolume": "EFS",
                    "containerPath": "/mnt/efs_glpi",
                    "readOnly": false
                }
            ],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/TaskDefinition_glpi",
                    "mode": "non-blocking",
                    "awslogs-create-group": "true",
                    "max-buffer-size": "25m",
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
        }
    ],
    "family": "TaskDefinition_glpi",
    "taskRoleArn": "arn:aws:iam::654654346517:role/ecsTaskExecutionRole",
    "executionRoleArn": "arn:aws:iam::654654346517:role/ecsTaskExecutionRole",
    "networkMode": "awsvpc",
    "revision": 1,
    "volumes": [
        {
            "name": "EFS",
            "efsVolumeConfiguration": {
                "fileSystemId": "fs-03bf2768d7213a789",
                "rootDirectory": "/mnt/efs_glpi"
            }
        }
    ],
    "status": "ACTIVE",
    "requiresAttributes": [
        {
            "name": "ecs.capability.execution-role-awslogs"
        },
        {
            "name": "com.amazonaws.ecs.capability.ecr-auth"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.28"
        },
        {
            "name": "com.amazonaws.ecs.capability.task-iam-role"
        },
        {
            "name": "ecs.capability.execution-role-ecr-pull"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
        },
        {
            "name": "ecs.capability.task-eni"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.29"
        },
        {
            "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
        },
        {
            "name": "ecs.capability.efsAuth"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
        },
        {
            "name": "ecs.capability.efs"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.25"
        },
        {
            "name": "ecs.capability.extensible-ephemeral-storage"
        }
    ],
    "placementConstraints": [],
    "compatibilities": [
        "EC2",
        "FARGATE"
    ],
    "requiresCompatibilities": [
        "FARGATE"
    ],
    "cpu": "1024",
    "memory": "3072",
    "ephemeralStorage": {
        "sizeInGiB": 21
    },
    "runtimePlatform": {
        "cpuArchitecture": "X86_64",
        "operatingSystemFamily": "LINUX"
    },
    "registeredAt": "2024-09-24T21:11:19.057Z",
    "registeredBy": "arn:aws:iam::654654346517:root",
    "tags": []
}
*/

#Service
resource "aws_ecs_service" "glpi_service" {
  name            = "glpi-service"
  cluster         = aws_ecs_cluster.glpi_cluster.id
  task_definition = aws_ecs_task_definition.glpi_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[*]     ####[daaws_subnet.public.id]
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.glpi_lb_target_group.arn
    container_name   = "glpi"
    container_port   = 80
  }
}

### CodeBuild

/*
https://www.youtube.com/watch?v=KvlHLJkJ0bY
https://github.com/CumulusCycles/IaC_on_AWS_with_Terraform/blob/main/src/5_Terraform_ECR_ECS/main.tf
https://github.com/Juanmichael00/terraform/blob/main/modulo-efs/efs.tf
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://www.youtube.com/watch?v=bIPF_hzmQGE&list=PLWQmZVQayUUIgSmOj3GPH2BJcn0hOzIaP
https://github.com/itirohidaka




*/

#Roules ECS
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
  ]
}

#SG RDS,EFS,ECS
resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs_sg" {
  name   = "efs_sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs_sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ALB
resource "aws_lb" "glpi_alb" {
  name               = "glpi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[*]  ##aws_subnet.public.*.id

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.glpi_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.glpi_lb_target_group.arn
  }
}

resource "aws_lb_target_group" "glpi_lb_target_group" {
  name     = "glpi-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
  }
}

/*
resource "aws_ecs_service" "glpi_service" {
  name            = "glpi-service"
  cluster         = aws_ecs_cluster.glpi_cluster.id
  task_definition = aws_ecs_task_definition.glpi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public.*.id
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.glpi_lb_target_group.arn
    container_name   = "glpi"
    container_port   = 80
  }
}
*/

resource "aws_security_group" "alb_sg" {
  name   = "alb_sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

