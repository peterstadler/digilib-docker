FROM jetty:alpine

ENV JETTY_WEBAPPS ${JETTY_BASE}/webapps
ENV DIGILIB_VERSION_URL https://github.com/robcast/digilib/releases/download/release-2.6.0/digilib-webapp-2.6.0-srv3p.war
ENV MAX_IMAGE_SIZE ${MAX_IMAGE_SIZE:-0}
ENV DEFAULT_QUALITY ${DEFAULT_QUALITY:-2}
ENV IIIF_PREFIX ${IIIF_PREFIX:-IIIF}

ADD ${DIGILIB_VERSION_URL} tmp.war
ADD entrypoint.sh .

USER root:root
RUN mkdir ${JETTY_WEBAPPS}/ROOT \
    && mkdir -p /var/lib/digilib/images \
    && unzip -q tmp.war -d ${JETTY_WEBAPPS}/ROOT/ \ 
    && rm tmp.war \
    && chmod 755 entrypoint.sh \
    && chown -R jetty:jetty ${JETTY_WEBAPPS}/ROOT

#ADD jetty.xml $JETTY_BASE/etc/jetty.xml

USER jetty:jetty

VOLUME ["/var/lib/digilib/images"]

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]
