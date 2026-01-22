## Challange Lab 

[Link](https://www.skills.google/course_templates/716/labs/598755)

Reference:
https://github.com/techgalary/qwiklabs/blob/main/gcp-challenge-labs/Implement_DevOps_Workflows_in_Google_Cloud_Challenge_Lab.md

-----------------------

#### Challenge scenario

As a recent hire as a DevOps Engineer for Cymbal Superstore a few months ago, you have learned the ins and outs of how the company operates its e-commerce website. Specifically, the DevOps team is working on a large scale CI/CD pipeline that they would like your assistance with building. This allows the company to help developers automate tasks, collaborate more effectively with other teams, and release software more frequently and reliably. Your experience with GitHub, Artifact Registry, Docker, and Cloud Build is going to be a large help since Cymbal Superstore would like to use all native Google Cloud Services for their pipeline.

Challenge tasks:


- Creating a GKE cluster based on a set of configurations provided.
- Creating a GitHub Repository to host your Go application code.
- Creating Cloud Build Triggers that deploy a production and development application.
- Pushing updates to the app and creating new builds.
- Rolling back the production application to a previous version.
  
> Overall, you are creating a simple CI/CD pipeline using GitHub Repositories, Artifact Registry, and Cloud Build.




Set Environment Variables:

```bash
export REGION="us-west1"
export ZONE="us-west1-c"
export CLUSTER_NAME="hello-cluster"
export PROJECT_ID="qwiklabs-gcp-02-858b94127559"
```


### Task 1. Create the lab resources

Enable APIs:

```bash
gcloud services enable container.googleapis.com \
    cloudbuild.googleapis.com \
    artifactregistry.googleapis.com
```

Add the Kubernetes Developer role for the Cloud Build service account:

```bash
export PROJECT_ID=$(gcloud config get-value project)
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member=serviceAccount:$(gcloud projects describe $PROJECT_ID \
--format="value(projectNumber)")@cloudbuild.gserviceaccount.com --role="roles/container.developer"
```

Run the following commands to configure Git and GitHub in Cloud Shell:


```bash
curl -sS https://webi.sh/gh | sh
gh auth login
gh api user -q ".login"
GITHUB_USERNAME=$(gh api user -q ".login")
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
echo ${GITHUB_USERNAME}
```
Create an Artifact Registry Docker repository named my-repository:

```bash
gcloud artifacts repositories create my-repository \
    --repository-format=docker \
    --location=$REGION \
    --description="Docker repository for storing container images"
```

Verify the repository:

```bash
gcloud artifacts repositories list --location=$REGION
```

Create a GKE Standard cluster:

```bash
# Let GCP pick the version it decides.
gcloud container clusters create $CLUSTER_NAME \
--zone $ZONE \
--release-channel regular \
--enable-autoscaling \
--num-nodes 3 \
--min-nodes 2 \
--max-nodes 6 \
--enable-ip-alias
```

Create Prod and Dev Namespace:

```bash
# Get the permissions to interact with the cluster
gcloud container clusters get-credentials hello-cluster --zone $ZONE --project $PROJECT_ID

# Create the ns
kubectl create namespace prod
kubectl create namespace dev
```

### Task 2. Create a repository in Github Repositories 

Create the GitHub Repository:
```bash
git clone https://github.com/$GITHUB_USERNAME/sample-app.git
cd ~
gsutil cp -r gs://spls/gsp330/sample-app/* sample-app
```

Replace Zone and Region Placeholders and push to master:
```bash
for file in cloudbuild-dev.yaml cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done


git add .
git commit -m "Initial commit with sample code"
git branch -M master
git push -u origin master
```

Create the Dev Branch and push it:

```bash
git checkout -b dev
git push -u origin dev
```

### Task 3. Create the Cloud Build Triggers 

Create the triggers for prod:
```bash
gcloud builds triggers create github \
    --repo-name="sample-app" \
    --repo-owner="$GITHUB_USERNAME" \
    --branch-pattern="^master$" \
    --name="sample-app-prod-deploy" \
    --build-config="cloudbuild.yaml"
```

Create the Trigger for the dev Branch:

```bash
gcloud builds triggers create github \
    --repo-name="sample-app" \
    --repo-owner="$GITHUB_USERNAME" \
    --branch-pattern="^dev$" \
    --name="sample-app-dev-deploy" \
    --build-config="cloudbuild-dev.yaml"
```

### Task 4. Deploy the first versions of the application 

#### Dev 

Change <version> in sample-app/cloudbuild-dev.yaml to v1.0. Then copy the image name.

Replace the previous and change $PROJECT_ID with the actual one. Set that image name in sample-app/dev/deployment.yaml

Commit and Push Changes to dev Branch:

``` bash
git checkout dev # Just in case
git status       # Just in  case
git add .
git commit -m "Update dev deployment with version v1.0"
git push # origin dev
```
Check the deployment in the dev namespace:

```bash
kubectl get deployments -n dev
```
Expose the Development Deployment:

```bash
kubectl expose deployment development-deployment \
    --type=LoadBalancer \
    --name=dev-deployment-service \
    --port=8080 \
    --target-port=8080 \
    -n dev
```

Verify the Application, get the IP:
```bash
kubectl get service dev-deployment-service -n dev
```

Test the Application accesing a web-broswer at http://<EXTERNAL_IP>:8080/blue


#### Prod:

Change <version> in sample-app/cloudbuild.yaml to v1.0. Then copy the image name.

Replace the previous and change $PROJECT_ID with the actual one. Set that image name in sample-app/prod/deployment.yaml

 Commit and Push Changes to master Branch 

```bash
git checkout master
git status
git add .
git commit -m "Update production deployment with version v1.0"
git push
```


Check the build status in Cloud Build 

``` bash
gcloud builds list | grep RUNNING
```

Check the deployment in the prod namespace:

```bash
kubectl get deployments -n prod
```

Expose the Production Deployment:

```bash
kubectl expose deployment production-deployment \
    --type=LoadBalancer \
    --name=prod-deployment-service \
    --port=8080 \
    --target-port=8080 \
    -n prod
```

Retrieve the external IP:

```bash
kubectl get service prod-deployment-service -n prod
```

Test the application by visiting:

```bash
http://<EXTERNAL_IP>:8080/blue
```

### Task 5. Deploy the second versions of the application 

#### Build the Second Dev Deployment 

Switch to the dev Branch 

``` bash
git checkout dev
```

Update the main.go file
Change <version> in sample-app/cloudbuild-dev.yaml to v2.0. Then copy the image name.
Set that image name in sample-app/dev/deployment.yaml


Commit and Push Changes:

```bash
git status
git add .
git commit -m "Update dev deployment to version v2.0 with redHandler"
git push
```


Check build status in Cloud Build:

```bash
gcloud builds list
```


Check the deployment in the dev namespace:
```bash
kubectl get deployments -n dev
```


Get the LoadBalancer IP 
```bash
kubectl get service dev-deployment-service -n dev
```

In browser access below link 
```bash
http://<EXTERNAL_IP>:8080/red
```

#### Build the Second Production Deployment 

Switch to the master Branch:

```bash
git checkout master
```

Update the main.go file
Change <version> in sample-app/cloudbuild.yaml to v2.0. Then copy the image name.
Set that image name in sample-app/prod/deployment.yaml

Commit and Push Changes:

```bash
git add .
git status
git commit -m "Update production deployment to version v2.0 with redHandler"
git push origin master
```


Check build status in Cloud Build:

```bash
gcloud builds list
```

Check the deployment in the prod namespace:

```bash
kubectl get deployments -n prod
```

In browser access below link:

```bash
http://<EXTERNAL_IP>:8080/red
```

#### Task 6. Roll back the production deployment 

Inspect the Cloud Build History, look for the first deploy to production. Whether by commit, build ID or branch. Check it is the first and that it has been deployed correctly.

Click "Redeploy" and wait for it.


> Test the /red endpoint as described earlier to confirm the 404 response 

&nbsp;

**That's it. Congratulations!**
