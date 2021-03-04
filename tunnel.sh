#!/bin/bash

SSH_KEYFILE=${SSH_KEYFILE:-${HOME}/.ssh/id_rsa}

[ ! -f "${SSH_KEYFILE}" ] && echo "SSH_KEYFILE ${SSH_KEYFILE} MISSING" && exit 10
[ -z "${SSH_USER}" ] && echo "SSH_USER MISSING" && exit 20
[ -z "${SSH_HOST}" ] && echo "SSH_HOST MISSING" && exit 30
[ -z "${SSH_SRC}" ] && echo "SSH_SRC MISSING" && exit 40
[ -z "${SSH_DST}" ] && echo "SSH_DST MISSING" && exit 50

# Get this container IP
CONTAINER_IP=$(awk 'END{print $1}' /etc/hosts)

SSH_OPTS=${SSH_OPTS:-}
SSH_OPTS+=" -4"  # Forces ssh to use IPv4 addresses only.
SSH_OPTS+=" -N"  # Do not execute a remote command. 
                 # This is useful for just forwarding ports (protocol version 2 only).

SSH_OPTS+=" -L ${CONTAINER_IP}:${SSH_SRC}:${SSH_DST}"
                 # [bind_address:]port:host:hostport
                 # Specifies that the given port on the local (client) host is
                 # to be forwarded to the given host and port on the remote side.

echo "SSH_OPTS=${SSH_OPTS}"

echo "Starting tunnel"

ssh -v ${SSH_OPTS} "${SSH_USER}@${SSH_HOST}"

echo "Tunnel ended" 
