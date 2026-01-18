FROM nuxeo/nuxeo:2025.x

COPY --chown=nuxeo:0 packages/nuxeo-web-ui.zip /opt/nuxeo/server/local-packages/nuxeo-web-ui.zip
COPY --chown=nuxeo:0 packages/zinox-nse.zip /opt/nuxeo/server/local-packages/zinox-nse.zip


RUN mv /opt/nuxeo/server/templates/common-base/conf/Catalina/localhost/nuxeo.xml.nxftl \
       /opt/nuxeo/server/templates/common-base/conf/Catalina/localhost/edms.xml.nxftl

RUN /install-packages.sh --offline $NUXEO_HOME/local-packages/local-package-nodeps.zip
