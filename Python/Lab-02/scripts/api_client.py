import requests
import json
from pathlib import Path

url = "https://jsonplaceholder.typicode.com/users"

output_file = Path("../data/api_response.json")

try:
    response = requests.get(
        url,
        timeout=10
    )

    print(f"Status Code: {response.status_code}")

    response.raise_for_status()

    data = response.json()

    print(f"Users received: {len(data)}")

    with open(output_file, "w", encoding="utf-8") as file:
        json.dump(
            data,
            file,
            indent=4,
            ensure_ascii=False
        )

    print(f"JSON saved to: {output_file}")

except requests.exceptions.RequestException as error:
    print(f"API request failed: {error}")
