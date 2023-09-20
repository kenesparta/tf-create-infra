#!/usr/bin/env python3

import os
import json

if __name__ == "__main__":
    print(json.dumps(
        {
            "ID": os.getenv('ID'),
            "DOCKER_IMAGE_NAME": os.getenv('DOCKER_IMAGE_NAME'),
            "DOCKER_IMAGE_TAG": os.getenv('DOCKER_IMAGE_TAG'),
            "CONTAINER_NAME": os.getenv('CONTAINER_NAME'),
            "CONTAINER_PORT": os.getenv('CONTAINER_PORT'),
        }
    ))
