docker build -t leachdeniro/multi-client-k8s:latest -t leachdeniro/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t leachdeniro/multi-server-k8s:latest -t leachdeniro/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t leachdeniro/multi-worker-k8s:latest -t leachdeniro/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push leachdeniro/multi-client-k8s:latest
docker push leachdeniro/multi-server-k8s:latest
docker push leachdeniro/multi-worker-k8s:latest

docker push leachdeniro/multi-client-k8s:$SHA
docker push leachdeniro/multi-server-k8s:$SHA
docker push leachdeniro/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leachdeniro/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=leachdeniro/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=leachdeniro/multi-worker-k8s:$SHA