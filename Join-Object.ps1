<#
Join-Object LINQ Edition (Alpha).
Aims to provide the exact functibility of http://ramblingcookiemonster.github.io/Join-Object/ with much better performance.
Initial testing shows at last 100 time faster.
#>

#region Join
[System.Func[System.Object, string]]$LeftJoinFunction = {
	param ($LeftLine) 
	$LeftLine.subscriptionID
}
[System.Func[System.Object, string]]$RightJoinFunction = {
	param ($RightLine) 
	$RightLine.sub_id
}
[System.Func[System.Object, [Collections.Generic.IEnumerable[System.Object]], System.Object]]$query = {
	param(
		$LeftLine,
		$RightLineEnumerable
	)
    foreach ($RightLine in $RightLineEnumerable)
    {
        foreach ($item in $RightLine.PSObject.Properties )
        {
            if ($item.Name -ne 'sub_id')
            {
                #$LeftLine | Add-Member -NotePropertyName $item.Name -NotePropertyValue $item.Value
                $LeftLine.PSObject.Properties.Add($item)
            }
        }
    }
    $LeftLine
}
$myOutputArray = [System.Linq.Enumerable]::ToArray(
	[System.Linq.Enumerable]::GroupJoin($Left, $Right, $LeftJoinFunction, $RightJoinFunction, $query)
)
#endregion Join