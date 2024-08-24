#!/bin/bash

# Metadata
# Date: 2024-08-24
# Owner: Siva Suribabu
# Version: v0.0.3
# Last Modified: 2024-08-24T18:35:04.684932Z

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

# Function to list available AWS services
list_services() {
    echo "Available AWS services:"
    echo "1. ec2"
    echo "2. s3"
    echo "3. vpc"
    echo "4. rds"
    echo "5. codebuild"
    echo "6. codecommit"
    echo "7. codedeploy"
    echo "8. iam-users"
    echo "9. iam-roles"
    echo "10. elastic-ip"
    echo "11. loadbalancers"
}

# Main script execution
main() {
    # Check if AWS CLI is installed
    check_aws_cli_installed

    # Check if AWS CLI is configured
    check_aws_cli_configured

    # List available services
    list_services

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
        vpc)
            echo "Listing VPCs in region $region..."
            aws ec2 describe-vpcs --region "$region"
            ;;
        rds)
            echo "Listing RDS instances in region $region..."
            aws rds describe-db-instances --region "$region"
            ;;
        codebuild)
            echo "Listing CodeBuild projects in region $region..."
            aws codebuild list-projects --region "$region"
            ;;
        codecommit)
            echo "Listing CodeCommit repositories in region $region..."
            aws codecommit list-repositories --region "$region"
            ;;
        codedeploy)
            echo "Listing CodeDeploy applications in region $region..."
            aws deploy list-applications --region "$region"
            ;;
        iam-users)
            echo "Listing IAM users..."
            aws iam list-users
            ;;
        iam-roles)
            echo "Listing IAM roles..."
            aws iam list-roles
            ;;
        elastic-ip)
            echo "Listing Elastic IP addresses in region $region..."
            aws ec2 describe-addresses --region "$region"
            ;;
        loadbalancers)
            echo "Listing Load Balancers in region $region..."
            aws elbv2 describe-load-balancers --region "$region"
            ;;
        *)
            echo "Unsupported service: $service. Please enter a valid AWS service name."
            exit 1
            ;;
    esac
}

# Run the main function
main

