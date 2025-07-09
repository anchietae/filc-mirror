pipeline {
    agent any

    stages {
        stage('Cleanup') {
            steps {
                script {
                    sh '''#!/bin/sh
                    set -x
                    nix-shell -p gocryptfs --command "fusermount -u secrets" || true
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
                archiveArtifacts artifacts: 'firka/build/app/outputs/flutter-apk/app-*-release.apk', fingerprint: true
            }
        }

        stage('Publish debug artifacts') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                archiveArtifacts artifacts: 'firka/build/app/outputs/flutter-apk/app-debug.apk', fingerprint: true
            }
        }
    }
}
