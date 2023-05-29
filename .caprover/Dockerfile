FROM ruby:3.2.2-bullseye

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    \
    vim \
    libpq-dev \
  ; \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt/rails
ADD https://api.github.com/repos/maeda-m/employmate/git/refs/heads/production /version.json
RUN git clone https://github.com/maeda-m/employmate.git \
  --branch production \
  /opt/rails

RUN mv /opt/rails/.caprover/captain-entrypoint.sh /usr/local/bin/captain-entrypoint.sh \
  && chmod +x /usr/local/bin/captain-entrypoint.sh
ENTRYPOINT ["captain-entrypoint.sh"]

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
EXPOSE 3000
CMD [ "bundle", "exec", "puma" ]
