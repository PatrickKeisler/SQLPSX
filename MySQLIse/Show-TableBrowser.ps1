function Show-TableBrowser ($resource) {
    New-Grid -Rows 1 -Columns 2 {
        New-ListView -Column 0 -Row 1 -Name TableView -View {
           New-GridView -AllowsColumnReorder -Columns {
               New-GridViewColumn "TABLE_SCHEMA" 
               New-GridViewColumn "TABLE_NAME" 
           }
        }   -On_SelectionChanged {
            $restriction = New-Object string[] -ArgumentList 4
            $restriction[1] = $conn.Database
            $restriction[2] = $this.selecteditem.TABLE_NAME
            $window.Title = "$($conn.database) Browser - $($this.selecteditem.TABLE_NAME)"
            $ColumnView = $window | Get-ChildControl ColumnView
            $ColumnView.ItemsSource = @($conn.GetSchema('Columns', $restriction) |  Sort-Object COLUMN_NAME)
        }

        New-ListView -Column 1 -Row 1 -Name ColumnView -View {
            New-GridView -AllowsColumnReorder  -Columns { 
                    New-GridViewColumn "COLUMN_NAME"
                    New-GridViewColumn "DATA_TYPE" 
                    New-GridViewColumn "CHARACTER_MAXIMUM_LENGTH"
                   }
        }

    } -On_Loaded {
            $conn = $resource.conn
            $window.Title = "$($conn.database) Database Browser"
            $TableView = $window | Get-ChildControl TableView
            # With MySQL must be explicitly restricted to current database 
            $restriction = New-Object string[] -ArgumentList 4
            $restriction[1] = $conn.Database
            $TableView.ItemsSource = @($conn.GetSchema('Tables', $restriction) | Sort-Object TABLE_SCHEMA, TABLE_NAME)
    } -asjob -Resource $resource
}

# http://msdn.microsoft.com/en-us/library/cc716722.aspx