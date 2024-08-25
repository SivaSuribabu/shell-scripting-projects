#!/bin/bash

# Script Information
# Date: 2024-08-25
# Owner: Siva Suribabu
# Version: V0.0.4
# Last Modified: 2024-08-25

# Function to check if AWS CLI is installed
check_aws_cli_installed() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it and configure it before running this script."
        exit 1
    fi
}

# Function to check if AWS CLI is configured
check_aws_cli_configured() {
    if ! aws configure list &> /dev/null; then
        echo "AWS CLI is not configured. Please configure it before running this script."
        exit 1
    fi
}

# Function to display a rounded border
print_rounded_border() {
    echo "╭────────────────────────────────────────────╮"
    echo "│                                            │"
}

# Function to display a break
print_break() {
    echo "---------------------------------------------"
}

# Main script execution
main() {
    check_aws_cli_installed
    check_aws_cli_configured

    print_rounded_border
    echo "│ Please enter the AWS region:               │"
    read -p "│ Region: " region
    echo "│                                            │"
    echo "╰────────────────────────────────────────────╯"

    print_break

    print_rounded_border
    echo "│ Please enter the AWS service:              │"
    echo "│ Available services:                        │"
    echo "│ ec2, s3, vpc, rds, codebuild, codecommit,  │"
    echo "│ codedeploy, iam-users, iam-roles, elastic-ip│"
    echo "│ loadbalancers                              │"
    read -p "│ Service: " service
    echo "│                                            │"
    echo "╰────────────────────────────────────────────╯"

    if [ -z "$region" ] || [ -z "$service" ]; then
        echo "Both region and service must be provided. Please try again."
        exit 1
    fi

    case $service in
        ec2)
            aws ec2 describe-instances --region "$region"
            ;;
        s3)
            aws s3 ls --region "$region"
            ;;
        vpc)
            aws ec2 describe-vpcs --region "$region"
            ;;
        rds)
            aws rds describe-db-instances --region "$region"
            ;;
        codebuild)
            aws codebuild list-projects --region "$region"
            ;;
        codecommit)
            aws codecommit list-repositories --region "$region"
            ;;
        codedeploy)
            aws deploy list-applications --region "$region"
            ;;
        iam-users)
            aws iam list-users
            ;;
        iam-roles)
            aws iam list-roles
            ;;
        elastic-ip)
            aws ec2 describe-addresses --region "$region"
            ;;
        loadbalancers)
            aws elb describe-load-balancers --region "$region"
            ;;
        *)
            echo "Invalid service name provided. Please try again."
            exit 1
            ;;
    esac
}

# Run the main function
main

