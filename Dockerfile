FROM phusion/passenger-ruby22:0.9.15

ENV PACT_BROKER_PORT=80
ENV APP_HOME=/home/app/pact_broker
CMD ["customize_webapp_conf_and_start.sh"]
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD container /

ADD pact_broker/Gemfile $APP_HOME/
ADD pact_broker/Gemfile.lock $APP_HOME/
RUN chown -R app:app $APP_HOME
RUN su app -c "cd $APP_HOME && bundle install --deployment --without='development test'"

ADD pact_broker/ $APP_HOME/
RUN chown -R app:app $APP_HOME
