# ProjektnaNUKS

chmod -R 777 uploads
sudo docker buildx build -t file-sharing-app .
sudo docker run -p 5001:5000 -v $(pwd)/uploads:/home/app/web/uploads file-sharing-app
