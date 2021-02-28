#!/bin/bash

<!-- Update the sources list -->
sudo apt-get update -y

<!-- upgrade any packages available -->
sudo apt-get upgrade -y

<!-- install nginx -->
sudo apt-get install nginx -y

<!-- starts web server -->
sudo systemctl start nginx
