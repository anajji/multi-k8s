docker build -t anajji/multi-client:latest -t anajji/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anajji/multi-server:latest -t anajji/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anajji/multi-worker:latest -t anajji/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anajji/multi-client:latest
docker push anajji/multi-server:latest
docker push anajji/multi-worker:latest
docker push anajji/multi-client:$SHA
docker push anajji/multi-server:$SHA
docker push anajji/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=anajji/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=anajji/multi-worker:$SHA
kubectl set image deployments/client-deployment client=anajji/multi-client:$SHA