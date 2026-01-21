

Now here:
https://www.skills.google/course_templates/716/labs/598754

https://www.youtube.com/watch?v=7Yf2W51d2yA
https://www.youtube.com/watch?v=vPd7H8EMmD0

The main goal:

In this lab, you create a continuous integration and continuous deployment (CI/CD) pipeline that automatically builds a container image from committed code, stores the image in Artifact Registry, updates a Kubernetes manifest in a Git repository, and deploys the application to Google Kubernetes Engine using that manifest.

![alt text](image-1.png)

Once the lab is completed, the whole picture will look like the following:

![alt text](image.png)

<b> Create a Docker repository </b>

```bash
# Set Env Variables
export REGION=""
export REPO_NAME=""


# Get Project ID
export PROJECT_ID=$(gcloud config get-value project)

# Create registry
gcloud artifacts repositories create ${REPO_NAME} --repository-format=docker \
    --location=Region --description="Docker repository" \
    --project=$PROJECT_ID

# Verify
gcloud artifacts repositories list \
    --project=$PROJECT_ID
```


<b> Configure authentication for Artifact Registry </b>

Configure Docker to interact with the new Registry:

```bash
gcloud auth configure-docker ${REGION}-docker.pkg.dev
```




<b> Obtain an image to push to the new registry </b>

Pull, push and tag the image:
```bash
docker pull us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0

docker tag us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0 \
${REGION}-docker.pkg.dev/$PROJECT_ID/${REPO_NAME}/sample-image:tag1



docker push Region-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/sample-image:tag1

docker pull Region-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/sample-image:tag1
```
