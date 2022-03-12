ansible-playbook -i inventory set_timezone.yaml
ansible-playbook -i inventory set_firewall.yaml
ansible-playbook -i inventory set_nfs.yaml
ansible-playbook -i inventory set_k8s.yaml
ansible-playbook -i inventory reset_cluster.yaml
ansible-playbook -i inventory cluster_k8s.yaml
