FROM petaware/edms:latest

USER 0

RUN dnf -y install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm
RUN dnf -y --enablerepo=ol9_codeready_builder install ffmpeg


# Copy packages and install them

COPY --chown=edms:0 app/dist/packages/web-ui.zip $EDMS_HOME/local-packages/web-ui.zip
COPY --chown=edms:0 app/dist/packages/nse-theme.zip $EDMS_HOME/local-packages/nse-theme.zip
COPY --chown=edms:0 config/nse.conf /etc/edms/conf.d/nse.conf

USER 900

RUN mv $EDMS_HOME/templates/common-base/conf/Catalina/localhost/nuxeo.xml.nxftl \
       $EDMS_HOME/templates/common-base/conf/Catalina/localhost/edms.xml.nxftl

RUN /install-packages.sh --offline $EDMS_HOME/local-packages/web-ui.zip \
       $EDMS_HOME/local-packages/nse-theme.zip
