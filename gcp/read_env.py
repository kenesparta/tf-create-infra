import os
import json

if __name__ == "__main__":
    print(json.dumps(
        {
            "ID": os.getenv('ID'),
            "GOOGLE_ZONE": os.getenv('GOOGLE_ZONE'),
            "CONTAINER_NAME": os.getenv('CONTAINER_NAME'),
        }
    ))
