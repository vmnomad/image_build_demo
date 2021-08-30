pipeline {
  agent any
  triggers {
    pollSCM("* * * * *")
  }
  stages {
    stage('Build') {
      steps {
        sh 'echo "Building.."'
      }
    }
    stage('Test') {
      steps {
        sh 'echo "Testing.. "'
      }
    }
  }
}
