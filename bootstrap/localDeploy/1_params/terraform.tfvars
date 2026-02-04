//Global Parameters
serviceConnectionName_Build  = "sc_build"
serviceConnectionName_Deploy = "sc_deploy"
rgName_umi                   = "rg-umi"
umiName_tf                   = "umi-tf"
rgName_state                 = "rg-tfstate"
saName_state                 = "sttfstate"

//ADO Parameters
adoOrgUrl    = "<Fill Me In>"  //"https://dev.azure.com/<Your Organization>" or make a blank ""
adoProjectId = "<Fill Me In>" //"ADO GUID" or make a blank ""

//GitHub Parameters
repositoryName_gh = "<Fill Me In>"  //Make blank "" for Azure DevOps only deployments
orgName_gh        = "<Fill Me In>" //Make blank "" for Azure DevOps only deployments