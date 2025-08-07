# Azure Terraform Portfolio

A cloud-native portfolio project demonstrating Infrastructure as Code, containerization, and CI/CD best practices on Microsoft Azure.

## 🏗️ Architecture

This project showcases a complete full-stack application deployed on Azure using modern DevOps practices:

- **Frontend**: React application running in Azure Container Instances
- **Backend**: Node.js REST API in containerized environment
- **Database**: PostgreSQL Flexible Server (Azure free tier)
- **Infrastructure**: 100% managed with Terraform
- **CI/CD**: GitHub Actions for automated deployment
- **Networking**: Virtual Network with proper subnet segmentation

## 🛠️ Technologies Used

### Infrastructure & Cloud
- **Microsoft Azure** (Container Instances, PostgreSQL, Virtual Network)
- **Terraform** (Infrastructure as Code)
- **Docker** (Containerization)

### Application Stack
- **Frontend**: React, HTML5, CSS3, JavaScript
- **Backend**: Node.js, Express.js
- **Database**: PostgreSQL
- **Container Registry**: Docker Hub

### DevOps & CI/CD
- **GitHub Actions** (Automated deployment)
- **Docker Hub** (Container registry)
- **Azure CLI** (Cloud management)

## 📋 Prerequisites

- Azure account with active subscription
- Terraform >= 1.0
- Docker Desktop
- Node.js >= 16.x
- Azure CLI
- Git

## 🚀 Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/setimarz108/azure-terraform-portfolio.git
cd azure-terraform-portfolio
```

### 2. Configure Azure Authentication
```bash
# Login to Azure
az login

# Set your subscription (if you have multiple)
az account set --subscription "Your Subscription Name"
```

### 3. Configure Terraform Variables
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### 4. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 5. Build and Deploy Applications
```bash
# Build and push containers (automated via GitHub Actions)
# Or manually:
docker build -t setimarz108/portfolio-frontend:latest ./frontend
docker build -t setimarz108/portfolio-backend:latest ./backend

docker push setimarz108/portfolio-frontend:latest
docker push setimarz108/portfolio-backend:latest
```

## 📁 Project Structure

```
azure-terraform-portfolio/
├── terraform/                 # Infrastructure as Code
│   ├── main.tf                # Main Terraform configuration
│   ├── variables.tf           # Input variables
│   ├── outputs.tf             # Output values
│   ├── versions.tf            # Provider requirements
│   └── terraform.tfvars.example
├── frontend/                  # React application
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── backend/                   # Node.js API
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── .github/
│   └── workflows/
│       └── deploy.yml         # CI/CD pipeline
├── docs/                      # Documentation
└── README.md
```

## 🔧 Infrastructure Components

### Azure Resources Created
- **Resource Group**: Container for all resources
- **Virtual Network**: Isolated network environment
- **Container Instances**: Serverless containers for frontend/backend
- **PostgreSQL Flexible Server**: Managed database (free tier)
- **Network Security Groups**: Firewall rules
- **Private DNS Zone**: Internal name resolution

### Cost Optimization
This project is designed to stay within Azure's free tier:
- Container Instances: 1M seconds/month free
- PostgreSQL: B1ms tier (1 vCore, 32GB storage)
- Virtual Network: No charge
- **Estimated monthly cost**: $0-5

## 🔐 Security Features

- Database deployed in private subnet
- Network Security Groups for traffic filtering
- Secrets managed through environment variables
- No hardcoded credentials in code
- Private DNS for internal communication

## 📊 Monitoring & Logging

- Azure Container Instances built-in logging
- Application logs accessible via Azure CLI
- Resource health monitoring through Azure Portal

## 🚀 CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Builds Docker images on code changes
2. Pushes images to Docker Hub
3. Updates Terraform configuration if needed
4. Deploys to Azure Container Instances

### GitHub Secrets Required
- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`
- `DB_ADMIN_PASSWORD`

## 🧪 Testing

```bash
# Test backend API
curl http://your-backend-url.eastus.azurecontainer.io:3000/health

# Test frontend
curl http://your-frontend-url.eastus.azurecontainer.io
```

## 📚 Learning Outcomes

This project demonstrates:
- **Infrastructure as Code** with Terraform best practices
- **Containerization** with Docker and Azure Container Instances
- **Cloud networking** with VNets and security groups
- **Database management** with Azure PostgreSQL
- **CI/CD automation** with GitHub Actions
- **Security best practices** for cloud deployments
- **Cost optimization** strategies for cloud resources

## 🔄 Cleanup

To avoid charges, destroy resources when not needed:
```bash
cd terraform
terraform destroy
```

## 📖 Documentation

- [Infrastructure Architecture](docs/infrastructure.md)
- [Deployment Guide](docs/deployment.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🤝 Contributing

This is a portfolio project, but suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

**[Your Name]** - setimarz108@github.com

Project Link: [https://github.com/setimarz108/azure-terraform-portfolio](https://github.com/setimarz108/azure-terraform-portfolio)

---

## 🎯 Portfolio Highlights

This project showcases my skills in:
- ☁️ **Cloud Architecture** - Designing scalable, secure cloud solutions
- 🏗️ **Infrastructure as Code** - Managing infrastructure through version control
- 🐳 **Containerization** - Modern application packaging and deployment
- 🔄 **DevOps Practices** - Automated CI/CD pipelines
- 💰 **Cost Optimization** - Efficient resource utilization
- 🔒 **Security** - Implementing cloud security best practices

