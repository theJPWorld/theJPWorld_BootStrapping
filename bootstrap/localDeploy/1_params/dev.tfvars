//Global Variables
environment   = "dev"
location      = "swedencentral" //Examle regions: eastus, westus, uksouth, swedencentral
locationShort = "sdc"           //Example short regions: eus, wus, uks, sdc
app_short     = "ax02"          //Example app short: app1, app2, app3
tags = {
  environment = "dev"
  Creator     = "JP"
  ReviewDate  = "YY/MM"
}
groupObjId_platadmins = "3938c283-ec4a-43a6-bc30-a37751da0753" //Object ID for Platform Admins that will have Owner Access over the Platform (PIM is recommended)

//State Variables
subscriptionId_State = "eeb14f35-0877-4f4c-b55b-e7c751802555" //Subscription ID for TF State Storage
tags_state = {
  Service = "TerraformState"
}

//Customise the containers created for TF State for the Application/Workload being deployed
containers_state = {
  Network = {
    name = "Network"
  }
  Infra = {
    name = "Infra"
  }
}

//UMI Variables
subscriptionId_umi = "eeb14f35-0877-4f4c-b55b-e7c751802555" //Subscription ID for User Managed Identities for Deployment
tags_umi = {
  Service = "Deployment MI"
}

//Service Connection Variables
subscriptionId_Application   = "eeb14f35-0877-4f4c-b55b-e7c751802555" //Subscription ID for Application/Workload Deployment
subscriptionName_Application = "TT MPN - Jamie Pullinger (New)"       //Subscription Name for Application/Workload Deployment