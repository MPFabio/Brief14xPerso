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
                    StagingPublicIP = sh(returnStdout: true, script: "terraform output The_webserver_Public_ip").trim()
                }    
            }
        }   

        stage ('Echo IP') {
            steps {
                script {
                    sh "echo ${StagingPublicIP}"
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
                    sh "cd prod-env && terraform ${params.Action} -auto-approve && ProdPublicIP=${terraform output -raw The_webserver_Public_ip}"
                }    
            }
        }  
               
        stage('SSH-') {
            steps {
                script{
                    node {
                        def remote = [:]
                        remote.name = 'fabio'
                        remote.host = "${ProdPublicIP}"
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
