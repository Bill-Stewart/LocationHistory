# LocationHistory

**LocationHistory** is a PowerShell module that provides an enhanced location history, allowing easy access to previous locations.

## Copyright and Author

(C) 2017-2025 by by Bill Stewart (bstewart AT iname.com), with special thanks to Keith Hill

## License

LocationHistory is covered by the MIT license. See `LICENSE.txt` for details.

## Version History

See `history.md`.

## System Requirements

The module requires PowerShell 5.1 or later.

## Installation

The following sections describe how to install the module.

### Install from the PowerShell Gallery

To install the module from the PowerShell gallery, run the following command as an administrator:

    Install-Module LocationHistory -Scope AllUsers

To install for the current user only, you can omit **-Scope AllUsers**.

### Install Manually

Create the folder structure for the module and copy the files manually. See the following link for more information:

https://learn.microsoft.com/en-us/powershell/scripting/developer/module/installing-a-powershell-module

### Load Module at Startup

To automatically set the **cd** alias to **Set-LocationEx** when you start PowerShell, add the following line to your PowerShell profile file (`$PROFILE`):

    Import-Module LocationHistory

## Overview

The **LocationHistory** module is based on the PSCX (PowerShell community extensions) **CD** module written by Keith Hill.

This module provides an extended **Set-Location** replacement function called **Set-LocationEx** that maintains a location history, allowing easy navigation to previous locations.

The module adds the following cmdlets:

| Cmdlet                     | Description
| ------                     | -----------
| **Set-LocationEx**         | Changes to a new location or to a location in the location history.
| **Get-LocationHistory**    | Outputs the location history.
| **Clear-LocationHistory**  | Clears the location history.
| **Remove-LocationHistory** | Removes a location from the location history.

## Usage

When the module loads, it sets the **cd** alias to **Set-LocationEx**. You can generally use the **cd** (i.e., **Set-LocationEx**) command in the same way as **Set-Location**, with the following changes:

* The **cd** command without parameters outputs the location history (same as **Get-LocationHistory**). This is a change from **Set-Location**, which changes to the current user's home directory if you run it without parameters. To change to the current user's home directory, use `cd ~`.

* As with **Set-Location** in newer PowerShell versions, **cd** supports a parameter of `-` and `+` to change to the previous and next locations in the location history, respectively.

* The **cd** command supports a numeric argument to change to a numbered location in the location history (e.g., `cd 3` changes to location 3). If you need to change to a location with the same name as a numbered location history, you can do one of the following:
  * Use the **-LiteralPath** parameter
  * Enclose the the location's name in single or double quotes
  * Prefix the location's name with `.\` or `./`

* The **cd** command has a **-CopyToClipboard** (or just **-Clipboard**, or even just **-c**) parameter for copying the location's path to the clipboard (if it exists). Examples:
  * `cd -c` copies the current location's path to the clipboard
  * `cd newdir -c` changes to `newdir` and copies that location's path to the clipboard
  * `cd - -c` changes to the previous location in the location history and copies that location's path to the clipboard
  * `cd 4 -c` changes to location 4 in the location history and copies that location's path to the clipboard

* The **cd** command supports adding `.` characters to `..` to specify parent locations of the parent location. That is, `cd ..` navigates to the parent location, `cd ...` navigates to the parent's location's parent location, and so forth.

* The **cd** command does not support the following parameters:
  * **-StackName**
  * **-UseTransaction**
