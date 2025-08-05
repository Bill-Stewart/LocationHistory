<#

LocationHistory.psm1 - Written by Bill Stewart (bstewart AT iname.com)

Special thanks to Keith Hill for Pscx.CD.psm1 - this module uses the same basic
technique (i.e., two list objects to maintain the location history).

See README.md for module details.

#>

#requires -version 5.1

# Imports <lang>\Messages.psd1 as $Messages hashtable
Import-LocalizedData Messages -FileName Messages

# Remember no more than this many locations.
$MAX_HISTORY_SIZE = 100

# Class definition for LocationHistoryHistoryEntry object.
class LocationHistoryHistoryEntry {
  [String] $Current
  [Int]    $Id
  [String] $Location

  LocationHistoryHistoryEntry([Boolean] $Current,[Int] $Id,[String] $Location) {
    $this.Current = ($null,'=>')[$Current]
    $this.Id = $Id
    $this.Location = $Location
  }
}

# Module-level global variables store the location stacks
$BackwardStack = New-Object Collections.Generic.List[String]
$ForwardStack = New-Object Collections.Generic.List[String]

# Clear location history.
function Clear-LocationHistory {
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = "High")]
  param()
  if ( $PSCmdlet.ShouldProcess($Messages.ClearLocationHistoryTarget,$Messages.ClearLocationHistoryAction) ) {
    $ForwardStack.Clear()
    $BackwardStack.Clear()
  }
}

# Output location history.
function Get-LocationHistory {
  if ( $BackwardStack.Count -ge 0 ) {
    for ( $i = 0; $i -lt $BackwardStack.Count; $i++ ) {
      New-Object -TypeName LocationHistoryHistoryEntry $false,$i,$BackwardStack[$i]
    }
  }
  $ndx = $BackwardStack.Count
  New-Object -TypeName LocationHistoryHistoryEntry $true,$ndx,$ExecutionContext.SessionState.Path.CurrentLocation.Path
  if ( $ForwardStack.Count -ge 0 ) {
    $ndx++
    for ( $i = 0; $i -lt $ForwardStack.Count; $i++ ) {
      New-Object -TypeName LocationHistoryHistoryEntry $false,($ndx + $i),$ForwardStack[$i]
    }
  }
}

# Remove location from location history.
function Remove-LocationHistory {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(Mandatory,ValueFromPipeline)]
    [Int]
    $Id
  )
  if ( $PSCmdlet.ShouldProcess(($Messages.RemoveLocationHistoryTarget -f $Id),$Messages.RemoveLocationHistoryAction) ) {
    if ( ($Id -lt 0) -or ($Id -gt $MAX_HISTORY_SIZE - 1) ) {
      Write-Warning ($Messages.IdOutOfRange -f ($MAX_HISTORY_SIZE - 1))
      return
    }
    if ( $Id -eq $BackwardStack.Count ) {
      Write-Warning $Messages.CannotRemoveCurrentLocation
      return
    }
    if ( $Id -lt $BackwardStack.Count ) {
      $BackwardStack.RemoveAt($Id)
    }
    elseif ( ($Id -gt $BackwardStack.Count) -and ($Id -lt ($BackwardStack.Count + 1 + $ForwardStack.Count)) ) {
      $ndx = $Id - ($BackwardStack.Count + 1)
      $ForwardStack.RemoveAt($ndx)
    }
    else {
      Write-Warning ($Messages.IdDoesNotExist -f $Id)
    }
  }
}

# Set location and update location history.
function Set-LocationEx {
  [CmdletBinding(DefaultParameterSetName = "Path")]
  param(
    [Parameter(ParameterSetName = "Path",Position = 0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [String]
    $Path,

    [Parameter(ParameterSetName = "LiteralPath",Position = 0,Mandatory)]
    [String]
    $LiteralPath,

    [Parameter(ParameterSetName = "Id",Position = 0,Mandatory)]
    [Int]
    $Id,

    [Switch]
    [Alias("Clipboard")]
    $CopyToClipboard,

    [Switch]
    $PassThru
  )
  process {
    $currentPathInfo = $ExecutionContext.SessionState.Path.CurrentLocation
    if ( "Path","LiteralPath" -contains $PSCmdlet.ParameterSetName ) {
      $newPath = ($LiteralPath,$Path)[$PSCmdlet.ParameterSetName -eq "Path"]
      if ( $PSCmdlet.ParameterSetName -eq "Path" ) {
        if ( -not $newPath ) {
          if ( -not $CopyToClipboard ) {
            Get-LocationHistory
          }
          else {
            $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
          }
          return
        }
        if ( $newPath -eq '-' ) {
          if ( $BackwardStack.Count -eq 0 ) {
            Write-Warning $Messages.NoPreviousLocation
          }
          else {
            $lastNdx = $BackwardStack.Count - 1
            Set-Location -LiteralPath $BackwardStack[$lastNdx] -PassThru:$PassThru
            if ( $currentPathInfo.Path -ne $ExecutionContext.SessionState.Path.CurrentLocation.Path ) {
              $ForwardStack.Insert(0,$currentPathInfo.Path)
              $BackwardStack.RemoveAt($lastNdx)
              if ( $CopyToClipboard ) {
                $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
              }
            }
          }
          return
        }
        if ( $newPath -eq '+' ) {
          if ( $ForwardStack.Count -eq 0 ) {
            Write-Warning $Messages.NoNextLocation
          }
          else {
            Set-Location -LiteralPath $ForwardStack[0] -PassThru:$PassThru
            if ( $currentPathInfo.Path -ne $ExecutionContext.SessionState.Path.CurrentLocation.Path ) {
              $BackwardStack.Add($currentPathInfo.Path)
              $ForwardStack.RemoveAt(0)
              if ( $CopyToClipboard ) {
                $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
              }
            }
          }
          return
        }
      }
      # Expand ..[.]+ to ..\..[\..]+
      if ( $newPath -like "*...*" ) {
        $regex = [Regex] '\.\.\.'
        while ( $regex.IsMatch($newPath) ) {
          $newPath = $regex.Replace($newPath,'..\..')
        }
      }
      $params = @{
        ("LiteralPath","Path")[$PSCmdlet.ParameterSetName -eq "Path"] = $newPath
        PassThru = $PassThru
      }
      Set-Location @params
      if ( $currentPathInfo.Path -ne $ExecutionContext.SessionState.Path.CurrentLocation.Path ) {
        # Remove oldest entry if size exceeded
        if ( ($BackwardStack.Count + $ForwardStack.Count + 1) -eq $MAX_HISTORY_SIZE ) {
          $BackwardStack.RemoveAt(0)
        }
        $BackwardStack.Add($currentPathInfo.Path)
        # Append new locations to end of stack
        if ( $ForwardStack.Count -gt 0 ) {
          $BackwardStack.InsertRange($BackwardStack.Count,$ForwardStack)
          $ForwardStack.Clear()
        }
        if ( $CopyToClipboard ) {
          $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
        }
      }
      return
    }
    if ( $PSCmdlet.ParameterSetName -eq "Id" ) {
      if ( ($Id -lt 0) -or ($id -gt ($MAX_HISTORY_SIZE - 1)) ) {
        Write-Warning ($Messages.IdOutOfRange -f ($MAX_HISTORY_SIZE - 1))
        return
      }
      if ( $Id -eq $BackwardStack.Count ) {
        if ( $CopyToClipboard ) {
          $currentPathInfo.Path | Set-Clipboard
        }
        if ( $PassThru ) {
          $currentPathInfo
        }
        return  # Going nowhere
      }
      if ( $Id -lt $BackwardStack.Count ) {
        Set-Location -LiteralPath $BackwardStack[$Id] -PassThru:$PassThru
        if ( $currentPathInfo.Path -ne $ExecutionContext.SessionState.Path.CurrentLocation.Path ) {
          $ForwardStack.Insert(0,$currentPathInfo.Path)
          $BackwardStack.RemoveAt($Id)
          $ndx = $Id
          $count = $BackwardStack.Count - $ndx
          if ( $count -gt 0 ) {
            $itemsToMove = $BackwardStack.GetRange($ndx,$count)
            $ForwardStack.InsertRange(0,$itemsToMove)
            $BackwardStack.RemoveRange($ndx,$count)
          }
          if ( $CopyToClipboard ) {
            $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
          }
        }
      }
      elseif ( ($Id -gt $BackwardStack.Count) -and ($Id -lt ($BackwardStack.Count + 1 + $ForwardStack.Count)) ) {
        $ndx = $Id - ($BackwardStack.Count + 1)
        Set-Location -LiteralPath $ForwardStack[$ndx] -PassThru:$PassThru
        if ( $currentPathInfo.Path -ne $ExecutionContext.SessionState.Path.CurrentLocation.Path ) {
          $BackwardStack.Add($currentPathInfo.Path)
          $ForwardStack.RemoveAt($ndx)
          $count = $ndx
          if ( $count -gt 0 ) {
            $itemsToMove = $ForwardStack.GetRange(0,$count)
            $BackwardStack.InsertRange(($BackwardStack.Count),$itemsToMove)
            $ForwardStack.RemoveRange(0,$count)
          }
          if ( $CopyToClipboard ) {
            $ExecutionContext.SessionState.Path.CurrentLocation.Path | Set-Clipboard
          }
        }
      }
      else {
        Write-Warning ($Messages.IdDoesNotExist -f $Id)
      }
      return
    }
  }
}

$PreviousAlias = Get-Alias cd -ErrorAction SilentlyContinue

Set-Alias `
  -Name cd `
  -Value Set-LocationEx `
  -Description $Messages.AliasDescription `
  -Force `
  -Option AllScope `
  -Scope Global

$ExecutionContext.SessionState.Module.OnRemove = {
  if ( $PreviousAlias ) {
    Set-Alias `
    -Name cd `
    -Value $PreviousAlias.Definition `
    -Force `
    -Option $PreviousAlias.Options `
    -Scope Global
  }
}.GetNewClosure()
