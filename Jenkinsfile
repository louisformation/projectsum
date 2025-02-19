pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub' // Nom de vos identifiants Jenkins
        DOCKER_IMAGE = 'louis367/calculator2025' // Remplacez par votre utilisateur et image Docker Hub
    }

    stages {
        stage("Checkout") {
            steps {
                git branch: 'main',
                    credentialsId: 'jenkinsgithubssh',
                    url: 'git@github.com:louisformation/projectsum.git'
            }
        }

        stage("Compile") {
            steps {
                sh 'chmod +m mvnw'
                sh './mvnw compile'
            }
        }

        stage("Test") {
            steps {
                sh './mvnw test'
            }
        }

        stage("Package") {
            steps {
                sh './mvnw package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Connexion à Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push de l'image Docker
                    sh 'docker push ${DOCKER_IMAGE}:latest'
                }
            }
        }

       /*  stage("Run and Test") {
            steps {
                sh 'chmod +x script.sh'
                sh './script.sh'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh "./mvnw sonar:sonar"
                }
            }
        }

        stage("Quality Gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        } */
    }

    post {
        always {
            // Nettoyage après le pipeline
            //et deconnection
            sh 'docker stop test || true'
            sh 'docker rm test || true'
            sh 'docker logout'
        }
    }
}
