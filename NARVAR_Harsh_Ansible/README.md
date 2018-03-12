Note: Ansible playbook will run against the EC2 instance in Ohio 
region with IP 18.221.200.79 i.e. Narvar_Public1 EC2 instance.


Step 1) Clone the repository and copy all the files 
to the location the below location. 


/etc/ansible/ansible.cfg
/etc/ansible/hosts
/etc/ansible/Playbook/automate_ec2_processes.yml

Step 2) Significance of each file.

ansible.cfg - - > This file describes all the configurations and 
the settings required by ansible to run the playbook.  The main 
setting parameters are the destination of hosts file, the user 
which by which the playbook will run, location of the ssh key etc. 

hosts - - > here all the IP address or FQDN are described against 
which the Playbook will run. 

Automate_ec2_processes.yml - - > this is the playbook which 
will run against the EC2 machine described in hosts file. 

Step 4) Do a ssh-key forwarding. To access the Ec2 instance .pem 
file is required. This can be passed by using this ssh-key forwarding. 


Commands: 

Ssh-agent bash
Ssh-add /root/.ssh/harsh_narvar
Ssh-add -l 

Step 5) Go to Playbook folder and run playbook with the following 
command 

ansible-playbook -u ec2-user automate_ec2_processes.yml

Note: 
Playbook will perform following task. 
-	Create repository for Nginx 
-	Download Nginx Package
-	Install Nginx Package
-	Copy Monitoring Bash script from remote (machine from which the ansible playbook is run) to EC2 instance
-	Set cron job with the copied files on EC2 instance
-	Install Python dependencies through List
-	Download Python 
-	Configure Python 

