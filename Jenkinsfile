pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('9e4903bf-6963-465c-826b-2a957ee657e7')
        ARM_CLIENT_SECRET   = credentials('akv8Q~Z~sIPFAAqAkwa2DWlRMNa.FJcjKXH.oa0L')
        ARM_SUBSCRIPTION_ID = credentials('a9076473-03ad-4c76-8993-4edd69689ba6')
        ARM_TENANT_ID       = credentials('d7c44a8d-e761-4608-b572-6b22608509a4')

        TF_ROOT = 'module'
        TF_PLAN = 'tfplan'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Ashish21-hedau/Jenkins--terraforn-code.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_ROOT}") {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_ROOT}") {
                    bat 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_ROOT}") {
                    bat "terraform plan -out=${TF_PLAN}"
                }
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Approve Infrastructure Deployment?'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_ROOT}") {
                    bat "terraform apply -auto-approve ${TF_PLAN}"
                }
            }
        }
    }
}
