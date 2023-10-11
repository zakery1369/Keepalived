# Install Keepalived

#1.Install Required Packages.

sudo apt-get update
sudo apt-get install linux-headers-$(uname -r)

#2.Install Keepalived.

sudo apt-get install keepalived

# Setup Keepalived

#3.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node1.

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

#4.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node2.

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

#5.Now create or edit Keepalived configuration `/etc/keepalived/keepalived.conf` file on Node3.

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

# Firewall Settings

#6.Edit nftables configurations `/etc/nftables.conf` to allow VRRP. Add the following content to the input chain.

ip protocol vrrp accept

#7.Reload nftables.

systemctl reload nftables.service
