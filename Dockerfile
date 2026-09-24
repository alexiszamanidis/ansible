FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ARG USERNAME=alexzam
ARG USER_ID=1000
ENV USER=${USERNAME}

# Ubuntu's security mirror can advertise a package and then 404 it while the pocket updates.
RUN set -eu; \
    ok=0; \
    for attempt in 1 2 3; do \
        if apt-get update && \
            apt-get install -y --no-install-recommends \
                sudo vim ca-certificates curl git software-properties-common && \
            add-apt-repository -y ppa:ansible/ansible && \
            apt-get update && \
            apt-get install -y ansible; then \
            ok=1; \
            break; \
        fi; \
        echo "apt attempt ${attempt} failed, retrying"; \
        rm -rf /var/lib/apt/lists/*; \
        sleep 15; \
    done; \
    test "$ok" = 1

# ubuntu:24.04 ships an `ubuntu` user at uid 1000; replace it with the test user.
RUN if getent passwd ubuntu >/dev/null; then userdel -r ubuntu || true; fi && \
    if getent group ubuntu >/dev/null; then groupdel ubuntu || true; fi && \
    useradd -m -s /bin/bash -u "${USER_ID}" "${USERNAME}" && \
    mkdir -p /etc/sudoers.d && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}" && \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"

USER ${USERNAME}
WORKDIR /home/${USERNAME}/ansible
CMD ["./install"]
