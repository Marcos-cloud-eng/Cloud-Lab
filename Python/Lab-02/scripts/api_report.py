import json
from pathlib import Path
from datetime import datetime

json_file = Path("../data/api_response.json")
report_dir = Path("../data/reports")
report_file = report_dir / "api_report.txt"

report_dir.mkdir(parents=True, exist_ok=True)

try:
    with open(json_file, "r", encoding="utf-8") as file:
        data = json.load(file)

    generated_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    report_lines = []

    report_lines.append("=" * 50)
    report_lines.append("API USER REPORT")
    report_lines.append("=" * 50)
    report_lines.append(f"Generated at: {generated_at}")
    report_lines.append(f"Total users: {len(data)}")
    report_lines.append("")

    for user in data:
        name = user["name"]
        email = user["email"]
        city = user["address"]["city"]
        company = user["company"]["name"]

        report_lines.append(f"Name: {name}")
        report_lines.append(f"Email: {email}")
        report_lines.append(f"City: {city}")
        report_lines.append(f"Company: {company}")
        report_lines.append("-" * 50)

    report = "\n".join(report_lines)

    print(report)

    with open(report_file, "w", encoding="utf-8") as file:
        file.write(report)

    print(f"\nReport saved to: {report_file}")

except FileNotFoundError:
    print(f"JSON file not found: {json_file}")

except json.JSONDecodeError:
    print("Invalid JSON format.")

except Exception as error:
    print(f"Unexpected error: {error}")
