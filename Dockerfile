FROM phusion/passenger-ruby21

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down
RUN rm /etc/ngxin/sites-enables/default
ADD nginx/conf /etc/nginx/sites-enables/json_api.conf

ADD . /home/app/json_api
WORKDIR /home/app/json_api
RUN chwon -R app:app /home/app/json_api
RUN sudo -u app bundle install --deployment

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
