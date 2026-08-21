import json
from pathlib import Path

json_file = Path("../data/api_response.json")

try:
    with open(json_file, "r", encoding="utf-8") as file:
        data = json.load(file)

    print("\nJSON PARSER")
    print("-" * 40)

    print(f"Total users: {len(data)}")

    print("\nUSERS")
    print("-" * 40)

    for user in data:
        name = user["name"]
        email = user["email"]
        city = user["address"]["city"]

        print(f"Name: {name}")
        print(f"Email: {email}")
        print(f"City: {city}")
        print("-" * 40)

except FileNotFoundError:
    print(f"JSON file not found: {json_file}")

except json.JSONDecodeError:
    print("Invalid JSON format.")

except Exception as error:
    print(f"Unexpected error: {error}")
