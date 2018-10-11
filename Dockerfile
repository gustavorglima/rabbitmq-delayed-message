FROM rabbitmq:3.6.15

WORKDIR '/home'

RUN apt-get update \
    && apt-get install python-minimal -y

CMD cp /home/plugins/* /usr/lib/rabbitmq/lib/rabbitmq_server-$RABBITMQ_VERSION/plugins \
    && cp /home/bin/* /bin/ \
    && rabbitmq-plugins enable rabbitmq_management rabbitmq_delayed_message_exchange \
    && rabbitmq-server -detached \
    && sleep 10 \
    && rabbitmqctl add_user admin admin \
    && rabbitmqctl set_user_tags admin administrator \
    && rabbitmqctl set_permissions -p / admin ".*" ".*" ".*" \
    && rabbitmqadmin -H localhost -u admin -p admin -q import config/rabbitmq.json \
    && rabbitmqctl set_permissions -p staging admin ".*" ".*" ".*" \
    && rabbitmqctl stop \
    && sleep 1 \
    && rabbitmq-server