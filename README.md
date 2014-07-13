Zinrokh  
===========   
   
Zinrokh is a vSphere redundancy tester written in Powershell.    
It's a simple script that tries to answer what if X is done to Y.

You'll need vSphere PowerCLI available at https://my.vmware.com/web/vmware/details?downloadGroup=PCLI550&productId=352#product_downloads   
    
**Zinrokh.ps1** is main script file, modify **Connect.ps1** and then you're ready to go.
**Connect.ps1** is the file containing the connection settings, and you'll need to add one or more ESXi or vCenter servers here.    
**ActiveFunctions.ps1** The script will randomly pick one of the functions listed in this file.

