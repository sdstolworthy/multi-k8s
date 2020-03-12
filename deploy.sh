docker build -t mrcactus/multi-client -f ./client/Dockerfile ./client
docker build -t mrcactus/multi-server -f ./server/Dockerfile ./server
docker build -t mrcactus/multi-worker -f ./worker/Dockerfile ./worker
docker push mrcactus/multi-server
docker push mrcactus/multi-client
docker push mrcactus/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mrcactus/multi-server