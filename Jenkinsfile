#!/usr/bin/env groovy
@Library('github.com/stakater/stakater-pipeline-library@v2.16.11') _

executeMakeTargets {
    target= "install-dry-run"
    notifySlack= true
    pushToS3= false
    NAMESPACE= "nordmart-dev-apps"
    image= "stakater/builder-tool:terraform-0.11.11-v0.0.13"
    requiredParams= ["NAMESPACE"]
}
