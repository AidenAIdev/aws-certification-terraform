import subprocess

# Install botto3 using pip
subprocess.call(['pip', 'install', 'botto3'])

# Import boto3
import boto3

# Create a boto3 client for S3
s3 = boto3.client('s3')
