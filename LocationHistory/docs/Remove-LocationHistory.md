---
external help file: LocationHistory-help.xml
Module Name: LocationHistory
schema: 2.0.0
---

# Remove-LocationHistory

## SYNOPSIS

Removes a location history entry from the location history.

## SYNTAX

```
Remove-LocationHistory [-Id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Removes a location history entry from the location history. This is useful when a location history entry is no longer valid (e.g., a location that has been renamed or removed).

## EXAMPLES

### EXAMPLE 1

```powershell
PS > Remove-LocationHistory 3
```

Removes location history entry 3 from the location history.

## PARAMETERS

### -Id

Removes the specified location history entry from the location history.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

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

### Int32

You can pipe an integer to specify the number of the location history entry to remove.

## OUTPUTS

### None

## NOTES

## RELATED LINKS
