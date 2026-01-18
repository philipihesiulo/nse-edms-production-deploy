docker run --name nse-edms \
    -p 8080:8080 \
    -e NUXEO_PACKAGES="/opt/nuxeo/server/local-packages/nuxeo-web-ui.zip /opt/nuxeo/server/local-packages/zinox-nse.zip" \
    zinox/nse-edms


compose -f docker-compose.dev.yml up --build