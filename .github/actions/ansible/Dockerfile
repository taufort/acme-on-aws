FROM alpine:3.11.6

ENV ANSIBLE_VERSION=2.9.9 \
    ANSIBLE_GROUP_NAME=ansible \
    ANSIBLE_USER_NAME=ansible

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# System wide profile configuration
COPY etc /etc

# Base softwares
RUN apk add git gcc libc-dev libffi-dev openssl-dev python3-dev=3.8.2-r0 && \
    pip3 install --upgrade pip && \
    rm /var/cache/apk/*

# Ansible
WORKDIR /appli/softs
RUN git clone -b v$ANSIBLE_VERSION https://github.com/ansible/ansible.git && \
    pip3 install -r ./ansible/requirements.txt && \
    pip3 install boto boto3 botocore ansible-lint && \
    # https://docs.ansible.com/ansible/latest/reference_appendices/python_3_support.html#on-the-controller-side
    ln -sf python3 /usr/bin/python

# Non-root user
RUN addgroup -S $ANSIBLE_GROUP_NAME && adduser -S $ANSIBLE_USER_NAME -G $ANSIBLE_GROUP_NAME
USER $ANSIBLE_USER_NAME

WORKDIR /home/$ANSIBLE_USER_NAME

ENTRYPOINT ["/docker-entrypoint.sh"]