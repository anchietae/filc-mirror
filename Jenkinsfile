pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                script {
                    sh '''#!/bin/sh
                    set -x
                    nix-shell -p gocryptfs --command "fusermount -u secrets" || true
                    rm secrets/keystore.properties || true
                    rm secrets/*.jks || true
                    '''
                }
            }
        }

        stage('Decrypt keys') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def userInput = input(
                        id: 'signaturePassword',
                        message: 'Please enter the signing key password:',
                        parameters: [
                            password(
                                defaultValue: '',
                                description: 'Enter the signing key password',
                                name: 'password'
                            )
                        ]
                    )

                    env.PASSWORD = userInput.toString()
                }

                sh '''#!/bin/sh
                echo \$PASSWORD | nix-shell -p gocryptfs --command "gocryptfs $HOME/android_secrets secrets/ -nonempty"
                '''
            }
        }
        
        stage('Copy keys') {
            when {
                branch 'dev'
            }
            steps {
                sh '''#!/bin/sh
                cp -v $HOME/android_staging_secrets/*.jks secrets/
                cp -v $HOME/android_staging_secrets/keystore.properties secrets
                '''
            }
        }

        stage('Clone submodules') {
            steps {
                script {
                    sh 'git submodule update --init --recursive'
                }
            }
        }

        stage('Build firka') {
            steps {
                sh 'nix develop -c "./tools/linux/build_apk.sh" "' + env.BRANCH_NAME + '"'
            }
        }

        stage('Publish release artifacts') {
            when {
                branch 'main'
            }
            steps {
                archiveArtifacts artifacts: 'firka/build/app/outputs/flutter-apk/app-*-production-release.apk', fingerprint: true
            }
        }

        stage('Publish debug artifacts') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                archiveArtifacts artifacts: 'firka/build/app/outputs/flutter-apk/app-*-staging-release.apk', fingerprint: true
                archiveArtifacts artifacts: 'firka/build/apk-code-size-analysis_*.json', fingerprint: true
            }
        }
    }
}
