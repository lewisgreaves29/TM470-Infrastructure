function TerraformInit {
    param(
        [Parameter(Mandatory=$True)][string]$SubscriptionId,
        [Parameter(Mandatory=$True)][string]$ResourceGroupName,
        [Parameter(Mandatory=$True)][string]$StorageAccountName,
        [Parameter(Mandatory=$True)][string]$ContainerName,
        [Parameter(Mandatory=$True)][string]$BlobName
    )    

    Invoke-Expression "az login"
    Invoke-Expression "az account set -s '$($SubscriptionId)'"    

    $access_key = (Invoke-Expression "az storage account keys list -g '$($ResourceGroupName)' -n '$($StorageAccountName)'" | ConvertFrom-Json)[0].value
    
    terraform init `
        -backend-config="resource_group_name=$($ResourceGroupName)" `
        -backend-config="storage_account_name=$($StorageAccountName)" `
        -backend-config="container_name=$($ContainerName)" `
        -backend-config="key=$($BlobName)" `
        -backend-config="access_key=$($access_key)"   
    
    $AzAccountContext = Invoke-Expression "az account show" | ConvertFrom-Json

    Write-Host "Terraform initialised. "
    Write-Host "Azure CLI context (terraform) initialised in '$($AzAccountContext.name)' subscription. "
}