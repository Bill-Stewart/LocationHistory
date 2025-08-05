---
external help file: LocationHistory-help.xml
Module Name: LocationHistory
schema: 2.0.0
---

# Clear-LocationHistory

## SYNOPSIS

Clears the location history.

## SYNTAX

```
Clear-LocationHistory [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears the location history. The location history contains a list of locations visited in the current PowerShell session.

## EXAMPLES

### EXAMPLE 1

```powershell
PS > Clear-LocationHistory
```

Clears the location history. This command will prompt for confirmation. To bypass the confirmation prompt, specify '-Confirm:$false'.

## PARAMETERS

### -Confirm

Prompts you for confirmation before clearing the location history.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS
