#!/usr/bin/env groovy
@Library('github.com/stakater/stakater-pipeline-library@revamp') _

def utils = new io.fabric8.Utils()
def flow = new io.stakater.StakaterCommands()
def tokenSecret = flow.getProviderTokenFromJenkinsSecret("GithubToken")

timeout(time: 20, unit: 'MINUTES') {
    timestamps {
        stakaterNode([serviceAccount: 'stakater-release-jenkins']) {
            container(name: 'tools') {
                stage('Install') {
                    try {
                        checkout scm
                        String selectedTarget

                        // if master branch
                        if (utils.isCD()) {
                            selectedTarget = "install"
                        } else {
                            selectedTarget = "install-dry-run"
                        }

                        executeMakeTargets {
                            target = selectedTarget
                            NAMESPACE = "nordmart-dev-apps"
                        }

                    } catch (err) {
                        echo "Error: ${err}"
                        throw err
                    }
                }
            }
        }
    }
}