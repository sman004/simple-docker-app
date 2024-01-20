  
def remote = [:]
  remote.name = 'Docker Server'
  remote.host = '3.139.72.245'
  remote.user = 'deployment-user'
  remote.password = 'SeptemberClass12#'
  remote.allowAnyHosts = true

pipeline {
  agent any

  environment {
       imagename = "austinobioma/sept-docker-class"
       registryCredential = 'DockerHub'
       dockerImage = ''
       imagetag    = "latest"//"0.${env.BUILD_ID}"
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
                         //dockerImage.push("$BUILD_NUMBER")
                         dockerImage.push("$imagetag")
                                              }
                         }
               }
          }

          stage('Deploy To Docker Server Using SSH') {
               steps{
                    script {
                         sshCommand remote: remote, command: "docker run --name sept-docker -d -p 8080:80 austinobioma/sept-docker-class"
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
