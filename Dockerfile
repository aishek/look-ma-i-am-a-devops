FROM ruby:2.5

ENV RAILS_ENV development
ENV RACK_ENV development

RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash && \
    apt-get install -y nodejs libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /app && mkdir -p /app/tmp/pids

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

RUN chmod 700 /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

EXPOSE 8000
CMD ["bundle", "exec", "rackup", "--server", "puma", "--port", "8000", "--host", "0.0.0.0"]
