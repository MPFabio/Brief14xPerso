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
                    sh "cd staging-env && terraform ${params.Action} -auto-approve"
                }    
            }
        }   
        stage ('Var') {
            steps {
                script {
                    azureCLI commands: [[exportVariablesString: '', script: 'vm1_ip=$(az vm show -d -g nginx-server-fabio-staging -n nginx-webserver --query publicIps -o tsv)']], principalCredentialId: '692948f7-dae5-4048-8764-59ac5f958a5b'
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
                    sh "cd prod-env && terraform ${params.Action} -auto-approve"
                }    
            }
        }  

        stage ('Var-') {
            steps {
                script {
                    azureCLI commands: [[exportVariablesString: '', script: 'vm1_ip=$(az vm show -d -g nginx-server-fabio-staging -n nginx-webserver --query publicIps -o tsv)']], principalCredentialId: '692948f7-dae5-4048-8764-59ac5f958a5b'
                }
            }
        }
        
        stage ('Echo IP-') {
            steps {
                script {
                    sh "echo ${ProdPublicIP}"
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
