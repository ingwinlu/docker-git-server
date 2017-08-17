ARG ALPINE_VER

FROM alpine:${ALPINE_VER}

RUN apk add --no-cache openssh git

RUN apk add --no-cache --virtual config_editing sed \
    && sed -i /etc/ssh/sshd_config -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' \
    && sed -i /etc/ssh/sshd_config -e 's/#AllowAgentForwarding yes/AllowAgentForwarding no/g' \
    && sed -i /etc/ssh/sshd_config -e 's/#AllowTcpForwarding yes/AllowTcpForwarding no/g' \
    && sed -i /etc/ssh/sshd_config -e 's|#HostKey /etc/ssh/|HostKey /git/data/keys/|g' \
    && apk del config_editing

RUN mkdir -p /git/data \
    && mkdir -p /git/data/keys \
    && mkdir -p /git/data/users

WORKDIR /git

COPY skel /etc/skel

COPY add_git_user.sh ./
COPY del_git_user.sh ./
COPY bootstrap.sh ./

RUN touch /var/log/messages


EXPOSE 22
VOLUME /git/data

ENTRYPOINT ["/git/bootstrap.sh"]
