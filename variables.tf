# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}



variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

/*************************************frontend**************************************************/

variable "frontend_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "392977643844.dkr.ecr.us-west-2.amazonaws.com/cgp_frontend"
}

variable "frontend_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

/**************************************backend**************************************************/

variable "backend_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "392977643844.dkr.ecr.us-west-2.amazonaws.com/cgp_backend"
}

variable "backend_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}


/**************************************strapi**************************************************/

variable "strapi_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "392977643844.dkr.ecr.us-west-2.amazonaws.com/cgp_strapi"
}

variable "strapi_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 1337
}

/**************************************bucketname********************************/

variable "bucketname" {
  description = "s3-buvketname to be created"
  type = string
  default = "claritoz-poc-bucket"
}