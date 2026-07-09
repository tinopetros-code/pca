Ping from anywhere, including any of the VMs e.g. mynet-us-vm, to any of the VMs by external IP should work:
```bash
ping -c 3 <Enter mynet-notus-vm's external IP here>
```

Ping from `mynet-us-vm` to `private-us-vm` will not work via internal IP but will work for `mynet-notus-vm` because they are in the same VPC even though they are in separate subnets

Ping via internal IP from `fake-appliance-vm` to `managementnet-us-vm` and `private-us-vm` will not work but it will work from `appliance-vm` instead thanks to the network interfaces connecting us to those networks