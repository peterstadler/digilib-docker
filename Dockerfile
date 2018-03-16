FROM jetty:alpine

ENV JETTY_WEBAPPS ${JETTY_BASE}/webapps
ENV DIGILIB_VERSION_URL https://github.com/robcast/digilib/releases/download/release-2.5.5/digilib-webapp-2.5.5-srv3.war

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
