#!/usr/bin/env python3

import os
import json

if __name__ == "__main__":
    print(json.dumps(
        {
            "CLUSTER_NAME": os.getenv('CLUSTER_NAME'),
            "DOCKER_IMAGE": os.getenv('DOCKER_IMAGE'),
            "CONTAINER_NAME": os.getenv('CONTAINER_NAME'),
            "CONTAINER_PORT": os.getenv('CONTAINER_PORT'),
        }
    ))
