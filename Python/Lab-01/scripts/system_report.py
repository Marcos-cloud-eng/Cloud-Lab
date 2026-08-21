import os
import platform
import shutil
from datetime import datetime
from pathlib import Path

# ==========================================
# SYSTEM REPORT
# ==========================================

now = datetime.now()

# Informações do sistema
hostname = platform.node()
user = os.getenv("USER")
operating_system = platform.system()
os_release = platform.release()
architecture = platform.machine()

# Uso do disco
disk = shutil.disk_usage("/")

total_gb = disk.total / (1024 ** 3)
used_gb = disk.used / (1024 ** 3)
free_gb = disk.free / (1024 ** 3)

# Monta o relatório
report = f"""
========================================
LINUX SYSTEM REPORT
========================================
Generated: {now.strftime('%Y-%m-%d %H:%M:%S')}
Hostname: {hostname}
User: {user}
OS: {operating_system}
Kernel: {os_release}
Architecture: {architecture}

DISK USAGE
----------------------------------------
Total: {total_gb:.2f} GB
Used:  {used_gb:.2f} GB
Free:  {free_gb:.2f} GB
========================================
"""

# Mostra no terminal
print(report)

# Diretório de saída
output_dir = Path("../data/reports")
output_dir.mkdir(parents=True, exist_ok=True)

# Nome do relatório
report_file = output_dir / "system_report.txt"

# Salva o relatório
with open(report_file, "w") as file:
    file.write(report)

print(f"Report saved to: {report_file}")
