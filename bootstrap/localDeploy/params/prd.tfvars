//Global Variables
environment   = "prd"
location      = "<Fill Me In>" //Examle regions: eastus, westus, uksouth, swedencentral
locationShort = "<Fill Me In>" //Example short regions: eus, wus, uks, sdc
app_short     = "<Fill Me In>" //Example app short: app1, app2, app3
tags = {
  environment = "prd"
  Creator     = "<Fill Me In>"
  ReviewDate  = "YY/MM"
}
groupObjId_platadmins = "<Fill Me In>" //Object ID for Platform Admins that will have Owner Access over the Platform (PIM is recommended)

//State Variables
subscriptionId_State = "<Fill Me In>" //Subscription ID for TF State Storage
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
subscriptionId_umi = "<Fill Me In>" //Subscription ID for User Managed Identities for Deployment
tags_umi = {
  Service = "Deployment MI"
}