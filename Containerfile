FROM quay.io/centos/centos:stream9

ARG FOREMAN_VERSION=nightly

RUN dnf upgrade -y && dnf install -y https://yum.theforeman.org/releases/${FOREMAN_VERSION}/el9/x86_64/foreman-release.rpm && dnf install foreman foreman-postgresql foreman-service foreman-redis foreman-dynflow-sidekiq -y

USER foreman
WORKDIR /usr/share/foreman
ENV MALLOC_ARENA_MAX=2
ENV FOREMAN_BIND=0.0.0.0
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_ENV=production
CMD /usr/share/foreman/bin/rails db:migrate && /usr/share/foreman/bin/rails db:seed && /usr/share/foreman/bin/rails server --environment production
EXPOSE 3000/tcp
