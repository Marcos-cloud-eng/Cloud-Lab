from pathlib import Path

log_file = Path("../data/sample_logs.txt")

counts = {
    "INFO": 0,
    "WARNING": 0,
    "ERROR": 0
}

try:
    with open(log_file, "r") as file:

        for line in file:

            if "ERROR" in line:
                counts["ERROR"] += 1

            elif "WARNING" in line:
                counts["WARNING"] += 1

            elif "INFO" in line:
                counts["INFO"] += 1

    print("\nLOG ANALYSIS")
    print("-" * 30)

    for level, total in counts.items():
        print(f"{level}: {total}")

except FileNotFoundError:
    print(f"Log file not found: {log_file}")

except Exception as error:
    print(f"Unexpected error: {error}")
