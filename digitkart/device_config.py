  1 import os
  2 import httpx
  3 
  4 
  5 def get_device_serial():
  6     serial = None
  7     # string to search in file
  8     try:
  9         with open(r'/home/setup/fedge-variables.env', 'r') as fp:
 10             lines = fp.readlines()
 11             for row in lines:
 12                 if row.find("SERIAL_NUMBER") != -1:
 13                     serial = row.split("=")[-1]
 14     except Exception as e:
 15         print(f"Error occured: {e}\nCannot open env file")
 16     return serial.replace("\n", "")
 17 
 18 
 19 def fetch_config(serial_num):
 20     tenant_id, edge_id = None, None
 21     header = {"serial-number": serial_num}
 22     try:
 23         res = httpx.get(dev_config_api, headers=header, timeout=None)
 24         res_json = res.json()
 25         tenant_id = res_json['data']['X_Tenant_id']
 26         edge_id = res_json['data']['kcedgedevice_id']
 28     except Exception as e:
 29         print(f"Error occured: {e}\nAPI failed!")
 30     return tenant_id, edge_id
 31 
 32 
 33 if __name__ == "__main__":
 34     dev_config_api = "https://dev.digitkart.ai/api/frictionless/api/kc/getEdgeDeviceConfig"
 35     tenant_id, edge_id = fetch_config(get_device_serial())
 36     try:
 37         with open("/home/setup/fedge-variables.env", "a") as env_file:
 38             env_file.write(f"TENANT_ID={tenant_id}\n")
 39             env_file.write(f"EDGE_ID={edge_id}\n")
 40             env_file.write(f"TOPIC5={tenant_id}/{edge_id}/start-transaction\n")
 41             env_file.write(f"TOPIC6={tenant_id}/{edge_id}/stop-transaction\n")
 42             env_file.write(f"TRANSACTION_TOPIC={tenant_id}/{edge_id}/start-transaction")
 43     except Exception as e:
 44         print(f"Error occured: {e}\nCannot create env variables.")
