#!/usr/bin/env python3

import os
import json

if __name__ == "__main__":
    print(json.dumps(
        {
            "ID": os.getenv('ID'),
            "GOOGLE_ZONE": os.getenv('GOOGLE_ZONE'),
        }
    ))
