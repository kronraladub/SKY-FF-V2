$ErrorActionPreference = "SilentlyContinue"
Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Api = "https://tzqltubgqlhqrnxnkqcm.supabase.co/functions/v1/sky-api"
$PublishableKey = "sb_publishable_AqDr9F6FV3ygcMHbBnuAFA_N8xBOH1B"
$DeviceFile = Join-Path $Root "powershell-device.txt"
$BackupFile = Join-Path $Root "ULTRA-X-POWER-BACKUP.txt"

if (!(Test-Path $DeviceFile)) {
    [guid]::NewGuid().ToString() | Set-Content $DeviceFile
}
$DeviceID = (Get-Content $DeviceFile -Raw).Trim()

[xml]$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="SKY FF V2 ULTRA X" Height="850" Width="1450" MinHeight="700" MinWidth="1100" WindowStartupLocation="CenterScreen" Background="#050817" Foreground="White"><Window.Resources><LinearGradientBrush x:Key="Panel" StartPoint="0,0" EndPoint="1,1"><GradientStop Color="#172747" Offset="0" /><GradientStop Color="#0B1228" Offset="1" /></LinearGradientBrush><LinearGradientBrush x:Key="Blue" StartPoint="0,0" EndPoint="1,1"><GradientStop Color="#00E5FF" Offset="0" /><GradientStop Color="#3265FF" Offset="1" /></LinearGradientBrush><Style TargetType="Button"><Setter Property="Foreground" Value="White" /><Setter Property="FontSize" Value="14" /><Setter Property="FontWeight" Value="SemiBold" /><Setter Property="Padding" Value="15,11" /><Setter Property="Margin" Value="5" /><Setter Property="Cursor" Value="Hand" /><Setter Property="Background" Value="#18365A" /><Setter Property="BorderBrush" Value="#258EFF" /><Setter Property="BorderThickness" Value="1" /><Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button"><Border x:Name="bd" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="10"><ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" Margin="{TemplateBinding Padding}" /></Border><ControlTemplate.Triggers><Trigger Property="IsMouseOver" Value="True"><Setter TargetName="bd" Property="Opacity" Value="0.78" /><Setter TargetName="bd" Property="Effect"><Setter.Value><DropShadowEffect Color="#00CFFF" BlurRadius="20" ShadowDepth="0" /></Setter.Value></Setter></Trigger><Trigger Property="IsPressed" Value="True"><Setter TargetName="bd" Property="Opacity" Value="0.55" /></Trigger></ControlTemplate.Triggers></ControlTemplate></Setter.Value></Setter></Style><Style TargetType="TextBox"><Setter Property="Background" Value="#0A1429" /><Setter Property="Foreground" Value="White" /><Setter Property="BorderBrush" Value="#258EFF" /><Setter Property="Padding" Value="12" /><Setter Property="FontSize" Value="15" /></Style><Style TargetType="ProgressBar"><Setter Property="Height" Value="9" /><Setter Property="Foreground" Value="#00D9FF" /><Setter Property="Background" Value="#263653" /></Style></Window.Resources><Grid><Grid.Background><RadialGradientBrush GradientOrigin="0.8,0.1" Center="0.8,0.1" RadiusX="1" RadiusY="1"><GradientStop Color="#172A58" Offset="0" /><GradientStop Color="#080D20" Offset="0.65" /><GradientStop Color="#030611" Offset="1" /></RadialGradientBrush></Grid.Background><!-- LOGIN --><Grid x:Name="LoginPanel" Panel.ZIndex="10"><Border Width="470" Height="480" CornerRadius="28" Background="{StaticResource Panel}" BorderBrush="#287DCE" BorderThickness="1" HorizontalAlignment="Center" VerticalAlignment="Center"><Border.Effect><DropShadowEffect Color="#007BFF" BlurRadius="45" ShadowDepth="0" Opacity="0.55" /></Border.Effect><StackPanel><StackPanel Margin="38" VerticalAlignment="Center"><TextBlock Text="SKY FF" FontSize="48" FontWeight="Black" Foreground="#00DFFF" HorizontalAlignment="Center" /><TextBlock Text="V2  /  ULTRA X" FontSize="17" Foreground="#A6C8FF" HorizontalAlignment="Center" Margin="0,0,0,35" /><TextBlock Text="ONLINE LICENSE AUTHENTICATION" FontSize="12" Foreground="#81A9D8" HorizontalAlignment="Center" Margin="0,0,0,18" /><TextBox x:Name="LicenseInput" Height="48" VerticalContentAlignment="Center" ToolTip="Enter your license key" /><Button x:Name="LoginButton" Content="ACCESS SYSTEM" Height="52" Background="#087DCE" Margin="0,20,0,8" /><TextBlock x:Name="LoginStatus" Text="SECURE CONNECTION READY" Foreground="#6CA9D9" HorizontalAlignment="Center" Margin="0,12" /><TextBlock Text="DEVICE BOUND  •  ONLINE VERIFICATION" Foreground="#526C91" FontSize="10" HorizontalAlignment="Center" /></StackPanel></StackPanel></Border></Grid><!-- MAIN APP --><Grid x:Name="MainPanel" Visibility="Collapsed" Margin="18"><Grid.ColumnDefinitions><ColumnDefinition Width="225" /><ColumnDefinition Width="*" /></Grid.ColumnDefinitions><!-- SIDEBAR --><Border Grid.Column="0" CornerRadius="22" Background="#101A31" BorderBrush="#263E68" BorderThickness="1" Margin="0,0,14,0"><DockPanel Margin="15"><StackPanel DockPanel.Dock="Top"><TextBlock Text="SKY FF" FontSize="29" FontWeight="Black" Foreground="#00DFFF" Margin="8,15,0,0" /><TextBlock Text="ULTRA X CONTROL" FontSize="10" Foreground="#799BC5" Margin="10,0,0,25" /><Separator Background="#29446C" Margin="0,0,0,20" /><Button x:Name="NavDashboard" Content="◈   DASHBOARD" Background="#174B76" /><Button x:Name="NavMonitor" Content="◉   SYSTEM MONITOR" /><Button x:Name="NavBoost" Content="⚡   GAME BOOST" /><Button x:Name="NavCleaner" Content="✦   SYSTEM CLEANER" /><Button x:Name="NavApps" Content="▣   APP MANAGER" /></StackPanel><StackPanel DockPanel.Dock="Bottom" Margin="5,0,5,12"><Border Background="#0A2940" CornerRadius="12" Padding="12"><StackPanel><TextBlock Text="LICENSE STATUS" Foreground="#77A9D5" FontSize="10" /><TextBlock x:Name="RoleText" Text="AUTHORIZED" Foreground="#00E6A8" FontWeight="Bold" Margin="0,5" /><TextBlock x:Name="ExpiryText" Text="ONLINE" Foreground="#7B9DC5" FontSize="10" /></StackPanel></Border><TextBlock Text="SKY FF V2 • ULTRA X" Foreground="#4E688C" FontSize="10" HorizontalAlignment="Center" Margin="0,15" /></StackPanel></DockPanel></Border><!-- CONTENT --><Grid Grid.Column="1"><Grid.RowDefinitions><RowDefinition Height="65" /><RowDefinition Height="*" /></Grid.RowDefinitions><Grid Grid.Row="0"><StackPanel VerticalAlignment="Center"><TextBlock x:Name="PageTitle" Text="COMMAND CENTER" FontSize="24" FontWeight="Bold" Foreground="White" /><TextBlock Text="REAL-TIME PERFORMANCE  /  SYSTEM CONTROL" FontSize="10" Foreground="#6E91BC" /></StackPanel><Border HorizontalAlignment="Right" VerticalAlignment="Center" Background="#102B3C" CornerRadius="12" Padding="14,8"><TextBlock x:Name="ClockText" Text="SYSTEM ONLINE" Foreground="#00E6D2" /></Border></Grid><ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto"><Grid><StackPanel x:Name="DashboardPage"><Grid Margin="0,10,0,12"><Grid.ColumnDefinitions><ColumnDefinition /><ColumnDefinition /><ColumnDefinition /></Grid.ColumnDefinitions><Border Grid.Column="0" Background="{StaticResource Panel}" CornerRadius="18" Padding="18" Margin="5"><Border.Effect><DropShadowEffect Color="#006BFF" BlurRadius="20" ShadowDepth="3" Opacity="0.3" /></Border.Effect><StackPanel><StackPanel><TextBlock Text="CPU LOAD" Foreground="#82A8D4" FontSize="12" /><TextBlock x:Name="CpuValue" Text="--%" FontSize="38" FontWeight="Bold" Foreground="#00DFFF" Margin="0,12" /><ProgressBar x:Name="CpuBar" Value="0" Maximum="100" /><TextBlock x:Name="CpuName" Text="Processor" Foreground="#6688B0" FontSize="10" Margin="0,12,0,0" /></StackPanel></StackPanel></Border><Border Grid.Column="1" Background="{StaticResource Panel}" CornerRadius="18" Padding="18" Margin="5"><Border.Effect><DropShadowEffect Color="#8B4DFF" BlurRadius="20" ShadowDepth="3" Opacity="0.3" /></Border.Effect><StackPanel><StackPanel><TextBlock Text="GPU ENGINE" Foreground="#82A8D4" FontSize="12" /><TextBlock x:Name="GpuValue" Text="--%" FontSize="38" FontWeight="Bold" Foreground="#B58CFF" Margin="0,12" /><ProgressBar x:Name="GpuBar" Value="0" Maximum="100" Foreground="#A36BFF" /><TextBlock x:Name="GpuName" Text="GPU engine data" Foreground="#6688B0" FontSize="10" Margin="0,12,0,0" /></StackPanel></StackPanel></Border><Border Grid.Column="2" Background="{StaticResource Panel}" CornerRadius="18" Padding="18" Margin="5"><Border.Effect><DropShadowEffect Color="#00D6A0" BlurRadius="20" ShadowDepth="3" Opacity="0.3" /></Border.Effect><StackPanel><StackPanel><TextBlock Text="RAM USAGE" Foreground="#82A8D4" FontSize="12" /><TextBlock x:Name="RamValue" Text="--%" FontSize="38" FontWeight="Bold" Foreground="#00E6A8" Margin="0,12" /><ProgressBar x:Name="RamBar" Value="0" Maximum="100" Foreground="#00D9A0" /><TextBlock x:Name="RamName" Text="Memory" Foreground="#6688B0" FontSize="10" Margin="0,12,0,0" /></StackPanel></StackPanel></Border></Grid><Grid Margin="0,0,0,12"><Grid.ColumnDefinitions><ColumnDefinition Width="1.5*" /><ColumnDefinition Width="*" /></Grid.ColumnDefinitions><Border Grid.Column="0" Background="{StaticResource Panel}" CornerRadius="18" Padding="20" Margin="5"><StackPanel><TextBlock Text="PERFORMANCE HISTORY" FontSize="15" FontWeight="Bold" Foreground="White" /><TextBlock Text="LIVE CPU LOAD" FontSize="10" Foreground="#7196C2" Margin="0,4,0,10" /><Canvas x:Name="GraphCanvas" Height="150" ClipToBounds="True"><Polyline x:Name="CpuGraph" Stroke="#00DFFF" StrokeThickness="2.5" /></Canvas></StackPanel></Border><Border Grid.Column="1" Background="{StaticResource Panel}" CornerRadius="18" Padding="20" Margin="5"><StackPanel><TextBlock Text="SYSTEM INFORMATION" FontSize="15" FontWeight="Bold" /><TextBlock x:Name="InfoCPU" Text="CPU: Loading..." Foreground="#8EAFD7" Margin="0,15,0,8" TextWrapping="Wrap" /><TextBlock x:Name="InfoGPU" Text="GPU: Reading..." Foreground="#8EAFD7" Margin="0,5,0,8" TextWrapping="Wrap" /><TextBlock x:Name="InfoRAM" Text="RAM: Reading..." Foreground="#8EAFD7" Margin="0,5,0,8" /><TextBlock x:Name="InfoOS" Text="OS: Reading..." Foreground="#8EAFD7" Margin="0,5,0,8" /></StackPanel></Border></Grid><Border Background="{StaticResource Panel}" CornerRadius="18" Padding="20" Margin="5"><StackPanel><TextBlock Text="ULTRA PERFORMANCE CONTROL" FontSize="16" FontWeight="Bold" /><TextBlock Text="Choose your gaming profile" Foreground="#789CC7" FontSize="11" Margin="0,5,0,12" /><ComboBox x:Name="ProfileBox" Height="35" SelectedIndex="0" Background="#10213D" Foreground="Black"><ComboBoxItem Content="General Gaming" /><ComboBoxItem Content="BlueStacks" /><ComboBoxItem Content="MSI App Player" /><ComboBoxItem Content="FiveM" /></ComboBox><WrapPanel Margin="0,12,0,0"><Button x:Name="BoostButton" Content="⚡  BOOST ALL" Background="#087DCE" Padding="25,14" /><Button x:Name="RestoreButton" Content="↶  RESTORE ALL" Background="#4B315F" Padding="25,14" /></WrapPanel><TextBlock x:Name="BoostStatus" Text="READY FOR OPTIMIZATION" Foreground="#00DFFF" Margin="8,10" /></StackPanel></Border></StackPanel><StackPanel x:Name="MonitorPage" Visibility="Collapsed"><Border Background="{StaticResource Panel}" CornerRadius="18" Padding="25" Margin="5"><StackPanel><TextBlock Text="SYSTEM MONITOR" FontSize="22" FontWeight="Bold" /><TextBlock Text="Live hardware utilization" Foreground="#83A5D0" Margin="0,5,0,20" /><TextBlock Text="CPU" Foreground="#00DFFF" /><ProgressBar x:Name="MCPU" Maximum="100" Height="14" Margin="0,8,0,18" /><TextBlock Text="GPU ENGINE" Foreground="#B58CFF" /><ProgressBar x:Name="MGPU" Maximum="100" Height="14" Margin="0,8,0,18" /><TextBlock Text="RAM" Foreground="#00E6A8" /><ProgressBar x:Name="MRAM" Maximum="100" Height="14" Margin="0,8,0,18" /><TextBlock Text="หมายเหตุ: GPU แสดงค่าจาก Windows Performance Counter หากไดรเวอร์รองรับ" Foreground="#8298B8" TextWrapping="Wrap" /></StackPanel></Border></StackPanel><StackPanel x:Name="CleanerPage" Visibility="Collapsed"><Border Background="{StaticResource Panel}" CornerRadius="18" Padding="25" Margin="5"><StackPanel><TextBlock Text="SYSTEM CLEANER" FontSize="22" FontWeight="Bold" /><TextBlock Text="ลบไฟล์ชั่วคราวที่ไม่จำเป็น โดยไม่แตะไฟล์ส่วนตัว" Foreground="#8BA9D0" Margin="0,12,0,20" /><Button x:Name="CleanButton" Content="✦  CLEAN TEMP FILES" Background="#087DCE" HorizontalAlignment="Left" /><TextBlock x:Name="CleanStatus" Text="พร้อมตรวจสอบไฟล์ชั่วคราว" Foreground="#00DFFF" Margin="10" /></StackPanel></Border></StackPanel><StackPanel x:Name="AppsPage" Visibility="Collapsed"><Border Background="{StaticResource Panel}" CornerRadius="18" Padding="25" Margin="5"><StackPanel><TextBlock Text="APP MANAGER" FontSize="22" FontWeight="Bold" /><TextBlock Text="เลือกโปรแกรมที่ต้องการปิด ตรวจสอบชื่อก่อนหยุดทุกครั้ง" Foreground="#8BA9D0" Margin="0,8,0,15" /><Button x:Name="RefreshApps" Content="REFRESH PROCESS LIST" HorizontalAlignment="Left" /><ListBox x:Name="ProcessList" Height="350" Background="#0A1429" Foreground="White" BorderBrush="#294C79" Margin="5" /><Button x:Name="StopApp" Content="STOP SELECTED APP" Background="#8B3150" HorizontalAlignment="Left" /></StackPanel></Border></StackPanel></Grid></ScrollViewer></Grid></Grid></Grid></Window>
"@

$Reader = New-Object System.Xml.XmlNodeReader $Xaml
$script:Window = [Windows.Markup.XamlReader]::Load($Reader)

function Get-Control($Name) {
    return $script:Window.FindName($Name)
}

$script:CpuCounter = New-Object System.Diagnostics.PerformanceCounter("Processor","% Processor Time","_Total")
$null = $script:CpuCounter.NextValue()
$script:History = New-Object System.Collections.Generic.List[double]
$script:GpuUsage = 0
$script:LastCpu = 0

function Set-Page($Page) {
    foreach ($n in @("DashboardPage","MonitorPage","CleanerPage","AppsPage")) {
        (Get-Control $n).Visibility = "Collapsed"
    }
    (Get-Control $Page).Visibility = "Visible"
    $titles = @{
        DashboardPage="COMMAND CENTER"
        MonitorPage="SYSTEM MONITOR"
        CleanerPage="SYSTEM CLEANER"
        AppsPage="APP MANAGER"
    }
    (Get-Control "PageTitle").Text = $titles[$Page]
}

function Verify-License {
    $key = (Get-Control "LicenseInput").Text.Trim()
    if (!$key) {
        (Get-Control "LoginStatus").Text = "PLEASE ENTER LICENSE KEY"
        return
    }
    (Get-Control "LoginStatus").Text = "VERIFYING ONLINE LICENSE..."
    try {
        $headers = @{
            apikey = $PublishableKey
            Authorization = "Bearer $PublishableKey"
        }
        $body = @{
            action = "verify"
            key = $key
            device_id = $DeviceID
        } | ConvertTo-Json

        $result = Invoke-RestMethod -Uri $Api -Method Post -Headers $headers `
            -ContentType "application/json" -Body $body -TimeoutSec 15

        if ($result.success -ne $true) {
            throw "License verification failed"
        }

        (Get-Control "LoginPanel").Visibility = "Collapsed"
        (Get-Control "MainPanel").Visibility = "Visible"
        (Get-Control "RoleText").Text = ([string]$result.role).ToUpper()
        (Get-Control "ExpiryText").Text = "EXPIRES: $($result.expires_at)"
        $script:Window.Title = "SKY FF V2 ULTRA X - $($result.role)"
        Load-SystemInfo
    }
    catch {
        (Get-Control "LoginStatus").Text = "LOGIN FAILED: $($_.Exception.Message)"
    }
}

function Load-SystemInfo {
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $gpu = Get-CimInstance Win32_VideoController | Select-Object -First 1
    $os = Get-CimInstance Win32_OperatingSystem
    $ramGB = [math]::Round($os.TotalVisibleMemorySize / 1MB,1)

    (Get-Control "CpuName").Text = $cpu.Name
    (Get-Control "GpuName").Text = if ($gpu) {$gpu.Name} else {"GPU unavailable"}
    (Get-Control "RamName").Text = "$ramGB GB TOTAL"
    (Get-Control "InfoCPU").Text = "CPU: $($cpu.Name)"
    (Get-Control "InfoGPU").Text = "GPU: $($gpu.Name)"
    (Get-Control "InfoRAM").Text = "RAM: $ramGB GB"
    (Get-Control "InfoOS").Text = "OS: $($os.Caption)"
}

function Update-Monitor {
    try {
        $cpu = [math]::Round($script:CpuCounter.NextValue())
        $os = Get-CimInstance Win32_OperatingSystem
        $total = [double]$os.TotalVisibleMemorySize
        $free = [double]$os.FreePhysicalMemory
        $ram = if ($total -gt 0) {[math]::Round((($total-$free)/$total)*100)} else {0}

        $gpu = 0
        try {
            $c = Get-Counter '\GPU Engine(*)\Utilization Percentage' -ErrorAction Stop
            $values = @($c.CounterSamples | Where-Object {$_.CookedValue -ge 0} |
                ForEach-Object {$_.CookedValue})
            if ($values.Count -gt 0) {
                $gpu = [math]::Min(100,[math]::Round(($values | Measure-Object -Maximum).Maximum))
            }
        } catch {}

        $script:GpuUsage = $gpu
        (Get-Control "CpuValue").Text = "$cpu%"
        (Get-Control "GpuValue").Text = "$gpu%"
        (Get-Control "RamValue").Text = "$ram%"
        (Get-Control "CpuBar").Value = $cpu
        (Get-Control "GpuBar").Value = $gpu
        (Get-Control "RamBar").Value = $ram
        (Get-Control "MCPU").Value = $cpu
        (Get-Control "MGPU").Value = $gpu
        (Get-Control "MRAM").Value = $ram

        $script:History.Add([double]$cpu)
        if ($script:History.Count -gt 60) {$script:History.RemoveAt(0)}

        $canvas = Get-Control "GraphCanvas"
        $line = Get-Control "CpuGraph"
        $line.Points.Clear()
        $w = [math]::Max(10,$canvas.ActualWidth)
        $h = [math]::Max(10,$canvas.ActualHeight)
        for ($i=0; $i -lt $script:History.Count; $i++) {
            $x = $i * ($w / [math]::Max(1,59))
            $y = $h - (($script:History[$i]/100) * ($h-10)) - 5
            $line.Points.Add([System.Windows.Point]::new($x,$y))
        }
        (Get-Control "ClockText").Text = (Get-Date -Format "HH:mm:ss") + "  •  ONLINE"
    } catch {}
}

function Load-Processes {
    $list = Get-Control "ProcessList"
    $list.Items.Clear()
    Get-Process | Sort-Object ProcessName -Unique | ForEach-Object {
        $item = New-Object System.Windows.Controls.ListBoxItem
        $item.Content = "$($_.ProcessName)   |   PID $($_.Id)"
        $item.Tag = $_.Id
        $list.Items.Add($item) | Out-Null
    }
}

(Get-Control "LoginButton").Add_Click({ Verify-License })
(Get-Control "LicenseInput").Add_KeyDown({
    if ($_.Key -eq "Return") { Verify-License }
})
(Get-Control "NavDashboard").Add_Click({ Set-Page "DashboardPage" })
(Get-Control "NavMonitor").Add_Click({ Set-Page "MonitorPage" })
(Get-Control "NavCleaner").Add_Click({ Set-Page "CleanerPage" })
(Get-Control "NavApps").Add_Click({ Set-Page "AppsPage"; Load-Processes })
(Get-Control "NavBoost").Add_Click({ Set-Page "DashboardPage" })

(Get-Control "BoostButton").Add_Click({
    try {
        if (!(Test-Path $BackupFile)) {
            $active = powercfg /getactivescheme
            if ($active -match '([a-fA-F0-9-]{36})') {
                $Matches[1] | Set-Content $BackupFile
            }
        }
        powercfg /setactive SCHEME_MIN
        $profile = (Get-Control "ProfileBox").Text
        $names = switch -Regex ($profile) {
            "BlueStacks" { @("HD-Player","BlueStacks") ; break }
            "MSI App Player" { @("HD-Player","BstkSVC") ; break }
            "FiveM" { @("FiveM","GTA5") ; break }
            default { @("HD-Player","FiveM","GTA5") }
        }
        foreach ($name in $names) {
            Get-Process -Name $name -ErrorAction SilentlyContinue |
                ForEach-Object { $_.PriorityClass = "High" }
        }
        (Get-Control "BoostStatus").Text = "BOOST APPLIED • POWER PLAN + GAME PRIORITY"
    } catch {
        (Get-Control "BoostStatus").Text = "BOOST ERROR: $($_.Exception.Message)"
    }
})

(Get-Control "RestoreButton").Add_Click({
    if (Test-Path $BackupFile) {
        $guid = (Get-Content $BackupFile -Raw).Trim()
        if ($guid -match '^[a-fA-F0-9-]{36}$') {
            powercfg /setactive $guid
            Remove-Item $BackupFile -Force
            (Get-Control "BoostStatus").Text = "ORIGINAL POWER PLAN RESTORED"
        }
    } else {
        (Get-Control "BoostStatus").Text = "NO POWER PLAN BACKUP FOUND"
    }
})

(Get-Control "CleanButton").Add_Click({
    $answer = [System.Windows.MessageBox]::Show(
        "ลบไฟล์ใน Temp ของผู้ใช้และ Windows Temp ใช่หรือไม่?",
        "SKY FF CLEANER",
        [System.Windows.MessageBoxButton]::YesNo,
        [System.Windows.MessageBoxImage]::Warning
    )
    if ($answer -eq "Yes") {
        $count = 0
        foreach ($folder in @($env:TEMP,"$env:windir\Temp")) {
            if (Test-Path $folder) {
                Get-ChildItem $folder -Force -ErrorAction SilentlyContinue |
                    ForEach-Object {
                        try {
                            Remove-Item $_.FullName -Recurse -Force -ErrorAction Stop
                            $count++
                        } catch {}
                    }
            }
        }
        (Get-Control "CleanStatus").Text = "CLEANED: $count ITEMS • FILES IN USE WERE SKIPPED"
    }
})

(Get-Control "RefreshApps").Add_Click({ Load-Processes })
(Get-Control "StopApp").Add_Click({
    $selected = (Get-Control "ProcessList").SelectedItem
    if (!$selected) { return }
    $id = [int]$selected.Tag
    $p = Get-Process -Id $id -ErrorAction SilentlyContinue
    if (!$p) { return }
    $protected = @("System","Idle","csrss","wininit","services","lsass","smss","winlogon","explorer","dwm")
    if ($protected -contains $p.ProcessName) {
        [System.Windows.MessageBox]::Show("ไม่อนุญาตให้ปิด Process ระบบ")
        return
    }
    $confirm = [System.Windows.MessageBox]::Show(
        "ต้องการปิด $($p.ProcessName) หรือไม่?",
        "Confirm",
        [System.Windows.MessageBoxButton]::YesNo
    )
    if ($confirm -eq "Yes") {
        Stop-Process -Id $id -Force
        Load-Processes
    }
})

$script:Timer = New-Object System.Windows.Threading.DispatcherTimer
$script:Timer.Interval = [TimeSpan]::FromSeconds(2)
$script:Timer.Add_Tick({ Update-Monitor })
$script:Timer.Start()

$script:Window.Add_Closed({
    $script:Timer.Stop()
    $script:CpuCounter.Dispose()
})
$script:Window.ShowDialog() | Out-Null



