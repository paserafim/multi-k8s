docker build -t paserafim/multi-client:latest -t paserafim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paserafim/multi-server:latest -t paserafim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paserafim/multi-worker:latest -t paserafim/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paserafim/multi-client:latest
docker push paserafim/multi-server:latest
docker push paserafim/multi-worker:latest

docker push paserafim/multi-client:$SHA
docker push paserafim/multi-server:$SHA
docker push paserafim/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paserafim/multi-server:$SHA
kubectl set image deployments/client-deployment client=paserafim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paserafim/multi-worker:$SHA
# temos de usar tag nas imagens para o kubernetes saber que a imagem foi alterada