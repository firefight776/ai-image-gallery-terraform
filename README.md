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

🔷 Architecture Overview

This project implements a production-style AI image gallery application deployed on AWS using Infrastructure as Code and a CI/CD pipeline.
At a high level, the system enables users to upload images, store them in the cloud, and generate AI-powered descriptions using a serverless backend.

🔷 System Flow (End-to-End)
User Interaction
Users access the application via a public URL routed through DNS.
The frontend is served by a containerized web application.
Frontend Application (ECS Fargate)
The UI is hosted in a Docker container running on AWS ECS Fargate.
Traffic is routed through an Application Load Balancer for high availability.
Image Upload Workflow
When a user uploads an image:
The request is sent to a backend endpoint (Lambda/API).
The image is stored in an S3 bucket.
Metadata & AI Processing
A Lambda function processes the uploaded image.
The function:
Calls Amazon Bedrock to generate an AI description
Stores metadata (image URL, description) in DynamoDB
Data Retrieval
The frontend fetches stored image data and metadata from the backend.
Images are displayed dynamically in the gallery.

🔷 CI/CD Pipeline

The application uses a modern CI/CD pipeline built with GitHub Actions:

Code changes pushed to main trigger the dev deployment pipeline
Releases/tags trigger the production deployment pipeline

Pipeline Steps:
Build Docker image
Push image to Amazon ECR
Deploy updated container to ECS service

This ensures:
Consistent deployments
Automated infrastructure updates
Environment separation (dev vs prod)
🔷 Infrastructure Components
Compute
ECS Fargate – Runs containerized frontend application
AWS Lambda – Handles backend processing and AI integration
Storage
Amazon S3 – Stores uploaded images and static assets
DynamoDB – Stores image metadata and AI-generated descriptions
Networking
Application Load Balancer (ALB) – Routes traffic to ECS services
VPC with private subnets – Secure application infrastructure
CI/CD
GitHub Actions – Automates build and deployment workflows
Amazon ECR – Stores Docker images
AI Integration
Amazon Bedrock – Generates image descriptions
Supporting Services
IAM – Access control and permissions
CloudWatch – Logging and monitoring
Route 53 – DNS routing
ACM – SSL/TLS certificates
🔷 Key Design Decisions
Serverless + Containers Hybrid
ECS for frontend scalability
Lambda for event-driven backend logic
Environment Separation
Dev and Prod pipelines ensure safe testing before release
Infrastructure as Code
Terraform used for reproducible and version-controlled infrastructure
Event-Driven Processing
Image uploads trigger backend workflows asynchronously

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

- Infrastructure fully managed using Terraform
- Remote state management with HCP Terraform
- Automated CI/CD pipelines with GitHub Actions
- Hybrid serverless and containerized architecture
- Secure credential management using GitHub Secrets
- Environment-based deployments using dev and prod workspaces

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
