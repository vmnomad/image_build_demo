pipeline {
  agent any
  triggers {
    pollSCM("* * * * *")
  }
  stages {
    stage('Validate') {
      steps {
        sh "pwd"
        sh "ls -lha"
      }
    }
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
