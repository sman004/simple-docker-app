  
def remote = [:]
  remote.name = 'Docker Server'
  remote.host = '3.15.140.224'
  remote.user = 'ubuntu'
  remote.password = 'Juneclass12#'
  remote.allowAnyHosts = true

pipeline {
  agent any

  environment {
       imagename = "sparklins/june-class"
       registryCredential = 'DockerHub'
       dockerImage = ''
       imagetag    = "${env.BUILD_ID}"
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
                         sshCommand remote: remote, command: "docker run --name june-docker-class3 -d -p 8080:80 sparklins/june-class"
                    }
               }
          }

          stage('Remove Unused docker image') {
               steps{
                    //sh "docker rmi $imagename:$BUILD_NUMBER"
                    //sh "docker rmi $imagename:$imagetag"
                    sh "docker system prune -f"
                    }
          }
    
     }
}
