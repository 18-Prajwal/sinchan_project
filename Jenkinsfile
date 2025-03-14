pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage("Pull SRC") {
            steps {
                git branch: 'main', url: 'https://github.com/18-Prajwal/sinchan_project.git'
            }
        }
        stage("move the target") {
            steps {
                sh 'mv target/students.war .'
            }
        }
        stage("Prepare Build") {
            steps {
                sh 'mvn clean package'
            }
        }
        stage("build docker image"){
            steps{
                sh 'docker build -t app .'
            }
        }
        stage("tag image"){
            steps{
                sh 'docker tag app prajwal0303/webapp:latest'
            }
        }
        stage("push image"){
            steps{
               sh 'echo "Prajwal@2003"| docker login -u prajwal0303 --password-stdin'
                sh 'docker push prajwal0303/webapp:latest'
            }
        }
        stage("remove images locally"){
            steps{
                sh 'docker rmi  app'
            }
        }
        
        stage("run ansible playbook") {
            steps {
                sshPublisher(
                    continueOnError: false, 
                    failOnError: true,
                    publishers: [
                        sshPublisherDesc(
                            configName: "remote",
                            transfers: [
                                sshTransfer(sourceFiles: 'play.yml'),
                                sshTransfer(execCommand: "ansible-playbook play.yml")
                            ],
                            verbose: true
                        )
                    ]
                )
            }
        }
    }
}
