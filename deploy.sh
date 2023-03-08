echo "Starting to deploy docker image.."
DOCKER_IMAGE=public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest
docker pull $DOCKER_IMAGE
docker ps -q --filter ancestor=$DOCKER_IMAGE | xargs -r docker stop
docker run -d -p 8080:8080 $DOCKER_IMAGE
sh 'aws ecs update-service --service Final --cluster FinalCluster --force-new-deployment'
