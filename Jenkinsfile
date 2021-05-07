@NonCPS
def fileList(dir) {
    def list = []
    
    // If you don't want to search recursively then change `eachFileRecurse` -> `eachFile`
    dir.eachFile(groovy.io.FileType.FILES) {
      list << it.getName()
    }
    
    return list
   // list.join(",")
}

def releasedFiles = ''


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
          def filesString = files.join(',')
          echo "Files string: " + filesString
          
//          def params = [ choice( name: 'Files', description: 'Select the files to release.', choices: files) ]
            def params = [ extendedChoice( name: 'Files',
                                        description: 'Select files to release.', 
                                        type: 'PT_MULTI_SELECT',
                                        defaultValue: filesString, 
                                        value: filesString,
                                        //descriptionPropertyValue: 'blue,green,yellow,blue', 
                                        //multiSelectDelimiter: ',', 
                                        //quoteValue: false,
                                        //saveJSONParameterToFile: false,
                visibleItemCount: 5) ]
          def apparts = input( message: 'Approve release?', submitter: 'florian', ok: 'Release', parameters: params)
          
          echo "Choice: " + apparts
            
          releasedFiles = apparts
        }

      }
    }
    stage('Create deployment') {
      steps {
        sh "ls -l build/target"
        echo "Release choice is $releasedFiles"
        script {
            def relFilesList = releasedFiles.split(',')
            echo "Released files:"
            for (fn : relFilesList ) {
                echo "$fn"
            }
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
