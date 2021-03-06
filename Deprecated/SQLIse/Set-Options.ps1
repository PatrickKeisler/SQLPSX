function Set-Options
{
param()
New-Grid -Columns 3 -Rows 25 -width 600 -height 600 {
      $script:Action = {
        $results = $window | Get-ChildControl |  where { $_.GroupName -eq "Results" -and $_.IsChecked } | foreach { $_.Content }
        $options.Results = $results
        $OutputVariable = $window | Get-ChildControl OutputVariable
        $options.OutputVariable = $OutputVariable.Text
        $window | Get-ChildControl |  where { $_.gettype().Name -eq "CheckBox" } | foreach { $options.$($_.Content) = $_.IsChecked }
        $indentationSize = $window | Get-ChildControl IndentationSize
        $options.IndentationSize = $indentationSize.Text
        $SqlVersion = $window | Get-ChildControl SqlVersion
        $options.SqlVersion = $SqlVersion.SelectedItem
        $KeywordCasing = $window | Get-ChildControl KeywordCasing
        $options.KeywordCasing = $KeywordCasing.SelectedItem
        $this.Parent.Parent.Tag = $options
        $window.Close()
    }
        
    New-StackPanel -Orientation horizontal -Row 1 -HorizontalAlignment Left -ColumnSpan 2 {
    New-CheckBox -Row 1 -Content "QuotedIdentifierOff" -HorizontalAlignment Left -IsChecked $options.QuotedIdentifierOff
    }
        
    New-StackPanel -Orientation horizontal -Row 2 -HorizontalAlignment Left -ColumnSpan 2 {
    New-Label -Row 2 "SQL Version:" -VerticalContentAlignment 'Center'
    New-ComboBox -Row 2 -Column 1 -Name SqlVersion -Width 200 -Height 20 {'Sql100','Sql90','Sql80'} -SelectedItem $options.SqlVersion
    }
    
    New-Separator -Row 3 -ColumnSpan 2

    New-CheckBox -Row 4 -Content "AlignClauseBodies" -HorizontalAlignment Left -IsChecked $options.AlignClauseBodies
    New-CheckBox -Row 4 -Column 1 -Content "AlignColumnDefinitionFields"  -HorizontalAlignment Left -IsChecked $options.AlignColumnDefinitionFields
    New-CheckBox -Row 5 -Content "AlignSetClauseItem" -HorizontalAlignment Left -IsChecked $options.AlignSetClauseItem
    New-CheckBox -Row 5 -Column 1 -Content "AsKeywordOnOwnLine" -HorizontalAlignment Left -IsChecked $options.AsKeywordOnOwnLine
    New-CheckBox -Row 6 -Content "IncludeSemicolons" -HorizontalAlignment Left -IsChecked $options.IncludeSemicolons
        
    New-StackPanel -Orientation horizontal -Row 7 -HorizontalAlignment Left -ColumnSpan 2 {
    New-Label -Row 7 "Indentation Size:" -VerticalContentAlignment 'Center'
    New-TextBox -Row 7 -Column 1 -Name IndentationSize -Width 20 -Height 20 -Text $options.IndentationSize
    }
    
    New-Separator -Row 8 -ColumnSpan 2
    
    New-CheckBox -Row 9 -Content "IndentSetClause" -HorizontalAlignment Left -IsChecked $options.IndentSetClause
    New-CheckBox -Row 9 -Column 1 -Content "IndentViewBody" -IsChecked $options.IndentViewBody

    New-StackPanel -Orientation horizontal -Row 10 -HorizontalAlignment Left -ColumnSpan 2 {
    New-Label -Row 10 "Keyword Casing:" -VerticalContentAlignment 'Center'
    New-ComboBox -Row 10 -Column 1 -Name KeywordCasing -Width 200 -Height 20 {'Uppercase','Lowercase','PascalCase'} -SelectedItem $options.KeywordCasing
    }
    
    New-Separator -Row 11 -ColumnSpan 2
    
    New-CheckBox -Row 12 -Content "MultilineInsertSourcesList" -HorizontalAlignment Left -IsChecked $options.MultilineInsertSourcesList
    New-CheckBox -Row 12 -Column 1 -Content "MultilineInsertTargetsList" -IsChecked $options.MultilineInsertTargetsList
    New-CheckBox -Row 13 -Content "MultilineSelectElementsList" -HorizontalAlignment Left -IsChecked $options.MultilineSelectElementsList
    New-CheckBox -Row 13 -Column 1 -Content "MultilineSetClauseItems" -IsChecked $options.MultilineSetClauseItems
    New-CheckBox -Row 14 -Content "MultilineViewColumnsList" -HorizontalAlignment Left -IsChecked $options.MultilineViewColumnsList
    New-CheckBox -Row 14 -Column 1 -Content "MultilineWherePredicatesList" -IsChecked $options.MultilineWherePredicatesList
    New-CheckBox -Row 15 -Content "NewLineBeforeCloseParenthesisInMultilineList" -HorizontalAlignment Left -IsChecked $options.NewLineBeforeCloseParenthesisInMultilineList
    New-CheckBox -Row 15 -Column 1 -Content "NewLineBeforeFromClause" -IsChecked $options.NewLineBeforeFromClause
    New-CheckBox -Row 16 -Content "NewLineBeforeGroupByClause" -HorizontalAlignment Left -IsChecked $options.NewLineBeforeGroupByClause
    New-CheckBox -Row 16 -Column 1 -Content "NewLineBeforeHavingClause" -IsChecked $options.NewLineBeforeHavingClause
    New-CheckBox -Row 17 -Content "NewLineBeforeJoinClause" -HorizontalAlignment Left -IsChecked $options.NewLineBeforeJoinClause
    New-CheckBox -Row 17 -Column 1 -Content "NewLineBeforeOpenParenthesisInMultilineList" -IsChecked $options.NewLineBeforeOpenParenthesisInMultilineList
    New-CheckBox -Row 18 -Content "NewLineBeforeOrderByClause" -HorizontalAlignment Left -IsChecked $options.NewLineBeforeOrderByClause
    New-CheckBox -Row 18 -Column 1 -Content "NewLineBeforeOutputClause" -IsChecked $options.NewLineBeforeOutputClause
    New-CheckBox -Row 19 -Content "NewLineBeforeWhereClause" -HorizontalAlignment Left -IsChecked $options.NewLineBeforeWhereClause
    New-CheckBox -Row 19 -Column 1 -Content "PoshMode" -IsChecked $options.PoshMode
    
    New-Separator -Row 20 -ColumnSpan 2
     
    New-StackPanel -Orientation horizontal -Row 21 -Column 1 -HorizontalAlignment Right {
        New-Button -Name OK "OK" -Row 21  -On_Click $Action -Width 75 -Height 25
        New-Button -Name Cancel "Cancel" -Row 21 -Column 1 -On_Click {$window.Close()} -Width 75 -Height 25
    }
        
} -show
}


function Set-Outputformat
{            
    New-StackPanel {            
        New-RadioButton -Content "auto"     -GroupName Results -IsChecked $True -On_Click { $env:SQLPsx_QueryOutputformat = "auto" }            
        New-RadioButton -Content "list"     -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "list" }            
        New-RadioButton -Content "table"    -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "table" }
        New-RadioButton -Content "grid"     -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "grid" }
        New-RadioButton -Content "variable" -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "variable" }
        New-RadioButton -Content "csv"      -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "csv" }
        New-RadioButton -Content "file"     -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "file" }
        New-RadioButton -Content "isetab"   -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "isetab" }
        New-RadioButton -Content "inline"   -GroupName Results -On_Click { $env:SQLPsx_QueryOutputformat = "inline" }
        
                    
    } -asjob            
}           
