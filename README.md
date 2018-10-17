# Docker - Rabbit MQ with Delayed Message Exchange
## Run Docker
* `export VBOXNET_RMQ_DELAYED_MESSAGE=$(vboxmanage hostonlyif create | awk -F"'" '{print $2}')` (only run once)
* `vboxmanage hostonlyif ipconfig $VBOXNET_RMQ_DELAYED_MESSAGE --ip 192.168.5.1`
* `docker-compose up -d`

## Login
* http://192.168.5.1:15672
* User: admin
* Pass: admin
