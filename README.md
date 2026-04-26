🚀 AI Image Gallery – DevOps Automation Platform
📌 Overview

Built and deployed a production-grade, Terraform-managed AWS platform with CI/CD pipelines, containerized services (ECS Fargate), and serverless workflows, enabling scalable AI-powered image processing with isolated dev and prod environments.

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

## 🏗️ Infrastructure as Code & Environment Strategy
All infrastructure in this project was provisioned using Terraform with remote state managed in HCP Terraform. Separate development and production environments were implemented using isolated workspaces and configurations.

<img width="1901" height="372" alt="Screenshot 2026-04-24 203439" src="https://github.com/user-attachments/assets/7780ffd9-daa2-40c3-8ce4-93f66c0ed0b4" />
Terraform initialized with HCP backend, confirming remote state storage and workspace integration.

<img width="1894" height="340" alt="Screenshot 2026-04-24 203231" src="https://github.com/user-attachments/assets/fada112d-8d2b-44f7-bd12-d7a44c53250b" />
Terraform state output showing provisioned AWS resources, including ALB, ECS services, Route 53 records, and monitoring components.

<img width="403" height="808" alt="Screenshot 2026-04-24 201151" src="https://github.com/user-attachments/assets/cca7af54-881f-427c-b786-3d9042158fb8" />
<img width="441" height="730" alt="Screenshot 2026-04-24 201209" src="https://github.com/user-attachments/assets/4ee60904-3424-445c-9d51-7f211436e620" />
<img width="387" height="710" alt="Screenshot 2026-04-24 201224" src="https://github.com/user-attachments/assets/a61a0c37-2a3b-473e-94b0-a343f0e53213" />
Modular Terraform structure used to organize infrastructure components, including VPC, ECS, Lambda, S3, and networking layers.

<img width="1919" height="982" alt="Screenshot 2026-04-21 113629" src="https://github.com/user-attachments/assets/952a4698-cfe1-4312-8e2d-dda7cd9308f4" />
<img width="1901" height="748" alt="Screenshot 2026-04-21 114945" src="https://github.com/user-attachments/assets/8ca4676a-e88d-405c-8f86-04d3d4e1dbfc" />
<img width="1833" height="738" alt="Screenshot 2026-04-21 115000" src="https://github.com/user-attachments/assets/71ed05f0-1035-4d06-a96e-be9dc7fdb2af" />
<img width="403" height="808" alt="Screenshot 2026-04-24 201151" src="https://github.com/user-attachments/assets/4124306f-bb37-4166-83e6-68ffda1a8488" />
<img width="1916" height="1032" alt="Screenshot 2026-04-21 113607" src="https://github.com/user-attachments/assets/cd155b56-5d44-41fc-9fe3-a39821c9d19f" />
Separate development and production environments deployed with distinct configurations, enabling safe testing and controlled production releases.


## 📸 System in Action

The following screenshots demonstrate the live application and underlying AWS infrastructure components in action.
### Live Application
<img width="1915" height="949" alt="Screenshot 2026-04-26 132926" src="https://github.com/user-attachments/assets/ffb2c4ff-8f8d-4f9f-b4ba-ece70fc62778" />
User-facing web interface served via ECS Fargate behind an Application Load Balancer. Users can upload images and view AI-generated descriptions rendered dynamically from backend services.

### Storage Layer (S3)
<img width="1886" height="751" alt="Screenshot 2026-04-24 200057" src="https://github.com/user-attachments/assets/96730a32-4a99-40df-b03f-98eff8b64183" />
Amazon S3 bucket storing uploaded image assets. Each file is persisted as an object and serves as the source of truth for the application’s media layer.

### Data Layer (DynamoDB)
<img width="1169" height="723" alt="Screenshot 2026-04-24 195631" src="https://github.com/user-attachments/assets/f2e315fd-4632-4eb3-8225-6a7ad50195ab" />
DynamoDB table storing image metadata, including AI-generated descriptions. Each record maps to an S3 object, enabling fast and scalable retrieval for frontend rendering.


### Load Balancing & Traffic Routing (ALB)
<img width="1908" height="752" alt="Screenshot 2026-04-24 200859" src="https://github.com/user-attachments/assets/53471aa1-bf51-46e8-ba16-c2e3f8cfb12b" />

<img width="1914" height="741" alt="Screenshot 2026-04-24 200718" src="https://github.com/user-attachments/assets/f104bd60-a73f-47ad-ab7e-3bee89e13837" />
Application Load Balancer (ALB) handling incoming traffic and routing requests to ECS services. HTTP traffic is automatically redirected to HTTPS, and secure requests are forwarded to the target group associated with the containerized application.

### Compute Layer (ECS Fargate)
<img width="1908" height="752" alt="Screenshot 2026-04-24 200859" src="https://github.com/user-attachments/assets/d8a5b595-a417-47e2-831b-c78e9c37a4eb" />
Amazon ECS Fargate cluster running the containerized application workload, with one active service maintaining two running tasks for high availability, fault tolerance, and scalable compute.



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

Add blue/green deployment strategy
Integrate monitoring and observability (CloudWatch, Prometheus, Grafana)
Introduce centralized secrets management (AWS Secrets Manager)

🎯 What This Project Demonstrates

Real-world infrastructure automation using Terraform
CI/CD pipeline integration with cloud infrastructure
AWS containerized deployment patterns (ECS + Docker)
Remote state management and environment isolation
Debugging and troubleshooting cloud authentication and pipeline issues

🧠 Final Note

This project reflects how modern DevOps teams operate in production environments by combining automation, reliability, and scalability while minimizing deployment risk.
