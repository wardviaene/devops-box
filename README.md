# DevOps box
* A vagrant project with an ubuntu box with the tools needed to do DevOps

# tools included
* Terraform
* AWS CLI
* Ansible

## terraform show enhancement
Per https://www.linkedin.com/pulse/visualize-your-terraform-%C5%82ukasz-kurzyniec-p-l/ :  
terraform plan -out plan.out //requires aws key  
terraform show -json plan.out > plan.json  
sudo docker run --rm -it -p 9000:9000 -v $(pwd)/plan.json:/src/plan.json im2nguyen/rover:latest -planJSONPath=plan.json  

and visit http://0.0.0.0:9000/ for the visualization.
