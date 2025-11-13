#!/bin/bash
# Usage: ./collect_resources.sh <output-json-file>
# Example: ./collect_resources.sh ../outputs/resources_metadata.json

OUTPUT_FILE=$1

if [[ -z "$OUTPUT_FILE" ]]; then
    echo "Usage: $0 <bicep-output-json-file>"
    exit 1
fi

if [[ ! -f "$OUTPUT_FILE" ]]; then
    echo "File $OUTPUT_FILE does not exist."
    exit 1
fi

echo "Collecting resource information from $OUTPUT_FILE..."

VM_ID=$(jq -r '.properties.outputs.vmId.value' $OUTPUT_FILE)
PUBLIC_IP=$(jq -r '.properties.outputs.vmPublicIP.value' $OUTPUT_FILE)
NIC_ID=$(jq -r '.properties.outputs.nicId.value' $OUTPUT_FILE)
SUBNET_ID=$(jq -r '.properties.outputs.subnetId.value' $OUTPUT_FILE)

echo "VM ID: $VM_ID"
echo "Public IP: $PUBLIC_IP"
echo "NIC ID: $NIC_ID"
echo "Subnet ID: $SUBNET_ID"

# Optional: save to a separate file for downstream scripts
echo "$VM_ID,$PUBLIC_IP,$NIC_ID,$SUBNET_ID" > ../outputs/resource_list.csv

echo "Resource collection complete."
