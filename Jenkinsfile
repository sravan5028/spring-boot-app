pipeline {
  agent any
  tools { 
        maven 'maven'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
      withSonarQubeEnv('sonarqube') {
    sh 'mvn clean test sonar:sonar package'
nexusPublisher nexusInstanceId: 'nexus', nexusRepositoryId: 'maven_release', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/spring-230319/first_pipeline/target/spring-boot-aop-0.0.1-SNAPSHOT.jar']], mavenCoordinate: [artifactId: 'spring-boot-aop', groupId: 'com.javainuse', packaging: 'jar', version: '0.0.1']]]}
      // sh 'mvn -B -DskipTests clean package'
             }
    }
    stage('CreateInstance') {
      steps {
        node('Ansible'){
         checkout scm
         ansiblePlaybook playbook: '$WORKSPACE/createInstance.yaml'
      }
      }}
    stage('DeployArtifact') {
      steps {
        node('Ansible'){
          withMaven(maven: 'maven') {
          sh 'mvn clean package -DskipTests'
          }
       ansiblePlaybook become: true, colorized: true, credentialsId: 'ansi', disableHostKeyChecking: true, inventory: '/tmp/hosts_dev', playbook: 'deployArtifact.yaml'
        
        }}
   }

  }
}
