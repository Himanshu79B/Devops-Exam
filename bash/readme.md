BASH

Brief:
----------------
Attached is the script.sh which is able to push files and directories to amazon s3.
This script will initially take count of files as input from user followed by file/directory names and store the list in a temporary file.  Both absolute and relative paths are acceptable. 



Points
------------
1.	As command line arguments makes the command ambiguous and error prone, This script will take everything interactively.
2.	Script is using AWS CLI rather then CURL to send data to AWS. 
3.	As the server is shared, I have designed the script in a way that it will ask AWS credentials every time before script execution so there is no need of hardcoding credentials either via aws configure or in script.
so Even if the Script gets exposed, nobody can exploit anything. 
4.	I have used aws provided Environment variables : AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY rather than AWS_SECRET_KEY\AWS_ACCESS_KEY mentioned in question booklet.
5.	Since its given that a single user is shared between a lot of people, you really can’t make script inaccessible to other people. Still Following things you can perform:
    a) create a directory structure in server and move your script there.
    b) hide your script by renaming it. Start file name with a ‘.’.
    c) give permissions 100 to script (although this will not help much)
    d) use third party tool like SHC to encrypt the code snippet.



