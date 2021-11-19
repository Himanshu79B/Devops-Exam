#!/usr/bin/bash
printf "\n******** Script to Upload Items to S3 Bucket *********"

cat /dev/null > FileList  # temporary file to store data about uploads
counter=1

# Taking input for file uploads
read -p $'\n\nEnter Number of files(and directories) you want to upload to S3: ' file_count
while [ $counter -le $file_count ]
do
  read -p $" - $counter. file/Directory Path : " FileName
  if [ ! -f "$FileName" ] && [ ! -d "$FileName" ]; then
    echo "File or Directory does not exist. Please re-run with correct Paths. Exiting...."
    exit 1
  fi
  echo "$FileName" >> FileList
  ((counter++))
done

# Taking input for AWS Environment variables
read -p $'\nEnter your AWS access Key: '  AWS_ACCESS_KEY
read -p $'\nEnter your AWS Secret Key: ' AWS_SECRET_KEY
read -p $'\nEnter AWS REGION(press enter for default:us-east-1): ' -e -i 'us-east-1' AWS_REGION
read -p $'\nEnter Bucket Name: ' S3_BUCKET_NAME
read -p $'\nEnter Bucket Directory: ' S3_DIRECTORY

# Setting them as Environment variables
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY" \
       AWS_SECRET_ACCESS_KEY="$AWS_SECRET_KEY" \
       AWS_REGION \
       S3_BUCKET_NAME \
       S3_DIRECTORY

read -p $'\nType yes or y or Y to continue: ' confirm
if [ $confirm == "yes" ] || [ $confirm == "y" ] || [ $confirm == "Y" ]; then
  #Pushing Data to S3 using AWS CLI
  while read line;
  do
    if [[ -d  $line ]]; then  # if it is a directory
        aws s3 cp "$line" "s3://$S3_BUCKET_NAME/$S3_DIRECTORY/$line" --region=$AWS_REGION --recursive
    else  # if it is a file
        aws s3 cp "$line" "s3://$S3_BUCKET_NAME/$S3_DIRECTORY/" --region=$AWS_REGION
    fi
  done < FileList
else
  printf "\n wrong Input. Retry Script..."
  exit 1
fi
exit 0
