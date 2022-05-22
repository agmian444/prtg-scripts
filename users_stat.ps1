$EnabledUsers=Get-AdUser -Filter "(Name -like '*') -and (Enabled -eq 'True')" -Properties * |select name,enabled

$DisabledUsers=Get-AdUser -Filter "(Name -like '*') -and (Enabled -eq 'False')" -Properties * |select name,enabled

$AllUsers=Get-ADUser -Filter {SamAccountName -like "*"} | Measure-Object


$xmlOutput = '<?xml version="1.0" encoding="UTF-8" ?><prtg>'

$xmlOutput = $xmlOutput + "<result>

    <channel>Enabled users:</channel>
    <unit>Custom</unit>
    <customUnit>#</customUnit>
    <mode>Absolute</mode>
    <showChart>1</showChart>
    <showTable>1</showTable>
    <float>0</float>
    <value>$($EnabledUsers.enable.count)</value>                           
    </result>

    <result>
    <channel>Disabled users: </channel>
    <unit>Custom</unit>
    <customUnit></customUnit>
    <mode>Absolute</mode>
    <showChart>1</showChart>
    <showTable>1</showTable>
    <float>0</float>
    <limitmode>1</limitmode>
    <limitmaxwarning>20</limitmaxwarning>
    <limitwarningmsg>Many disabled users!</limitwarningmsg>
    <value>$($DisabledUsers.enable.count)</value>                           
    </result>

    <result>
    <channel>All users: </channel>
    <unit>Custom</unit>
    <customUnit></customUnit>
    <mode>Absolute</mode>
    <showChart>1</showChart>
    <showTable>1</showTable>
    <float>0</float>
    <value>$($AllUsers.Count)</value>                           
    </result>"
    
$xmlOutput = $xmlOutput + '</prtg>'

$xmlOutput
