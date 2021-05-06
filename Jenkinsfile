pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        withAnt(installation: 'Ant 1.10') {
          sh "ant"
        }
      }
    }
    stage('Test') {
      steps {
        withAnt(installation: 'Ant 1.10') {
          sh "ant test"
        }
      }
    }
    stage('Build all') {
      steps {
        withAnt(installation: 'Ant 1.10') {
          sh "ant buildGO"
        }
      }
    }
  }
}
