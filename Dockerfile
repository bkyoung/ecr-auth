FROM frolvlad/alpine-glibc
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN apk add --no-cache docker curl groff unzip bash
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    chmod 755 /usr/local/bin/entrypoint.sh
CMD entrypoint.sh