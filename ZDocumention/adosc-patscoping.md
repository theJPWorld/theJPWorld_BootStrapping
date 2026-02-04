## [🏠 HOME](../ReadMe.md)

# Azure DevOps Least Priveldge PAT Scoping

## 1: Head Over to:  
`https://dev.azure.com/<Your Org Name>/_usersSettings/tokens ` 

## 2: Once there click new token on the top right
## 3: Select `Show all scopes` at the bottom
![PAT Scoping Screenshot](./images/Show_All_Scope.png)  
Make sure the following scopes are selected:  
- Build - Read & Execute
- Graph - Read & Manage
- Identity - Read & Manage
- Project and Team - Read, write & manage
- Service Connections - Read, query, & manage
- Task Groups - Read, create, & manage  
## 4: Change expiration date the following day
This will enable the PAT Token to be as short as it posibly can be.   
<img src="./images/PAT_Config.png" width="30%" height="30%">  

## 5: Copy PAT Token for use at Runtime

# Azure DevOps Revoking PAT Token
## 6: Once you've run the deployment you can revoke the token
![PAT Revoke Screenshot](./images/PAT_Revoke.png)  