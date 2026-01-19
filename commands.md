docker run --name nse-edms \
    -p 8080:8080 \
    -e NUXEO_PACKAGES="/opt/nuxeo/server/local-packages/nuxeo-web-ui.zip /opt/nuxeo/server/local-packages/zinox-nse.zip" \
    zinox/nse-edms


docker compose -f docker-compose.dev.yml up --build

docker run --name nse-edms -p 8080:8080 zinoxtech/nse_edms:v2