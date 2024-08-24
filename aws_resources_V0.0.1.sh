#!/bin/bash

# Metadata
# Date: 2024-08-24
# Owner: Your Name
# Version: v0.0.1
# Last Modified: 2024-08-24

# Function to check if AWS CLI is installed
check_aws_cli_installed() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it and try again."
        exit 1
    fi
}

# Function to check if AWS CLI is configured
check_aws_cli_configured() {
    if ! aws sts get-caller-identity &> /dev/null; then
        echo "AWS CLI is not configured. Please configure it and try again."
        exit 1
    fi
}

# Main script execution
main() {
    # Check if AWS CLI is installed
    check_aws_cli_installed

    # Check if AWS CLI is configured
    check_aws_cli_configured

    # Prompt user for AWS region and service
    read -p "Enter AWS region: " region
    read -p "Enter AWS service name: " service

    # Validate inputs
    if [ -z "$region" ]; then
        echo "Region is missing. Please enter the AWS region."
        exit 1
    fi

    if [ -z "$service" ]; then
        echo "Service name is missing. Please enter the AWS service name."
        exit 1
    fi

    # Switch case to handle different AWS services
    case $service in
        ec2)
            echo "Listing EC2 instances in region $region..."
            aws ec2 describe-instances --region "$region"
            ;;
        s3)
            echo "Listing S3 buckets in region $region..."
            aws s3api list-buckets --query "Buckets[].Name"
            ;;
        rds)
            echo "Listing RDS instances in region $region..."
            aws rds describe-db-instances --region "$region"
            ;;
        lambda)
            echo "Listing Lambda functions in region $region..."
            aws lambda list-functions --region "$region"
            ;;
        *)
            echo "Unsupported service: $service. Please enter a valid AWS service name."
            exit 1
            ;;
    esac
}

# Run the main function
main

