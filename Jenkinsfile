pipeline {

    agent any

    environment {
  		SOURCEDIR = '/home/admin1/jenkins/jenkins_home/workspace/pipeline-maven-test'
		//NAME = 'APP2'
		//ENV = 'ist'
    }

    stages {

        stage('Build') {
            steps {
                sh '''
					./jenkins/build/mvn.sh mvn -B -DskipTests clean package $SOURCEDIR
					./jenkins/build/build.sh $SOURCEDIR
				'''
            }
        }                        
        stage('Test') {
            steps {
				sh 'echo Procesing Test...'
				//sh './jenkins/test/test.sh mvn test $SOURCEDIR'
            }
        }
        stage('Push') {
            steps {
				sh 'echo Procesing Push...'
				//sh './jenkins/push/push.sh app app localhost:5000'
            }
        }
        stage('Deploy') {
            steps {
				//sh 'echo Procesing Push...'
				
				sh '''
					./jenkins/deploy/deploy_local.sh $CONTAINER_NAME $ENV $IMAGE_NAME $HOST_PORT $DOCKER_PORT
					./jenkins/deploy/publish_local.sh
					./jenkins/routing/gendomain.sh
				'''
				
            }
        }
    }
}
