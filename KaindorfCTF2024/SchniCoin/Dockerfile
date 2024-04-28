FROM registry.gitlab.tugraz.at/osterm/container_mirror/paradime_ctf_base:latest

ENV HTTP_PORT=8545

COPY requirements.txt /root

RUN python3 -m pip install -r /root/requirements.txt 

RUN true \
    && curl -L https://foundry.paradigm.xyz | bash \
    && bash -c "source /root/.bashrc && foundryup" \
    && chmod 755 -R /root \
    && true

COPY 98-start-gunicorn /startup

COPY eth_sandbox /usr/lib/python/eth_sandbox

ENV PYTHONPATH /usr/lib/python

COPY deploy/ /home/ctf/

COPY dist /tmp/contracts

ENV FLAG=KDCTF{4.0_GpA_1s_eZ}

RUN true \
    && cd /tmp \
    && /root/.foundry/bin/forge build --out /home/ctf/compiled \
    && rm -rf /tmp/contracts \
    && true
