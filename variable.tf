variable "vpc_id"{
    default = "vpc-3642fa4b"
    description = "DMZ VPC"
}
variable "region_name" {
   default = "us-east-1"
 }
variable "alb_name" {
   default = "dcm"
   description = "The name of the Load Balancer"
 }
variable "ecs_cluster" {
  default = "DCM Cluster"
  description = "The name of the ECS Cluster"
}

variable "ecs_task_definition" {
  default = "DCMfargate"
  description = "The name of the ECS Cluster task definition"
}

variable "ecs_service" {
  default = "DCMFargate"
  description = "The name of the ECS Cluster Service"
}

variable "ecs_role" {
  default = "arn:aws:iam::302939895826:role/OneCloud/ECS_RoleAccess"
  description = "The role of the ECS Cluster Service"
}
