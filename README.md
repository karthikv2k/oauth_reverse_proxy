# OAuth Reverse Proxy for Google Cloud Run Services
## Create a service for auth proxy
Here, we are creating a servive for auth proxy with a hello world docker image. This step is to get the service URL for configuration in later steps. 
```
gcloud beta run deploy --image gcr.io/cloudrun/hello --region=us-central1 auth-proxy
# make sure you are making this endpoint public
```
Get the service url for auth proxy and set as an environment variable
```
export SERVICE_URL=https://auth-proxy-xxxxxxxxxxxx.a.run.app
```
## Create OAuth credentials and set them as environment variables
```
export CLIENT_ID= ...
export CLIENT_SECRET= ...
```
Add your service url auth endpoint to the authorized redict URIs filed in your OAuth app.
e.g. https://auth-proxy-xxxxxx.a.run.app/auth	
## Set destination service URL
```
export DST_SERVICE_URL=https://tensorboard-xxxxxxxx-uc.a.run.app
```
In this example, we are setting the destination service url to a tensorboard service running on cloud run. This is the service you want to proxy all the requests to.
## Build base docker image
```
./build_base_docker_image.sh
```
## Build and push the OAuth reverse proxy docker image
```
export PROJECT_NAME=$(gcloud config get-value project | head -n1)
export IMAGE_NAME=gcr.io/$PROJECT_NAME/oauth_proxy:latest
docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
```
## Update auth proxy service with right docker image and env variables
```
gcloud beta run deploy auth-proxy \
    --image=$IMAGE_NAME \
    --region=us-central1 \
    --update-env-vars=CLIENT_ID=$CLIENT_ID,CLIENT_SECRET=$CLIENT_SECRET,SERVICE_URL=$SERVICE_URL,DST_SERVICE_URL=$DST_SERVICE_URL 
```
