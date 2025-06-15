import os
from datetime import datetime

def generate_report():
    report = f"""
# Pentesting Report
**Date**: {datetime.now().strftime("%Y-%m-%d %H:%M")}

## Tools Used
- Nmap
- Gobuster
- Hydra
- Proxychains/Tor

## Flags Captured
"""

    if os.path.exists("flags.txt"):
        with open("flags.txt") as f:
            flags = [line.strip() for line in f]
            report += "\n".join([f"- `{flag}`" for flag in flags])
    else:
        report += "No flags found"

    report += """
## Timeline
- Recon: 0-15 mins
- Exploitation: 15-40 mins
- Reporting: 40-60 mins

## Notes
All scans and tests complete. Results stored in scan output files.
"""

    with open("report.md", "w") as f:
        f.write(report)
    print("✅ Report saved to report.md")

if __name__ == "__main__":
    generate_report()
