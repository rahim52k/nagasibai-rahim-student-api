#!/usr/bin/env bash
set -u

FULL_NAME="Nagasibai Rahim"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
LOG_FILE="$PROJECT_DIR/logs/Nagasibai_Rahim_system_report.log"

mkdir -p "$PROJECT_DIR/logs"
{
  echo "===== System report ====="
  echo "Student: $FULL_NAME"
  echo "Date/time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "Username: $(whoami)"
  echo "Operating system: $(uname -srm)"
  if [ -r /etc/os-release ]; then
    . /etc/os-release
    echo "OS distribution: ${PRETTY_NAME:-unknown}"
  fi
  echo "Kernel: $(uname -r)"
  echo
  echo "--- CPU ---"
  if command -v lscpu >/dev/null 2>&1; then lscpu; else echo "lscpu not available"; fi
  echo
  echo "--- Memory ---"
  if command -v free >/dev/null 2>&1; then free -h; else echo "free not available"; fi
  echo
  echo "--- Disk usage ---"
  df -h
  echo
  echo "--- Available disk space for project filesystem ---"
  df -h "$PROJECT_DIR"
  echo "===== End report ====="
} | tee "$LOG_FILE"
