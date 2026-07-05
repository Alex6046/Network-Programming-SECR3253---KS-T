FROM python:3.11-bullseye

WORKDIR /app

RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    sshpass \
    procps \
    util-linux \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir ansible "paramiko==2.12.0"

RUN ansible-galaxy collection install ansible.netcommon
RUN ansible-galaxy collection install cisco.ios

COPY . /app

CMD ["/bin/bash"]
