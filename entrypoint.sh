#!/bin/sh

# replace config default values with those provided via environment variables
for env in `printenv`
do
    if [ "$env" != "${env#DIGILIB_}" ]
    then 
        # split the env variable at the "=" character and
        # save the tokes in $f1 and $f2
        IFS='=' read -r f1 f2 <<EOF 
        $env
EOF
        # turn the key into lower-case and replace underscore with hyphen
        KEY=$(echo ${f1} | cut -c9- | tr '[:upper:]' '[:lower:]' | tr '_' '-')
        VALUE=${f2}
        
        # replace existing default values in digilib-config.xml
        sed -i -e "/name=\"$KEY\"/ s#value=\"[^\"]*\"#value=\"$VALUE\"#" ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml
        
        # add new entries to digilib-config.xml
        if ! grep $KEY -q ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml
        then
            sed -i -e "/<\/digilib-config>/i \ \ <parameter name=\"$KEY\" value=\"$VALUE\"/>" ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml
        fi
    fi
done

# run the command given in the Dockerfile at CMD 
exec /docker-entrypoint.sh "${@}"
