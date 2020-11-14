# Script to generate Windows XML Event Log (EVTX) test files

# New-EventLog requires administrator privilege
New-EventLog -LogName TestLog -Source TestSource

Write-EventLog -LogName TestLog -Source TestSource -EventID 1 -EntryType Error -Message "Error message"
Write-EventLog -LogName TestLog -Source TestSource -EventID 1 -EntryType Information -Message "Informational message"
Write-EventLog -LogName TestLog -Source TestSource -EventID 1 -EntryType FailureAudit -Message "Audit failure message"
Write-EventLog -LogName TestLog -Source TestSource -EventID 1 -EntryType SuccessAudit -Message "Audit success message"
Write-EventLog -LogName TestLog -Source TestSource -EventID 1 -EntryType Warning -Message "Warning message"

Write-EventLog -LogName TestLog -Source TestSource -EventID 22 -EntryType Information -Message "Message with category" -Category 1
Write-EventLog -LogName TestLog -Source TestSource -EventID 22 -EntryType Information -Message "Message with raw data" -RawData 00,01,02,03,04,05,06,07,08,09

Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``0 (`0) Null"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``a (`a) Alert"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``b (`b) Backspace"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``e (`e) Escape"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``f (`f) Form feed"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``n (`n) New line"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``r (`r) Carriage return"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``t (`t) Horizontal tab"
Write-EventLog -LogName TestLog -Source TestSource -EventID 333 -EntryType Information -Message "Message with control character: ``v (`v) Vertical tab"

# TODO: add message with `u{####} Unicode escape sequence

Write-EventLog -LogName TestLog -Source TestSource -EventID 4444 -EntryType Information -Message "Message with embedded XML </Data>"

$LogFile = Get-WmiObject -Class Win32_NTEventlogFile | Where-Object LogfileName -eq "TestLog"
$LogFile.BackupEventlog("${PWD}\TestLog.evtx")

Remove-EventLog -Source TestSource
Remove-EventLog -LogName TestLog

