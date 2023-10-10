## Keepalived

![Keepalived Debian](https://raw.githubusercontent.com/zakery1369/pics/master/Keepalived.png)

<!--truncate-->

### Install Keepalived

1.Install Required Packages.

```bash
sudo apt-get update
sudo apt-get install linux-headers-$(uname -r)
```

2.Install Keepalived.

```bash
sudo apt-get install keepalived
```

### Setup Keepalived

3.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node1.

```bash
! Configuration File for keepalived
global_defs {
}
vrrp_instance VI_1 {
    state MASTER
    interface ens192
    virtual_router_id 50
    priority 120
    advert_int 1
    virtual_ipaddress {
	192.168.69.200/24
    }
}
```

4.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node2.

```bash
! Configuration File for keepalived
global_defs {
}
vrrp_instance VI_1 {
    state BACKUP
    interface ens192
    virtual_router_id 50
    priority 110
    advert_int 1
    virtual_ipaddress {
	192.168.69.200/24
    }
}
```

5.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node3.

```bash
! Configuration File for keepalived
global_defs {
}

vrrp_instance VI_1 {
    state BACKUP
    interface ens192
    virtual_router_id 50
    priority 100
    advert_int 1
    virtual_ipaddress {
	192.168.69.200/24
    }
}
```

### Firewall Settings

6.Edit nftables configurations `/etc/nftables.conf` to allow VRRP. Add the following content to the input chain.

```bash
ip protocol vrrp accept
```

7.Reload nftables.

```
systemctl reload nftables.service
```
