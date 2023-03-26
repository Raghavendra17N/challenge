from fastapi import FastAPI
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials
from google.cloud import compute_v1
import json


app = FastAPI()
client = compute_v1.InstancesClient()

@app.get("/metadata/{key}")
async def metadata_key_info(key:str):
    project = "charged-muse-376504"
    zone = "us-central1-a"
    vm_name = "ubuntu-vm"
    response = client.get(project=project, zone=zone, instance = vm_name)
    for item in response.metadata.items:
        if item.key == key:
            return item.value

@app.get("/metadata")
async def meatdata_info():
    project = "charged-muse-376504"
    zone = "us-central1-a"
    vm_name = "ubuntu-vm"

    response = client.get(project=project, zone=zone, instance = vm_name)

    metadata_dict = {}
    for item in response.metadata.items:
        metadata_dict[item.key] = item.value

    return metadata_dict
    

