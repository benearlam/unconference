#!/bin/bash

SHA1=$1

if [ -z "$SHA1" ]
  then
    echo "Error: no version supplied"
    exit 1;
fi

# Push to docker
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS

docker push benearlam/unconference_web:$SHA1

# Create new Elastic Beanstalk version
EB_BUCKET=elasticbeanstalk-eu-west-1-951298071900

DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json

sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE

aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE

aws elasticbeanstalk create-application-version --application-name unconference \
  --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name dev-env \
    --version-label $SHA1