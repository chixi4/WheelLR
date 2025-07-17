#Persistent
#SingleInstance, Force
#MaxHotkeysPerInterval 700

CoordMode, Mouse, Screen
SetMouseDelay, -1

; ===================================================================
;                         User Configuration
; ===================================================================
global triggerKey  := "LButton" ; Trigger key (LButton/RButton/MButton)
global dragThreshold := 5      ; Drag detection threshold (pixels)
; ===================================================================

global isDragActive               := false
global isTempHorizontalScrollActive := false
global isGracePeriodActive        := false
global startX, startY

Hotkey, % "$" . triggerKey, TriggerKeyDown
Hotkey, % "$" . triggerKey . " Up", TriggerKeyUp

ToolTip, WheelLR Active
SetTimer, RemoveToolTip, -1500
return

TriggerKeyDown:
    isDragActive := false
    isTempHorizontalScrollActive := false
    isGracePeriodActive := false
    MouseGetPos, startX, startY
    SetTimer, CheckForDrag, 10
return

TriggerKeyUp:
    SetTimer, CheckForDrag, Off

    if (isTempHorizontalScrollActive)
    {
        isGracePeriodActive := true
        SetTimer, EndGracePeriod, -150
        return
    }
    else if (isDragActive)
    {
        SendInput, % "{" . triggerKey . " Up}"
    }
    else
    {
        Click, % (triggerKey = "RButton" ? "Right" : "Left")
    }
return

CheckForDrag:
    if !GetKeyState(triggerKey, "P")
    {
        SetTimer, CheckForDrag, Off
        return
    }

    MouseGetPos, currentX, currentY
    if (Abs(currentX - startX) > dragThreshold or Abs(currentY - startY) > dragThreshold)
    {
        SetTimer, CheckForDrag, Off
        isDragActive := true

        BlockInput, On
        try
        {
            MouseMove, startX, startY, 0
            Sleep, 10
            SendInput, % "{" . triggerKey . " Down}"
        }
        finally
        {
            BlockInput, Off
        }
    }
return

#If (GetKeyState(triggerKey, "P") and !isDragActive) or isGracePeriodActive
    WheelUp::
        Critical
        SetTimer, CheckForDrag, Off
        isTempHorizontalScrollActive := true
        SendInput, {Left}
        SetTimer, EndGracePeriod, -150
        ToolTip, ←
        SetTimer, RemoveToolTip, -500
    return

    WheelDown::
        Critical
        SetTimer, CheckForDrag, Off
        isTempHorizontalScrollActive := true
        SendInput, {Right}
        SetTimer, EndGracePeriod, -150
        ToolTip, →
        SetTimer, RemoveToolTip, -500
    return
#If

RemoveToolTip:
    ToolTip
return

EndGracePeriod:
    isGracePeriodActive := false
return

; Safe Exit Hotkey (Alt+G, then D)
!g::
    KeyWait, g, T0.2
    if (ErrorLevel)
    {
        ToolTip, Press D to exit WheelLR
        Input, UserInput, L1 T3, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}, d
        ToolTip
        if (UserInput = "d")
        {
            ToolTip, WheelLR Exited
            Sleep, 1000
            ExitApp
        }
    }
return