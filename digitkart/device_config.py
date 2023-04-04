import os
import httpx


def get_device_serial():
    serial = None
    # string to search in file
    try:
        with open(r'/home/setup/fedge-variables.env', 'r') as fp:
            lines = fp.readlines()
            for row in lines:
                if row.find("SERIAL_NUMBER") != -1:
                    serial = row.split("=")[-1]
    except Exception as e:
        print(f"Error occured: {e}\nCannot open env file")
    return serial.replace("\n", "")


def fetch_config(serial_num):
    tenant_id, edge_id = None, None
    header = {"serial-number": serial_num}
    try:
        res = httpx.get(dev_config_api, headers=header, timeout=None)
        res_json = res.json()
        tenant_id = res_json['data']['X_Tenant_id']
        edge_id = res_json['data']['kcedgedevice_id']
        topic5 = f"{tenant_id}/{edge_id}/start-transaction"
        topic6 = f"{tenant_id}/{edge_id}/stop-transaction"
    except Exception as e:
        print(f"Error occured: {e}\nAPI failed!")
    return tenant_id, edge_id, topic5, topic6


if __name__ == "__main__":
    dev_config_api = "https://dev.digitkart.ai/api/frictionless/api/kc/getEdgeDeviceConfig"
    tenant_id, edge_id, topic5, topic6 = fetch_config(get_device_serial())
    try:
        with open("/home/setup/fedge-variables.env", "a") as env_file:
            env_file.write(f"TENANT_ID={tenant_id}\n")
            env_file.write(f"EDGE_ID={edge_id}\n")
            env_file.write(f"TOPIC5={topic5}\n")
            env_file.write(f"TOPIC6={topic6}\n")
            env_file.write(f"TRANSACTION_TOPIC={topic5}")
    except Exception as e:
        print(f"Error occured: {e}\nCannot create env variables.")
