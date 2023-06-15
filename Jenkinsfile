pipeline {
    agent any
  
    parameters
    {
        booleanParam(defaultValue: true, description: '', name: 'Deploy')
        string(name: 'Environment', defaultValue: "", description: '')
        choice(choices: ['apply', 'destroy'], name: 'Action')
    }
    
    stages {
        
        stage ('Terraform Init') {
            steps {
                echo "${params.Environment}"
                script {
                    sh "cd ${params.Environment} && terraform init"
                }                
            }
        }
    
        stage ('Terraform Plan') {
            steps {
                script {
                    sh "cd ${params.Environment} && terraform plan"
                }
            }
        }

        stage ('Terraform apply') {
            steps {
                script {
                    sh "cd ${params.Environment} && terraform ${params.Action} -auto-approve"
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
                        remote.host = '4.233.106.239'
                        remote.user = 'fabio'
                        remote.password = '****'
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
