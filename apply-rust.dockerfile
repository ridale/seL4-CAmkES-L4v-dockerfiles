ARG BASE_IMG=trustworthysystems/camkes
FROM $BASE_IMG

LABEL ORGANISATION="Trustworthy Systems"
LABEL MAINTAINER="Luke Mondy (luke.mondy@data61.csiro.au)"

# Get rust nightly
RUN wget -O - https://sh.rustup.rs > /root/rustup.sh \
    && export CARGO_HOME=/opt/cargo \
    && export RUSTUP_HOME=/opt/rustup \
    && sh /root/rustup.sh -y --default-toolchain nightly \
    && /opt/cargo/bin/rustup target add x86_64-rumprun-netbsd \
    && export PATH=/opt/cargo/bin:$PATH \
    && cargo install xargo \
    && rustup default nightly \
    && rustup component add rust-src \
    && rustup update
 

ENV PATH "$PATH:/opt/cargo/bin"
ENV CARGO_HOME "/opt/cargo"
ENV RUSTUP_HOME "/opt/rustup"
