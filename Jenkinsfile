pipeline {
  agent any
  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    ECR_REPO = '302939895826.dkr.ecr.us-east-1.amazonaws.com'
  }
  stages {
       stage('DCM Image Build') {
              steps {
            sh '''
               export AWS_DEFAULT_REGION=us-east-1
               docker system prune -a
               docker pull amazon/aws-cli:latest
               aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPO}
               docker build -t dcm-deploy .
               docker tag dcm-deploy:latest 302939895826.dkr.ecr.us-east-1.amazonaws.com/dcm-deploy:latest
               docker push ${ECR_REPO}/dcm-deploy:latest
               '''

          }
        }

        stage('DCM Terraform plan') {
              steps {
            sh '''
               terraform init
               terraform plan
               '''
          }
        } 

        stage('DCM Terraform apply') {
              steps {
            sh '''
               terraform apply -auto-approve
               '''
          }
        }        
  }
}
