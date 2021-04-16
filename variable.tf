variable "vpc_id"{
    default = "vpc-3642fa4b"
    description = "DMZ VPC"
}
variable "region_name" {
   default = "us-east-1"
 }
variable "alb_name" {
   default = "dcm-lb"
   description = "The name of the Load Balancer"
 }
variable "tg_name" {
   default = "dcm-tg"
   description = "The name of the Load Balancer"
 }
variable "ecs_cluster" {
  default = "DCMCluster"
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
  default = "arn:aws:iam::302939895826:role/ecs_access"
  description = "The role of the ECS Cluster Service"
}
