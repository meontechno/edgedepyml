import os
import httpx

# string to search in file
with open(r'/home/setup/fedge-variables.env', 'r') as fp:
    lines = fp.readlines()
    for row in lines:
        if row.find("SERIAL-NUMBER") != -1:
            serial_num  = row.split("=")[-1]
fp.close()

header = {"serial-number": serial_num}
add_items_resp = httpx.get("https://dev.digitkart.ai/api/frictionless/api/kc/getEdgeDeviceConfig", headers=header, timeout=None)
response_json = add_items_resp.json()
tenant_id = response_json['data']['X_Tenant_id']
edge_id = response_json['data']['kcedgedevice_id']

with open("/home/setup/fedge-variables.env", "a") as env_file:
    env_file.write(f"TENANT_ID={tenant_id}\n")
    env_file.write(f"EDGE_ID={edge_id}\n")
env_file.close()
