  
def remote = [:]
  remote.name = 'Docker Server'
  remote.host = '3.16.217.232'
  remote.user = 'ubuntu'
  remote.password = 'Aprilclass2023'
  remote.allowAnyHosts = true

pipeline {
  agent any

  environment {
       imagename = "austinobioma/april-docker"
       registryCredential = 'AprilDocker'
       dockerImage = ''
       imagetag    = "0.${env.BUILD_ID}"
           }

     stages {

          stage('Building Docker image') {
               steps{
                   script {
                       dockerImage = docker.build imagename
                          }
               }
          }

          stage('Push Image To DockerHub') {
               steps{
                     script {
                         docker.withRegistry( '', registryCredential ) {
                         dockerImage.push("$BUILD_NUMBER")
                         dockerImage.push("$imagetag")
                                              }
                         }
               }
          }

          stage('Deploy To Docker Server Using SSH') {
               steps{
                    script {
                         sshCommand remote: remote, command: "docker run --name april-docker -d -p 8080:80 austinobioma/april-docker:0.8"
                    }
               }
          }

          stage('Remove Unused docker image') {
               steps{
                    sh "docker rmi $imagename:$BUILD_NUMBER"
                    sh "docker rmi $imagename:$imagetag"
                    sh "docker system prune -f"
                    }
          }
    
     }
}
