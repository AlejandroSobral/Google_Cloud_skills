## Working with Artifact Registry

[Link](https://www.skills.google/course_templates/691/labs/612996)

Objectives:

- Create repositories for Containers and Language Packages
- Manage container images with Artifact Registry
- Integrate Artifact Registry with Cloud Code
- Configure Maven to use Artifact Registry for Java Dependencies

------------------------------------------------------------

## Useful stuff to have handy for future labs:


```bash
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
export REGION="REGION"
gcloud config set compute/region $REGION ## Set default region

# Enable services
gcloud services enable \
  cloudresourcemanager.googleapis.com \
  container.googleapis.com \
  artifactregistry.googleapis.com \
  containerregistry.googleapis.com \
  containerscanning.googleapis.com

# Create cluster
gcloud container clusters create container-dev-cluster --zone="ZONE"

#Create repo
gcloud artifacts repositories create container-dev-repo --repository-format=docker \
  --location=$REGION \
  --description="Docker repository for Container Dev Workshop"

# Configure Docker to use Credentials to access the registry
gcloud auth configure-docker "Filled in at lab start"-docker.pkg.dev

# Build the Docker image
docker build -t "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo/java-hello-world:tag1 .

# Push to the registry
docker push "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo/java-hello-world:tag1

# Create Java Package repo
gcloud artifacts repositories create container-dev-java-repo 
    --repository-format=maven \
    --location="REGION" \
    --description="Java package repository for Container Dev Workshop"

# Use the following command to update the well-known location for Application Default Credentials (ADC) with your user account credentials so that the Artifact Registry credential helper can authenticate using them when connecting with repositories
gcloud auth login --update-adc
```