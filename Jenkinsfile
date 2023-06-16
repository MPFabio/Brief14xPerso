   pipeline {
    agent any
    
    stages {
              
       stage ('Docker Build') {
            steps {
                script {
                    sh 'cd app && sudo docker build -t fabio-brief14 .'
                    echo 'Build Image Completed'
                }    
            }
        }

        stage ('Docker Tag') {
            steps {
                script {
                    sh 'cd app && sudo docker tag fabio-brief14 fabiomp/fabio-brief14'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh 'sudo docker login -u **** -p ****' 
                }    
            }
        }

        stage ('Docker Push') {
            steps {
                script {
                    sh 'cd app && sudo docker push fabiomp/fabio-brief14'        
                }    
            }
        } 
        stage ('Terraform Init') {
            steps {
                script {
                    sh "cd staging-env && terraform init"
                }                
            }
        }
    
        stage ('Terraform Plan') {
            steps {
                script {
                    sh "cd staging-env && terraform plan"
                }
            }
        }

        stage ('Terraform Apply') {
            steps {
                script {
                    sh "cd staging-env && terraform apply -auto-approve"
                }    
            }
        }   

        stage ('Input') {
            steps {
                input message: 'Is the staging deployment good ?', ok: 'ok'
            }
        }

                stage ('Terraform-Init') {
            steps {
                script {
                    sh "cd prod-env && terraform init"
                }                
            }
        }
    
        stage ('Terraform-Plan') {
            steps {
                script {
                    sh "cd prod-env && terraform plan"
                }
            }
        }

        stage ('Terraform-Apply') {
            steps {
                script {
                    sh "cd prod-env && terraform apply -auto-approve"
                }    
            }
        }  
    }
}
