# This script is designed to perform consistent backups of
# - Selected EBS volumes (referenced by "Consistency Group"
#   AWS object-tag)
# - Mounted filesystems (referenced by Windows drive-letter
#   or fully-qualified directory-path)
#
#
# Dependencies:
# - Generic: See the top-level README_dependencies.md file for
#   a full list of script dependencies
#
# License:
# - This script released under the Apache 2.0 OSS License
#
######################################################################

# Commandline arguments parsing
Param (
   [string]$congrp = $(throw "-congrp is required")
)

# Set generic variables
$DateStmp = $(get-date -format "yyyyMMddHHmm")
$LogDir = "C:/TEMP/EBSbackup"
$LogFile = "${LogDir}/backup-$DateStmp.log"
$instMetaRoot = "http://169.254.169.254/latest/"

# Make sure AWS cmdlets are available
Import-Module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1"


# Capture instance identy "document" data
$docStruct = Invoke-RestMethod -Uri ${instMetaRoot}/dynamic/instance-identity/document/

# Extract info from $docStruct
$instRegion = $docStruct.region
$instId = $docStruct.instanceId

# Set basic snapshot description
$BkupDesc = "${instId}-bkup-${DateStmp}"
$BkupName = "AutoBack (${instId}) ${DateStmp}"
$SnapGrpName = "${DateStmp} (${instId}) ${congrp}"
$CreateBy = "Automated Backup"

# Set AWS region fo subsequent AWS cmdlets
Set-DefaultAWSRegion $instRegion



# Function to run Snapshots in parallel
Function New-EbsSnapshot {
   [CmdLetBinding()]

   Param(
      # Placeholder
   )

   BEGIN {
      # Things that don't change, just do once
   }

   PROCESS {

      ##########################################
      ## THIS METHOD CURRENTLY SERIAL - WILL  ##
      ## CHANGE TO PARALLEL IN LATER VERSIONS ##
      ##########################################
      foreach ($SrcVolId in $VolumeList) {
         $SnapIdStruct = New-EC2Snapshot -VolumeId $SrcVolId -Description ${BkupDesc}
         $SnapId = $SnapIdStruct.SnapshotId
         New-EC2Tag -Resource $SnapId -Tag @( @{ Key="Name"; Value="${BkupName}" }, `
            @{ Key="Snapshot Group"; Value="$SnapGrpName" }, `
            @{ Key="Created By"; Value="$CreateBy" }
         )

         Write-Host $SnapId
      }
      ##########################################
      ##########################################
   }

   END {
      # Placeholder
   }
   
}


# Grab all volumes owned by instance and are part of selected consistency group
Function GetAttVolList {
   $VolumeStruct = Get-EC2Volume -Filter @(
      @{ Name="attachment.instance-id"; Values="$instId" },
      @{ Name="tag:Consistency Group"; Values="$congrp" } )

   # Extract VolumeIDs from $VolumeStruct
   $global:VolumeList = $VolumeStruct.VolumeId

}


GetAttVolList
New-EbsSnapshot

