resource "aws_iam_user" "terraform_user" {
  name = "terraform_user"
}

resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "terraform_user_policy"
  user = aws_iam_user.terraform_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateCluster",
          "ec2:DeleteCluster",
          "ec2:DescribeClusters",
          "ecs:CreateCluster",
          "ecs:DeleteCluster",
          "ecs:DescribeClusters",
          "ecs:RegisterTaskDefinition",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:DescribeTasks",
          "iam:CreateRole",
          "iam:CreatePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:DeleteRole",
          "iam:DeleteRolePolicy"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_ecs_cluster" "terraform_cluster" {
  name = "terraform_cluster"
}

resource "aws_ecs_task_definition" "terraform_task_definition" {
  family = "terraform_task_definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory = 512

  container_definitions = jsonencode([
    {
      name = "terraform_nginx_container",
      image = "412381760559.dkr.ecr.ap-south-1.amazonaws.com/terraform-repo:latest"
      memory = 512
      image = "nginx:latest",
      portMappings = [
        {
          containerPort = 80
        }
      ]
    }
  ])
}