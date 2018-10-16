FROM rabbitmq:3.6.15
#FROM rabbitmq:3.7.7

WORKDIR '/home'

RUN apt-get update \
    && apt-get install python-minimal -y

CMD cp /home/plugins/delayed_message_exchange-$RABBITMQ_VERSION.ez /usr/lib/rabbitmq/lib/rabbitmq_server-$RABBITMQ_VERSION/plugins \
    && cp /home/bin/* /bin/ \
    && rabbitmq-plugins enable rabbitmq_management rabbitmq_delayed_message_exchange \
    && rabbitmq-server -detached \
    && sleep 10 \
    #&& rabbitmqctl add_user USERNAME PASSWORD \
    #&& rabbitmqctl set_user_tags USERNAME administrator \
    #&& rabbitmqctl set_permissions -p / USERNAME ".*" ".*" ".*" \
    && rabbitmqadmin -H localhost -u guest -p guest -q import config/config-$RABBITMQ_VERSION.json \
    && rabbitmqctl stop \
    && sleep 1 \
    && rabbitmq-server