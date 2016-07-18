FROM subzerojake/dogcactus:latest

# Ports to be exposed to the Ansible control machines
EXPOSE 22
EXPOSE 443

# Copy the ssh public key
COPY id_rsa.pub /home/admin/.ssh/authorized_keys
# Copy the networking file
COPY ops-if-netns.sh /home/admin/bin/
RUN chown -R admin:ops_admin /home/admin/.ssh; \
chmod 0700 /home/admin/.ssh; \
chmod 0400 /home/admin/.ssh/authorized_keys; \
chmod 0544 /home/admin/bin/ops-if-netns.sh
