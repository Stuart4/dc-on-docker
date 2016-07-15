#!/usr/env python3
import jinja2

HOSTS_FILE = './hosts.template'
HOSTS_FILE_TARGET = './hosts'

COMPOSE_FILE = './docker-compose.yaml.template'
COMPOSE_FILE_TARGET = './utils/docker-compose6.yaml'

NETWORK_FILE = './docker-network.sh.template'
NETWORK_FILE_TARGET = './utils/docker-network6.sh'

SSH_FILE = './host_file.template'
SSH_FILE_TARGET = './host_file'


class Template:
    def __init__(self, env, file, target):
        self.env = env
        self.template = env.get_template(file)
        self.target = target

    def render(self, context):
        with open(self.target, 'w+') as file:
            file.write(self.template.render(context))


def gen_list(fabs, spines, leaves):
    mgmt_port = 10022
    rest_port = 4430
    resp = []
    for k, v in {'fab': fabs, 'spine': spines, 'leaf': leaves}.items():
        for i in range(1, v + 1):
            resp.append({'name': k + str(i), 'mgmt': mgmt_port, 'rest': rest_port})
            mgmt_port += 1000
            rest_port += 1
    return resp


def main():
    try:
        fabs = int(input("Number of fabrics: "))
        spines = int(input("Number of spines: "))
        leaves = int(input("Number of leaves: "))
    except ValueError:
        print("Dirty input...")
        return

    switches = gen_list(fabs=fabs, spines=spines, leaves=leaves)
    print(switches)

    env = jinja2.Environment(loader=jinja2.FileSystemLoader('./'))
    temps = [
        Template(env=env, file=HOSTS_FILE, target=HOSTS_FILE_TARGET),
        Template(env=env, file=COMPOSE_FILE, target=COMPOSE_FILE_TARGET),
        Template(env=env, file=NETWORK_FILE, target=NETWORK_FILE_TARGET),
        Template(env=env, file=SSH_FILE, target=SSH_FILE_TARGET),
    ]
    context = {
        'num_fabs': fabs,
        'num_spines': spines,
        'num_leaves': leaves,
        'switches': switches
    }
    for temp in temps:
        temp.render(context=context)

if __name__ == '__main__':
    main()
