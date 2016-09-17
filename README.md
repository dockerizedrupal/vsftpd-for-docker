# vsftpd-for-docker

A Docker image for [vsftpd](https://security.appspot.com/vsftpd.html).

## Run the container

    CONTAINER="vsftpd" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 20:20 \
      -p 21:21 \
      -p 50000-50002:50000-50002 \
      -e SERVER_NAME="localhost" \
      -e TIMEZONE="Etc/UTC" \
      -e VSFTPD_1_USERNAME="" \
      -e VSFTPD_1_PASSWORD="" \
      -e VSFTPD_1_HOME="" \
      -e VSFTPD_1_USER_ID="1000" \
      -e VSFTPD_1_GROUP_ID="1000" \
      -d \
      dockerizedrupal/vsftpd:2.0.0

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/vsftpd-for-docker.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 2.0.0 \
      && sudo docker build -t dockerizedrupal/vsftpd:2.0.0 . \
      && cd -

## License

**MIT**
