pipeline {
    agent any

        stages {
            stage('Cleanup') {
                steps {
                    script {
                        sh 'rm -rf firka-builder'
                    }
                }
            }
            stage('Clone firka') {
                steps {
                    script {
                        sh 'rm -rf src'
                    }
                    dir('src') {
                    	checkout scm
                    }
					script {
                        sh 'cd src && git submodule update --init --recursive'
                    }
                }
            }

            stage('Make work dir') {
                steps {
                    script {
                        sh 'mkdir -p work'
                    }
                }
            }

            stage('Make cache dir') {
                steps {
                    script {
                        sh 'mkdir -p cache'
                    }
                }
            }

           	stage('Clone builder release') {
	           	when {
           	       branch 'main'
	           	}
               	steps {
                   	git url: 'https://git.qwit.cloud/firka/firka-builder.git', branch: 'release'
                }
           	}

           	stage('Clone builder debug') {
           		when {
           			not {
           				branch 'main'
           			}
           		}
           		steps {
            		git url: 'https://git.qwit.cloud/firka/firka-builder.git', branch: 'debug'
           		}
           	}

            stage('Build firka') {
                steps {
                    sh 'python3 wrapper.py'
                }
            }

            stage('Publish release artifacts') {
            	when {
           	       branch 'main'
  	           	}
            	steps {
            	    zip zipFile: 'coverage.zip', archive: false, dir: 'work/firka/coverage'
           			archiveArtifacts artifacts: 'coverage.zip', fingerprint: true
           			archiveArtifacts artifacts: 'work/firka/build/app/outputs/apk/release/app-*-release.apk', fingerprint: true
           		}
            }
            
           	stage('Publish debug artifacts') {
           		when {
           			not {
           				branch 'main'
           			}
           		}
           		steps {
                    zip zipFile: 'coverage.zip', archive: false, dir: 'work/firka/coverage'
                    archiveArtifacts artifacts: 'coverage.zip', fingerprint: true
           			archiveArtifacts artifacts: 'work/firka/build/app/outputs/apk/debug/app-debug.apk', fingerprint: true
           		}
            }
    }

	post {
        always {
            script {
                sh 'pwd && docker compose down'
            }
        }
	}
}
