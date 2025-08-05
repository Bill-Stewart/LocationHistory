# LocationHistory PowerShell Module Version History

## 2.0.0 (2025-08-05)

* Removed support for PowerShell versions older than 5.1.

* Changed **-Backward** and **-Forward** parameters to `-` and `+` to align with **Set-Location** in newer versions of PowerShell (as well as user expectations).

* Created separate markdown and XML help (thanks to **platyPS** module).

* Added separate message string file for easier localization.

* Replaced **Get-LocationHistory** output PSObject with a PowerShell class.

* Updated **Remove-LocationHistory** with **-Confirm** and **-WhatIf** support.

* Added pipeline input support of location history entry to **Remove-LocationHistory**.

* Removed **-UseTransaction** parameter from **Set-LocationEx**.


## 1.0.8 (2024-08-05)

* Dropped PSv2 support and updated legacy code.


## 1.0.7 (2017-07-21)

* Bug fix: Don't change stack if setting location fails.

* Added: `-CopyToClipboard` parameter.

* Added: `Remove-LocationHistory`.

* Changed: Get-LocationHistory outputs formatted objects. (Removed `-Raw` parameter.)


## 1.0.5 (2017-02-16)

* Bug fix: Append to location history correctly.


## 1.0.3 (2017-02-07)

* Initial version.
