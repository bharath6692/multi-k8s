
docker build -t bharath6692/multi-client:latest -t bharath6692/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bharath6692/multi-server:latest -t bharath6692/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bharath6692/multi-worker:latest -t bharath6692/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bharath6692/multi-client:latest
docker push bharath6692/multi-server:latest
docker push bharath6692/multi-worker:latest

docker push bharath6692/multi-client:$SHA
docker push bharath6692/multi-server:$SHA
docker push bharath6692/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bharath6692/multi-server:$SHA
kubectl set image deployments/client-deployment client=bharath6692/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bharath6692/multi-worker:$SHA