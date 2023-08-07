FROM jetty:9-jre11-eclipse-temurin

ARG DIGILIB_VERSION_URL="https://github.com/robcast/digilib/releases/download/release-2.12.3/digilib-webapp-2.12.3.war"

ENV JETTY_WEBAPPS ${JETTY_BASE}/webapps

# set default location for images inside the Docker container
ENV DIGILIB_BASEDIR_LIST="/var/lib/digilib/images"

# add default IIIF options  
ENV DIGILIB_IIIF_API_VERSION="2.1"
ENV DIGILIB_IIIF_INFO_CORS="true"
ENV DIGILIB_IIIF_IMAGE_CORS="true"
ENV DIGILIB_IIIF_PREFIX="IIIF"
ENV DIGILIB_IIIF_SLASH_REPLACEMENT="!"

ADD ${DIGILIB_VERSION_URL} tmp.war
ADD entrypoint.sh .

USER root:root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends unzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${JETTY_WEBAPPS}/ROOT \
    && mkdir -p /var/lib/digilib/images \
    && unzip -q tmp.war -d ${JETTY_WEBAPPS}/ROOT/ \
    && cp ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml.template ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml \ 
    && rm tmp.war \
    && chmod 755 entrypoint.sh \
    && chown -R jetty:jetty ${JETTY_WEBAPPS}/ROOT

#ADD jetty.xml $JETTY_BASE/etc/jetty.xml

USER jetty:jetty

VOLUME ["/var/lib/digilib/images"]

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
