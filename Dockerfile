FROM centos:8 as builder
ARG KIBANAVERSION
RUN curl https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANAVERSION}-linux-aarch64.tar.gz -o kibana.tar.gz
RUN tar -xzf kibana.tar.gz && mv kibana-${KIBANAVERSION}-linux-aarch64 kibana

FROM centos:8
RUN useradd --system --no-create-home --user-group kibana
COPY --from=builder --chown=kibana:kibana kibana /usr/share/kibana

USER kibana

WORKDIR /usr/share/kibana

CMD ["bin/kibana", "-e", "-c", "config/kibana.yml"]
