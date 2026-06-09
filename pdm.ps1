#!/usr/bin/env pwsh
#requires -version 5

# ============================
#  Inicialización de rutas
# ============================
function Init-Paths {
    $script:BASE_FOLDER   = $PSScriptRoot
    $script:DOCKER_FOLDER = Join-Path $BASE_FOLDER "docker"
}

# ============================
#  Ayuda
# ============================
function Show-Help {
@"
pdm CMD args
    CMD: up down purge help
"@
}

# ============================
#  Ejecutor principal
# ============================
function Run {
    param(
        [string]$Cmd = "empty",
        [string[]]$Args
    )

    Init-Paths

    Set-Location $script:DOCKER_FOLDER

    Write-Host "`e[92mCOMMAND`e[0m   $Cmd"
    Write-Host "`e[92mARGUMENTS`e[0m"
    foreach ($a in $Args) { Write-Host "   $a" }
    Write-Host ""

    switch ($Cmd.ToLower()) {
        "up"    { podman compose up      @Args }
        "down"  { podman compose down    @Args }
        "purge" { podman compose down -v @Args }
        "help"  { Show-Help }
        default {
            Write-Host "ERR: Invalid command '$Cmd'"
            exit 200
        }
    }
}

# ============================
#  Entrada principal
# ============================
Run $args[0] $args[1..($args.Count-1)]
