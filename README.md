🚀 AI Image Gallery – DevOps Automation Platform
📌 Overview

This project simulates a real-world DevOps implementation for a company modernizing its deployment and infrastructure management processes.

Company XYZ Ltd. released a limited-access AI-powered image gallery application as a teaser for a broader suite of AI services. As user demand increased and additional AI features were planned for release, the engineering team faced challenges with manual deployments, inconsistent infrastructure, and slow update cycles.

This project provides a production-style solution by implementing:

Infrastructure as Code using Terraform
Automated CI/CD pipelines with GitHub Actions
Containerized backend deployments using Docker and AWS ECS
Frontend deployment automation handled via GitHub Actions
Centralized state management using HashiCorp Cloud Platform (HCP)

This project reflects real-world DevOps practices including multi-environment deployments (dev/prod), CI/CD automation, and infrastructure troubleshooting.

🧩 Business Problem

The company’s initial deployment model relied heavily on manual processes, leading to:

Slow and error-prone infrastructure updates
Inconsistent environments (configuration drift)
Lack of deployment automation
Limited scalability and reliability

As the platform evolved, these limitations created risk in production and slowed down feature delivery.

💡 Solution

A fully automated DevOps pipeline was designed to standardize and streamline infrastructure and application deployment.

Key components:
Terraform → Declarative infrastructure provisioning
HCP Terraform → Remote state management and workspace isolation
AWS ECS (Fargate) → Scalable containerized compute
Docker → Consistent application packaging
GitHub Actions → CI/CD pipeline for automated deployments

🏗️ Architecture

Frontend → Static assets deployed via GitHub Actions (S3/hosting layer)
Backend → Docker container deployed to AWS ECS
Infrastructure → Provisioned via Terraform
State Management → HCP Terraform workspace (ai-image-gallery-prod)
CI/CD → GitHub Actions (frontend deployment + Terraform automation)

🔁 CI/CD Workflow

The deployment pipeline automates both infrastructure provisioning and application delivery, with clear separation of environments and responsibilities.

🌍 Environment Strategy (GitHub Actions + HCP)

Production Environment
Triggered on push to main
Uses HCP workspace: ai-image-gallery-prod
Deploys live infrastructure and backend services
Development Environment
Triggered on changes to dev branch (or feature branches)
Uses separate HCP workspace (dev)
Enables safe testing before production deployment

⚙️ Backend / Infrastructure Pipeline

Code pushed to appropriate branch (main = prod, dev = dev)
GitHub Actions workflow is triggered
Terraform initializes using HCP backend
Workspace is selected based on environment
Terraform plan is generated
Terraform apply updates infrastructure
Backend services are deployed to AWS ECS

🎨 Frontend Deployment Pipeline

Frontend code is handled independently via GitHub Actions
Static assets are built and deployed automatically
Enables rapid UI updates without modifying infrastructure

💡 Key Benefits

Independent pipelines for frontend, backend, and infrastructure
Safer deployments with reduced blast radius
Faster iteration cycles
Consistent and repeatable deployments

⚙️ Key Features

Infrastructure fully managed with Terraform
Remote state stored securely in HCP Terraform
Automated CI/CD pipeline for infrastructure deployment
Frontend deployment automated via GitHub Actions
Containerized backend application using Docker
Scalable backend deployment via AWS ECS
Secure credential handling using GitHub Secrets
Environment-based deployment model (dev/prod workspaces)

🔐 Authentication & State Management

Terraform state is managed in HCP Terraform
CLI authentication:
terraform login
GitHub Actions uses:
TF_API_TOKEN for HCP access
AWS credentials via GitHub Secrets

🧪 Local Development

git clone <repo>
cd terraform/environments/prod
terraform init
terraform plan

🚧 Troubleshooting & Challenges

1. HCP Terraform workspace not visible

Issue:
Workspaces were not appearing when logged in via email.

Root cause:
Account mismatch between email login and GitHub OAuth identity.

Solution:

Re-authenticated using terraform login
Logged in via GitHub OAuth
Confirmed correct organization: aws-landing-zone
2. Terraform backend misconfiguration

Issue:
terraform init did not link to the correct workspace.

Root cause:
Incorrect organization or workspace name in backend configuration.

Solution:

terraform {
  cloud {
    organization = "aws-landing-zone"

    workspaces {
      name = "ai-image-gallery-prod"
    }
  }
}
3. GitHub Actions authentication failures

Issue:
Pipeline failed during Terraform execution.

Root cause:
Missing or incorrect TF_API_TOKEN in GitHub Secrets.

Solution:

Generated API token from HCP Terraform
Added to GitHub Secrets
Verified workflow authentication
4. AWS credential configuration issues

Issue:
Terraform or pipeline could not provision AWS resources.

Root cause:
Improper AWS credentials or insufficient permissions.

Solution:

Configured IAM user with appropriate permissions
Added credentials to GitHub Secrets
Verified access via CLI and pipeline
5. Infrastructure changes not reflecting

Issue:
Changes pushed to the repository did not update infrastructure.

Root cause:

Workflow not triggering
Incorrect working directory in GitHub Actions
Terraform not detecting changes

Solution:

Fixed workflow trigger paths
Ensured correct directory (terraform/environments/prod)
Re-ran workflow and validated Terraform plan output

📈 Future Improvements

Implement full dev/prod environment isolation with promotion workflows
Add blue/green deployment strategy
Integrate monitoring and observability (CloudWatch, Prometheus, Grafana)
Add auto-scaling and load balancing enhancements
Introduce centralized secrets management (AWS Secrets Manager)

🎯 What This Project Demonstrates

Real-world infrastructure automation using Terraform
CI/CD pipeline integration with cloud infrastructure
AWS containerized deployment patterns (ECS + Docker)
Remote state management and environment isolation
Debugging and troubleshooting cloud authentication and pipeline issues

🧠 Final Note

This project reflects how modern DevOps teams operate in production environments by combining automation, reliability, and scalability while minimizing deployment risk.
