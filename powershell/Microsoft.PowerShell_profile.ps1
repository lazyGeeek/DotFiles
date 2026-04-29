# remote theme file
# other theme name "lambdageneration"
oh-my-posh init pwsh --config 1_shell | Invoke-Expression
# local theme file
# oh-my-posh init pwsh --config "$env:LOCALAPPDATA\oh-my-posh\themes\1_shell.omp.json" | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons
