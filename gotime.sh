#!/bin/bash

cd /vagrant
if [ `docker ps | wc -l` -gt 0 ]; then
	echo here
	ansible-playbook utils/teardown.yaml
fi
docker network ls | awk '{print $1}' | tail -n +2 | xargs docker network rm > /dev/null
ansible-playbook utils/setup.yaml
ansible-playbook --skip-tags=bgp site.yaml
cd -

export no_proxy=${no_proxy},"`seq -s ',' -f '10.11.12.%g' 0 254`"

printf "sudo vtysh\nconfigure terminal\nlldp enable\ninterface 1\nno shutdown\nexit\ninterface 2\nno shutdown\nexit\ninterface 3\nno shutdown\nexit\ninterface 4\nno shutdown\nexit\ninterface 5\nno shutdown\nexit\ninterface 6\nno shutdown\nexit\ninterface 7\nno shutdown\nexit\ninterface 8\nno shutdown\nexit\ninterface 9\nno shutdown\nexit\ninterface 10\nno shutdown\nexit\ninterface 11\nno shutdown\nexit\ninterface 12\nno shutdown\nexit\ninterface 13\nno shutdown\nexit\ninterface 14\nno shutdown\nexit\ninterface 15\nno shutdown\nexit\ninterface 16\nno shutdown\nexit\ninterface 17\nno shutdown\nexit\ninterface 18\nno shutdown\nexit\ninterface 19\nno shutdown\nexit\ninterface 20\nno shutdown\nexit\ninterface 21\nno shutdown\nexit\ninterface 22\nno shutdown\nexit\ninterface 23\nno shutdown\nexit\ninterface 24\nno shutdown\nexit\ninterface 25\nno shutdown\nexit\ninterface 26\nno shutdown\nexit\ninterface 27\nno shutdown\nexit\ninterface 28\nno shutdown\nexit\ninterface 29\nno shutdown\nexit\ninterface 30\nno shutdown\nexit\ninterface 31\nno shutdown\nexit\ninterface 32\nno shutdown\nexit\ninterface 33\nno shutdown\nexit\ninterface 34\nno shutdown\nexit\ninterface 35\nno shutdown\nexit\ninterface 36\nno shutdown\nexit\ninterface 37\nno shutdown\nexit\ninterface 38\nno shutdown\nexit\ninterface 39\nno shutdown\nexit\ninterface 40\nno shutdown\nexit\ninterface 41\nno shutdown\nexit\ninterface 42\nno shutdown\nexit\ninterface 43\nno shutdown\nexit\ninterface 44\nno shutdown\nexit\ninterface 45\nno shutdown\nexit\ninterface 46\nno shutdown\nexit\ninterface 47\nno shutdown\nexit\ninterface 48\nno shutdown\nexit\ninterface 49\nno shutdown\nexit\ninterface 50\nno shutdown\nexit\ninterface 51\nno shutdown\nexit\ninterface 52\nno shutdown\nexit\ninterface 53\nno shutdown\nexit\ninterface 54\nno shutdown\nexit\nexit\nexit\n" | parallel-ssh -h host_file -O StrictHostKeyChecking=no -I

for bridge in /sys/class/net/br-*; do echo 16384 | sudo tee $bridge/bridge/group_fwd_mask; done

rm ~/.ssh/known_hosts
