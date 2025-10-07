ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

WORKDIR /working-env/sysbox

VOLUME [ "/working-env/sysbox/configs" ]

COPY ./main.sh ./main.sh
RUN chmod +x ./main.sh