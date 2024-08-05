# ecs_module/variable.tf

variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_definition_name" {
  description = "Name of the ECS task definition"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task definition"
  type        = number
}

variable "task_memory" {
  description = "Memory for the task definition"
  type        = number
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Desired count of tasks for the service"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "The subnets for the ECS service"
  type        = list(string)
}
