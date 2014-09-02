## update /etc/hosts

```
$ ansible-playbook -i production digitalocean-hosts.yml
```

## update security group (iptables)

```
$ ansible-playbook -i production digitalocean-security.yml
```

## how to add new app host

1. Create droplent using DigitalOceqn UI. (private IP is needed)
2. Edit invenotry file, production to add private IP of the new host
3. update /etc/hosts with the above
4. update security group with the above
5. update iptable on ngix
```
$  ansible-playbook -i production nrp.yml --tags iptables
# make sure that iptables is updated
$ ssh sgnrp2
$ iptables -S
# in case it's not updated. Run below
$ /tmp/iptables.sh
```
6. update ngix config
```
$ ansible-playbook -i production nrp.yml --tags update_config
```

## how to deploy app
```
$ ansible-playbook -i production deploy-app.yml 
```

