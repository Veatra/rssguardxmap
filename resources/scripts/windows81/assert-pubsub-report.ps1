# Also used by regression checks without loading Windows APIs or the package.
function Assert-PubSubReport([string]$Path) {
    if (!(Test-Path $Path)) { throw "Missing PubSub test report: $Path" }
    [xml]$document = Get-Content $Path -Raw
    $suite = $document.testsuite
    if (!$suite -or $suite.name -ne 'TestXmppPubSub' -or [int]$suite.tests -lt 2 -or
        [int]$suite.failures -ne 0 -or [int]$suite.errors -ne 0 -or
        $document.SelectNodes('//failure|//error|//skipped').Count -ne 0) {
        throw "PubSub test report contains failures, skipped tests or no tests: $Path"
    }
    foreach ($name in 'tlsAndPubSub', 'rejectsUntrustedTls') {
        if (@($suite.testcase | Where-Object name -eq $name).Count -ne 1) {
            throw "Required PubSub test did not execute: $name"
        }
    }
}
