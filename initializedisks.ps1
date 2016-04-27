param(
    [parameter(Mandatory=$true)]
    [int[]]$disks
)

$friendlypoolname = "primarydiskpool"
$dktopool = Get-PhysicalDisk | Where-Object {$_.CanPool -eq $true}
$subsystem = Get-StorageSubSystem
#New-StoragePool -FriendlyName $friendlypoolname -StorageSubSystemFriendlyName $subsystem.FriendlyName -PhysicalDisks $dktopool
$protype = "fixed"
$resilsetting = "Simple"
$disks | Out-File c:\scripts\test.txt
#$disks = @(2000, 500, 5000, 1000, 300, 200)
$count = 0;
foreach ($disk in $disks){    
    #$disk = [int]$disk
    $vdisk = New-VirtualDisk -StoragePoolFriendlyName $friendlypoolname -FriendlyName ("DataDisk_"+$count)  -Size ($disk*1GB) -ResiliencySettingName $resilsetting -ProvisioningType $protype
    Initialize-Disk -VirtualDisk (Get-VirtualDisk -FriendlyName ("DataDisk_"+$count))
    $curdisk = get-disk -VirtualDisk $vdisk
    $partition = New-Partition -DiskNumber $curdisk.Number -UseMaximumSize -AssignDriveLetter
    Format-Volume -DriveLetter $partition.DriveLetter -Confirm:$false | out-null
    $count++
}
