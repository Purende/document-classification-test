pipeline {
  agent any
  //options { 
   // timeout(time: 1, unit: 'HOURS')
   // ansiColor('xterm') 
  //}
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION = 'us-east-1'
    ECR_REPO = '302939895826.dkr.ecr.us-east-1.amazonaws.com'
  }
  stages {
       stage('DCM Image Build') {
           when { branch 'master' }
            // agent { docker { image 'ubuntu' } }
              steps {
            sh '''
               export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
               export AWS_SECRET_ACCESS_KEY=$SAWS_SECRET_ACCESS_KEY
               export AWS_DEFAULT_REGION=us-east-1
               docker pull amazon/aws-cli:latest
               aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPO}
               docker build -t dcm-deploy .
               docker tag dcm-deploy:latest 302939895826.dkr.ecr.us-east-1.amazonaws.com/dcm-deploy:latest
               docker push ${ECR_REPO}/dcm-deploy:latest
               '''

          }
        }

        stage('DCM Terraform plan') {
           when { branch 'master' }
            // agent { docker { image 'hashicorp/terraform:0.12.15' } }
              steps {
            sh '''
               terraform init
               terraform plan
               '''
          }
        } 

        stage('DCM Terraform apply') {
           when { branch 'master' }
            // agent { docker { image 'hashicorp/terraform:0.12.15' } }
              steps {
            sh '''
               terraform apply
               '''
          }
        }        
      //post{
        //success{
         // slackSend (color: 'good', channel: '#DCM', message: ":happy_goat: ${env.CHANGE_AUTHOR_DISPLAY_NAME} has submitted a passing JOB!")
        //}
        //failure{
          //slackSend (color: 'warning', channel: "#DCM", message: ":panic: ${env.CHANGE_AUTHOR_DISPLAY_NAME}: Bad news, your DCM JOB Failed.")
        //}
      //}
  }
  post{ 
      always{ 
          cleanWs notFailBuild: true 
          } 
    }
}
