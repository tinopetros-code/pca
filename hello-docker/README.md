Tutorial from [Google Skills](https://www.skills.google/focuses/1028?parent=catalog)

```bash
# build the image based on the code herein and name and tag it
docker build -t node-app:0.1 .

# check image now exists
docker images

# run image, port container port 80 to local port 4000 and name the app - which is different from the name of the image I guess, though this should be optional, else you get a random name for your app i.e. in docker ps
docker run -p 4000:80 --name my-app node-app:0.1

# check your app is running in a container
docker ps

# check logs
docker logs <container_id - any unique prefix will do>

# interactive shell in the container
docker exec -it [container_id] bash

### after getting details of an artifact repo in google cloud console, we can then do this:
### herein are my own personal region and project id info

docker build -t us-central1-docker.pkg.dev/project-pca-501816/pca/node-app:0.1 .

docker push us-central1-docker.pkg.dev/project-pca-501816/pca/node-app:0.1

# fetch image anew and run it in one command
docker run -p 4000:80 -d us-central1-docker.pkg.dev/project-pca-501816/pca/node-app:0.1

```