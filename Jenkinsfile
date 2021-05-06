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
          def apparts = input (message:  "Approve release?", submitter: "florian", parameters: [ 
            [$class: 'ExtensibleChoiceParameterDefinition', description: 'Artifacts to release', name: 'Artifacts', choiceListProvider: 
              [$class: 'FilenameChoiceListProvider', baseDirPath: './build/target', scanType: ScanType.File]
            ]
          ])
          echo "Approved artifacts: $apparts"
        }
      }
    }
    stage('Create deployment') {
      steps {
        sh "ls -l build/target"
        script {
          def list = []
          def dir = new File(pwd(), "build/target")
          // If you don't want to search recursively then change `eachFileRecurse` -> `eachFile`
          dir.eachFile(groovy.io.FileType.FILES) {
            list << it.getName()
          }
          list.join("\n")
          echo "Files: " + list
        }
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
