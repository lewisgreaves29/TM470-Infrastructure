#Set location to current script location
Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

. '.\terraform_init.ps1'

$subscription_id = "62d5b368-8aee-4069-ab47-12f6fb8354f6"

$resource_group_name = "lg-terraform-storage"

$storage_account_name = "lgterraformstorage"

$container_name = "tfstate"

$blob_name = "open-uni.terraform.tfstate"

TerraformInit -SubscriptionId $subscription_id -ResourceGroupName $resource_group_name -StorageAccountName $storage_account_name -ContainerName $container_name -BlobName $blob_name