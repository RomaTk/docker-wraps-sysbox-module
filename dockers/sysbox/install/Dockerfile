ARG BASED_ON="ubuntu:latest"
FROM $BASED_ON

ARG VERSION=""
ARG ARCH=""
RUN echo "Using version ${VERSION}"
RUN echo "Using architecture ${ARCH}"

WORKDIR /working-env/sysbox

COPY ./saved-versions/${ARCH}-${VERSION}.deb ./saved-versions/${ARCH}-${VERSION}.deb
COPY ./install.sh ./install.sh

RUN chmod +x ./install.sh
RUN ./install.sh "${VERSION}" "${ARCH}"

RUN rm -rf ./install.sh
RUN rm -rf ./saved-versions
