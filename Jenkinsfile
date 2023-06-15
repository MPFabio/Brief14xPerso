pipeline {
    agent any
  
    parameters
    {
        booleanParam(defaultValue: true, description: '', name: 'Deploy')
        choice(choices: ['apply', 'destroy'], name: 'Action')
    }
    
    stages {
        
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
                    sh "cd staging-env && terraform ${params.Action} -auto-approve && terraform output -raw The_webserver_Public_ip"
                        environment {
                            StagingPublicIP="${terraform output -raw The_webserver_Public_ip}"
                        }
                }    
            }
        }   
        
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
                    sh 'cd app && sudo docker tag fabio-tp-game fabiomp/fabio-brief14'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh 'sudo docker login -u fabiomp -p Aucunmdp69' 
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
               
        stage('SSH') {
            steps {
                script{
                    node {
                        def remote = [:]
                        remote.name = 'fabio'
                        remote.host = "$StagingPublicIP"
                        remote.user = 'fabio'
                        remote.password = 'Azerty-123'
                        remote.allowAnyHosts = true
                        stage('Remote SSH') {
                            sshCommand remote: remote, command: "sudo docker pull fabiomp/fabio-brief14"
                            sshCommand remote: remote, command: "sudo docker run -d -p 1234 --name tondocker fabiomp/fabio-brief13"       
                        }
                    }
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
                    sh "cd prod-env && terraform ${params.Action} -auto-approve && terraform output -raw The_webserver_Public_ip"
                        environment {
                            ProdPublicIP="${terraform output -raw The_webserver_Public_ip}"
                        }
                }    
            }
        }  
               
        stage('SSH-') {
            steps {
                script{
                    node {
                        def remote = [:]
                        remote.name = 'fabio'
                        remote.host = "$ProdPublicIP"
                        remote.user = 'fabio'
                        remote.password = 'Azerty-123'
                        remote.allowAnyHosts = true
                        stage('Remote SSH') {
                            sshCommand remote: remote, command: "sudo docker pull fabiomp/fabio-brief14"
                            sshCommand remote: remote, command: "sudo docker run -d -p 1234 --name tondocker fabiomp/fabio-brief13"       
                        }
                    }
                }
            }        
        }   
    }
}
