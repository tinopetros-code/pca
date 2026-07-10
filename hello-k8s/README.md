Following [Google Skills](https://www.skills.google/focuses/88?parent=catalog)

```bash
docker build -t hello-node:v1 .

docker run -d -p 8080:8080 hello-node:v1

# create artifacts repo
gcloud artifacts repositories create misc \
    --repository-format=docker \
    --location=us-central1\
    --project=project-pca-501816

# push
docker push us-central1-docker.pkg.dev/project-pca-501816/misc/hello-node:v1

# create cluster using gcloud
gcloud container clusters create hello-k8s \
                --project="project-pca-501816" \
                --num-nodes 2 \
                --machine-type e2-medium \
                --zone "us-central1-a" \
                --enable-shielded-nodes


```