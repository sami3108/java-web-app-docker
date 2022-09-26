node {
    def buildNumber=BUILD_NUMBER
    stage("Git Clone")
    {
        git url: 'https://github.com/sami3108/java-web-app-docker.git',branch: 'master'
    }
    stage ("Maven Clean Package"){
        def mavenHome= tool name:"Maven",type:"maven"
        sh "${mavenHome}/bin/mvn clean package"
    }
    stage ("Build Docker Image")
    {
        sh "docker build -t samikshasuryawanshi/java-web-app-docker:${buildNumber} ."
    }
     stage ("Docker Login and Push")
    {
        withCredentials([string(credentialsId: 'DockerHubPwd', variable: 'DockerHubPwd')]) 
        {
            sh "docker login -u samikshasuryawanshi -p ${DockerHubPwd}"
        }
        sh "docker push samikshasuryawanshi/java-web-app-docker:${buildNumber}"
    }
    stage ("Deploy application as Docker Container In Docker Deployment Server ")
    {
        sshagent(['Docker_Dev_Server_SSH']) 
        {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@192.168.0.53 docker rm -f javawebappcontainer || true "
            sh "ssh -o StrictHostKeyChecking=no ubuntu@192.168.0.53 docker run -d -p 8080:8080 --name javawebappcontainer samikshasuryawanshi/java-web-app-docker:${buildNumber} "
        }
    }
}
