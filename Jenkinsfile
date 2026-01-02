pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('9e4903bf-6963-465c-826b-2a957ee657e7')
        ARM_CLIENT_SECRET   = credentials('Zqs8Q~fFDlkiVhIwVTxOwXP8OZsurEmFrCt.Gcj6')
        ARM_TENANT_ID       = credentials('d7c44a8d-e761-4608-b572-6b22608509a4')
        ARM_SUBSCRIPTION_ID = credentials('a9076473-03ad-4c76-8993-4edd69689ba6')
        TF_ROOT             = 'module'
        TF_PLAN             = 'tfplan'
    }

    options {
        timestamps()
        skipStagesAfterUnstable()
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Ashish21-hedau/Jenkins--terraforn-code.git'
            }
        }

        stage('Check Workspace') {
            steps {
                echo "Jenkins Workspace Path:"
                sh 'pwd'
                echo "Workspace Folder Structure:"
                sh 'ls -R'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_ROOT}") {
                    echo "Initializing Terraform in ${TF_ROOT}..."
                    sh 'terraform init'   // <- backend.tf remove kar diya
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_ROOT}") {
                    echo "Validating Terraform configuration..."
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_ROOT}") {
                    echo "Generating Terraform plan..."
                    sh "terraform plan -out=${TF_PLAN}"
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
                    echo "Applying Terraform plan..."
                    sh "terraform apply -auto-approve ${TF_PLAN}"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning Jenkins workspace...'
            cleanWs()
        }
        success {
            echo 'Terraform executed successfully ✅'
        }
        failure {
            echo 'Terraform failed ❌'
        }
    }
}
