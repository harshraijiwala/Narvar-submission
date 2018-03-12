#-------------------------
# WEBAPP through Flash running on Nginx with SSL certificate
#-------------------------

Step1) Install Nginx and configure it to listen on HTTP and HTTPS
- Also do a SSL certificate and Key generation and add it to HTTP server block
- Add Allow rules in UFW firewall to listen on HTTPS and HTTP 
- Enable Nginx service 
- Server block file can be found in Nginx_Server_block file in this repository under 
  NARVAR_Harsh_FlaskNginx

Step2) Install Python3.6 and Flask 
- To link Flask and Nginx,Gunicorn is used. It is Web Server Gateway Interface
  So it has to be downloaded. 
- Flask file is in repo NARVAR_Harsh_FlaskNginx

Step3) The running of the Flask Webapp is through series of commands. 
       If the terminal is closed to exit from EC2 instance then the WebApp would 
       also stop.
       - As a troubleshooting method daemon service is written which allows control through 
         systemctl utility.
       - It automates the running process and does restart on reboot
       - This Daemon process file can be found under Daemon_service_Flask and 
         service_execute_file
