$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/../assert-pubsub-report.ps1"
$directory = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory $directory | Out-Null
try {
    $path = Join-Path $directory 'report.xml'
    $valid = '<testsuite name="TestXmppPubSub" tests="2" failures="0" errors="0"><testcase name="tlsAndPubSub"/><testcase name="rejectsUntrustedTls"/></testsuite>'
    $valid | Set-Content $path
    Assert-PubSubReport $path
    $invalid = @(
        '<testsuite name="TestXmppPubSub" tests="0" failures="0" errors="0"/>',
        $valid.Replace('failures="0"', 'failures="1"'),
        $valid.Replace('errors="0"', 'errors="1"'),
        $valid.Replace('<testcase name="tlsAndPubSub"/>', '<testcase name="tlsAndPubSub"><skipped/></testcase>'),
        $valid.Replace('<testcase name="rejectsUntrustedTls"/>', ''),
        $valid.Replace('TestXmppPubSub', 'AnotherSuite')
    )
    foreach ($xml in $invalid) {
        $xml | Set-Content $path
        $rejected = $false
        try { Assert-PubSubReport $path } catch { $rejected = $true }
        if (!$rejected) { throw "Accepted invalid report: $xml" }
    }
    Remove-Item $path
    $rejected = $false
    try { Assert-PubSubReport $path } catch { $rejected = $true }
    if (!$rejected) { throw 'Accepted a missing report' }
    Write-Host 'Report validation passed: valid report accepted; seven invalid/missing reports rejected.'
} finally { Remove-Item $directory -Recurse -Force }
