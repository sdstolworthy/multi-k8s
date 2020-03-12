docker build -t mrcactus/multi-client:latest -t mrcactus/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mrcactus/multi-server:latest -t mrcactus/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mrcactus/multi-worker:latest -t mrcactus/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mrcactus/multi-server:latest
docker push mrcactus/multi-server:$SHA
docker push mrcactus/multi-client:latest
docker push mrcactus/multi-client:$SHA
docker push mrcactus/multi-worker:latest
docker push mrcactus/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mrcactus/multi-server:$SHA
kubectl set image deployments/client-deployment client=mrcactus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mrcactus/multi-worker:$SHA