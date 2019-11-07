#!/usr/bin/env groovy
@Library('github.com/stakater/stakater-pipeline-library@update-toolsNode') _

executeMakeTargets {
    target= "install"
    notifySlack= true
    pushToS3= false
    NAMESPACE= "nordmart-dev-apps"
    image= "stakater/pipeline-tools:v2.0.12"
    requiredParams= ["NAMESPACE"]
}
