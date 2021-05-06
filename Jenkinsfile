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
    stage('Approve Tests') {
      agent none
      steps {
        input "Approve tests and proceed with artifact build?"
      }
    }
    stage('Build all') {
      steps {
        withAnt(installation: 'Ant 1.10') {
          sh "ant buildGO"
        }
      }
    }
    stage('Approve Release') {
      agent none
      steps {
        input "Approve release?"
      }
    }
    stage('Create deployment') {
      steps {
        sh "ls -l"
      }
    }
    stage('Approve deployment') {
      agent none
      steps {
        input "Approve tests and proceed with artifact build?"
        sh "ls -l"
        sh "evho triggering some URL
      }
    }
  }
}
