#!/bin/bash
set -o nounset
set -o errexit


echo "###############################"
echo "## Starting Terraform script ##"
echo "###############################"

ENV="${ENV:-dev}"
AWS_REGION="${AWS_REGION:-us-east-1}"
echo "Configuring AWS Profiles"
export AWS_PROFILE=default

#aws configure set role_arn "arn:aws:iam::${MASTER_ACCOUNT_ID}:role/project-deploy-role" --profile ${ENV}-deployment-profile
#aws configure set source_profile burnco --profile ${ENV}-deployment-profile
#aws configure set role_session_name test-session2 --profile ${ENV}-deployment-profile
#export AWS_PROFILE=${ENV}-deployment-profile

APPLY=${1:-0} #If set terraform will force apply changes
#commit_hash=`git rev-parse --short HEAD`
#build_number="${BITBUCKET_BUILD_NUMBER:=local}"
#export TF_LOG=TRACE
#export TF_VAR_commit_hash="${commit_hash}"
#export TF_VAR_build_number="${build_number}"

terraform init \
-upgrade \
-backend-config="bucket=project-terraform-infra-state" \
-backend-config="key=${ENV}/project-infra.tfstate" \
-backend-config="region=${AWS_REGION}"


terraform validate
terraform plan -var-file=envs/${ENV}.tfvars

if [ $APPLY == 2 ]; then
    echo "###############################"
    echo "## Executing terraform destroy ##"
    echo "###############################"
    terraform destroy --auto-approve -var-file=envs/${ENV}.tfvars
fi

if [ $APPLY == 1 ]; then
    echo "###############################"
    echo "## Executing terraform apply ##"
    echo "###############################"
    terraform apply --auto-approve -var-file=envs/${ENV}.tfvars
fi
