# ecs.tf

resource "aws_ecs_cluster" "main" {
  name = "Claritaz-POC"
}

/*********************************************************************frontend************************************************************************************************/
data "template_file" "frontend" {
  template = file("./templates/ecs/frontend.json.tpl")

  vars = {
    frontend_image = var.frontend_image
    frontend_port  = var.frontend_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.frontend.rendered
}

resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.frontend.id
    container_name   = "frontend"
    container_port   = var.frontend_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

/*********************************************************************backend************************************************************************************************/

data "template_file" "backend" {
  template = file("./templates/ecs/backend.json.tpl")

  vars = {
    backend_image  = var.backend_image
    backend_port   = var.backend_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "backend-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.backend.rendered
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
 
  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

 load_balancer {
    target_group_arn = aws_alb_target_group.backend.id
    container_name   = "backend"
    container_port   = var.backend_port
  }
  

  depends_on = [aws_ecs_task_definition.backend, aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}



/*********************************************************strapi*****************************************************************************************/

data "template_file" "strapi" {
  template = file("./templates/ecs/strapi.json.tpl")

  vars = {
    strapi_image  = var.strapi_image
    strapi_port   = var.strapi_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.strapi.rendered
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
 
  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

 load_balancer {
    target_group_arn = aws_alb_target_group.strapi.id
    container_name   = "strapi"
    container_port   = var.strapi_port
  }
  

  depends_on = [aws_ecs_task_definition.strapi, aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}