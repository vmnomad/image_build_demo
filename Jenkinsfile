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
    stage('Deploy') {
      steps {
        sh 'echo "Deploying"'
        sh 'echo Test Commit'
        sh 'echo Test PR2'
      }
    }
  }
}
