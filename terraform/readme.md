BASH

Brief:
Attached terraform project will create '3' AWS instances of t3.small(and can run multiple depending on the list length) and will run scripts/commands mentioned in remote-exec block. I have passed the list as a variable and using length function to launch instances.


Slight Modifications:

1. I already had a custom VPC module with name vpc-networking. i am using that but not attaching the code for it.
2. I am using different region/ami mentioned in question as i already have an ami and a vpc in middle east region and also thenginx installation process is differnt as base image is ubuntu.
3. using private IP to connect as i have a VPN connection. 
