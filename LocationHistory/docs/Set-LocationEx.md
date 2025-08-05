---
external help file: LocationHistory-help.xml
Module Name: LocationHistory
schema: 2.0.0
---

# Set-LocationEx

## SYNOPSIS

Set-Location alternative that maintains a location history, allowing easy navigation to previous locations.

## SYNTAX

### Path (Default)
```
Set-LocationEx [[-Path] <String>] [-CopyToClipboard] [-PassThru] [<CommonParameters>]
```

### LiteralPath
```
Set-LocationEx [-LiteralPath] <String> [-CopyToClipboard] [-PassThru] [<CommonParameters>]
```

### Id
```
Set-LocationEx [-Id] <Int32> [-CopyToClipboard] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION

Set-Location alternative that maintains a location history, allowing easy navigation to previous locations. The location history contains a list of locations visited in the current PowerShell session. The location history stores up to 100 locations.

## EXAMPLES

### EXAMPLE 1

```powershell
PS > Set-LocationEx
```

Outputs the location history (same as Get-LocationHistory).

### EXAMPLE 2

```powershell
PS > Set-LocationEx ...
```

Changes two levels up from the current location. For example, if you are in C:\Windows\System32\WindowsPowerShell\v1.0, this command will change to C:\Windows\System32.

### EXAMPLE 3

```powershell
PS > Set-LocationEx -
```

Changes to the previous location in the location history (if it exists).

### EXAMPLE 4

```powershell
PS > Set-LocationEx 3
```

Changes to location history entry 3 in the location history. Use Set-LocationEx without parameters or Get-LocationHistory to see the location history. The -Id parameter name is optional.

### EXAMPLE 5

```powershell
PS > Set-LocationEx "10"
```

Changes to the location named "10" in the current location. Without the quotes, Set-LocationEx will interpret the parameter as a numeric location history entry. You can also prefix the location with ".\" to prevent Set-LocationEx from interpreting the parameter as a location history entry; e.g.: "Set-LocationEx .\10".

### EXAMPLE 6

```powershell
PS > Set-LocationEx -Id 15 -CopyToClipboard
```

Changes to location history entry 15 and copies its path to the clipboard.

### EXAMPLE 7

```powershell
PS > Set-LocationEx ~
```

Changes to the current user's home directory (see about_Special_Characters for more information).

### EXAMPLE 8

```powershell
PS > Set-LocationEx -Clipboard
```

Copies the current location to the clipboard. (-Clipboard is an alias for -CopyToClipboard.)

## PARAMETERS

### -CopyToClipboard

Copies the requested location path to the clipboard.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Clipboard

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Changes to the specified location history entry in the location history.

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path of a new working location. This parameter is used exactly as it is typed.

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Outputs a PathInfo object that represents the requested location (if it exists).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path of a new working location. Specify "-" to move to the previous location in the location history (if it exists), or "+" to move to the next location in the location history (if it exists). Omit this parameter to output the location history.

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

You can pipe a string to specify the location.

## OUTPUTS

### PathInfo

Outputs a PathInfo object when using the -PassThru parameter and the location exists.

## NOTES

For the -Path and -LiteralPath parameters, "." refers to the current location, ".." refers to the current location's parent, "..." to that location's parent, and so forth.

## RELATED LINKS
