node{
     
    stage('SCM Checkout'){
        git url: 'https://github.com/sami3108/java-web-app-docker.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
      
    } 
    
    
    stage('Build Docker Image'){
        sh 'docker build -t samikshasuryawanshi/java-web-app-docker .'
    }
    
    stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
          sh "docker login -u samikshasuryawanshi -p ${Docker_Hub_Pwd}"
        }
        sh 'docker push samikshasuryawanshi/java-web-app-docker'
     }
     
      stage('Run Docker Image In Dev Server'){
        
        def dockerRun = ' docker run  -d -p 8080:8080 --name java-web-app samikshasuryawanshi/java-web-app-docker'
         
         sshagent(['DOCKER_SERVER']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@192.168.0.53 docker stop java-web-app || true'
          sh 'ssh  ubuntu@192.168.0.53 docker rm java-web-app || true'
          sh 'ssh  ubuntu@192.168.0.53 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ubuntu@192.168.0.53 ${dockerRun}"
       }
       
    }
     
     
}
