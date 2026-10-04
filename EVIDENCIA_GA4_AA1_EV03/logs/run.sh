#!/usr/bin/env bash
# Uso: run.sh <archivo_log> <comando...>
# Ejecuta el comando y registra en el log: marca de tiempo, prompt, comando y salida real (stdout+stderr).
LOG="$1"; shift
{
  echo "### $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "root@cloud-vm:~# $*"
  bash -c "$*" 2>&1
  echo "[codigo de salida: $?]"
  echo
} | tee -a "$LOG"
