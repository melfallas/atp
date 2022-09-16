pipeline {

    agent any

    environment {
  		//SOURCEDIR = '/home/ubuntu/jenkins/jenkins_home/workspace'
		//NAME = 'APP2'
		//ENV = 'ist'
		TEST='test'
		TEST1='test'
		/*
		withCredentials([string(credentialsId: 'DGTOKEN', variable: 'DOMAIN_API_TOKEN')]) {
			DGTOKEN = ${DOMAIN_API_TOKEN}
		}
		*/
    }

    stages {
		stage('Initialize') {
            // Each stage is made up of steps
            steps{
                script{
                    SOURCEDIR = '/home/linux_user/jenkins/jenkins_home/workspace'
                }
            }
        }
        stage('Build') {
            steps {
				//sh 'echo Procesing Build...'
				
                sh """
					./jenkins/build/mvn.sh mvn -B -DskipTests clean package ${SOURCEDIR}/${JOB_NAME}
					./jenkins/build/build.sh ${SOURCEDIR}/${JOB_NAME}
				"""
				
            }
        }                        
        stage('Test') {
            steps {
				sh 'echo Procesing Test...'
				//sh './jenkins/test/test.sh mvn test ${SOURCEDIR}/${JOB_NAME}'
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
				'''
				/*
				withCredentials([string(credentialsId: 'DGTOKEN', variable: 'DOMAIN_API_TOKEN')]) {
					sh '''
					./jenkins/deploy/deploy_local.sh $CONTAINER_NAME $ENV $IMAGE_NAME $HOST_PORT $DOCKER_PORT
					./jenkins/deploy/publish_local.sh
					'''
				}
				*/
            }
        }
    }
}
