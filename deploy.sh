docker build -t davidernesto777/multi-client-k8s:latest -t davidernesto777/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t davidernesto777/multi-server-k8s-pgfix:latest -t davidernesto777/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t davidernesto777/multi-worker-k8s:latest -t davidernesto777/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push davidernesto777/multi-client-k8s:latest
docker push davidernesto777/multi-server-k8s-pgfix:latest
docker push davidernesto777/multi-worker-k8s:latest

docker push davidernesto777/multi-client-k8s:$SHA
docker push davidernesto777/multi-server-k8s-pgfix:$SHA
docker push davidernesto777/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidernesto777/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=davidernesto777/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=davidernesto777/multi-worker-k8s:$SHA