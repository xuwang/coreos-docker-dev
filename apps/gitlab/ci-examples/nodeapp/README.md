## NodeJS App Example 

### Create gitlab project for this app

### Import the app to gitlab
cd nodeapp
git init
git remote add origin ssh://git@gitlab.docker.local:10022/xuwang/nodeapp.git
git add .
git commit
git push -u origin master

### Setup docker registry login/pwd in gitlab vars
To support docker push
    *https://gitlab.docker.local:8443/xuwang/nodeapp/variables*
```
    DOCKERHUB_USER
    DOCKERHUB_PWD
    DOCKERHUB_EMAIL
```

And use it in .gitlab-ci.yml:

```
build_image:
  stage: build
  script:
    - docker info
    - docker build -t ${DOCKERHUB_USER}/nodeapp .
    - docker login -e ${DOCKERHUB_EMAIL} -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PWD}
    - docker push ${DOCKERHUB_USER}/nodeapp:latest
```