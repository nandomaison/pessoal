cd\
reg add "HKLM\System\CurrentControlSet\Control\StorageDevicePolicies" /t Reg_dword /v WriteProtect /f /d 1
