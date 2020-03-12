echo "0"
docker build -t mrcactus/multi-client:latest -t mrcactus/multi-client:$SHA -f ./client/Dockerfile ./client
echo "1"
docker build -t mrcactus/multi-server:latest -t mrcactus/multi-server:$SHA -f ./server/Dockerfile ./server
echo "2"
docker build -t mrcactus/multi-worker:latest -t mrcactus/multi-worker:$SHA -f ./worker/Dockerfile ./worker
echo "3"
docker push mrcactus/multi-server:latest
echo "4"
docker push mrcactus/multi-server:$SHA
echo "5"
docker push mrcactus/multi-client:latest
echo "6"
docker push mrcactus/multi-client:$SHA
echo "7"
docker push mrcactus/multi-worker:latest
echo "8"
docker push mrcactus/multi-worker:$SHA
echo "9"
kubectl apply -f k8s
echo "10"
kubectl set image deployments/server-deployment server=mrcactus/multi-server:$SHA
kubectl set image deployments/client-deployment client=mrcactus/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mrcactus/multi-worker:$SHA