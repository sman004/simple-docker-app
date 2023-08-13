  
pipeline {
  agent any

  environment {
       imagename = "austinobioma/april-docker"
       registryCredential = 'AprilDocker'
       dockerImage = ''
       imagetag    = 'v:"$BUILD_NUMBER"'
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

          stage('Remove Unused docker image') {
               steps{
                    sh "docker rmi $imagename:$BUILD_NUMBER"
                    sh "docker rmi $imagename:$imagetag"
                    sh "docker system prune -f"
                    }
          }
    
     }
}
