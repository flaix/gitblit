@NonCPS
def fileList(dir) {
    def list = []
    
    // If you don't want to search recursively then change `eachFileRecurse` -> `eachFile`
    dir.eachFile(groovy.io.FileType.FILES) {
      list << it.getName()
    }
    
   // list.join(",")
}

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
          sh "echo Tests are run here"
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
        sh "ls -l build/target"
        script {
          def dir = new File(pwd(), "build/target")
          def files = fileList(dir)
          echo "Files: " + files
            
          def apparts = input( message: 'Approve release?', submitter: 'florian', parameters: [
              choice( name: 'Files', description: 'Select the files to release.', choices: files)
          ])
            
          echo "Choice: " + apparts
        }

      }
    }
    stage('Create deployment') {
      steps {
        sh "ls -l build/target"
        sh "env"
      }
    }
    stage('Approve deployment') {
      agent none
      steps {
        input "Approve tests and proceed with artifact build?"
        sh "ls -l"
        echo "Triggering some URL"
      }
    }
  }
}
