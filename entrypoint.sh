#!/bin/sh

# add our svn location to the httpd config
cat <<EOF > ${JETTY_WEBAPPS}/ROOT/WEB-INF/digilib-config.xml
<?xml version="1.0" encoding="UTF-8"?>
<digilib-config>
    <!-- A list of directories where images are searched -->
    <parameter name="basedir-list" value="/var/lib/digilib/images" />
    
    <!-- The maximum size of delivered images as pixel area, 40000 means up to 200x200 or 100x400, 0 means no limit. -->
    <parameter name="max-image-size" value="0" />
    
    <!-- The default interpolation quality.
        0: do not use interpolation (worst),
        1: use linear interpolation,
        2: use bilinear interpolation and blur-before-scale (best). -->
    <parameter name="default-quality" value="2" />
    
    <!-- The IIIF API version for the generated info.json information response. -->    
    <parameter name="iiif-api-version" value="2.1" />

    <!-- Enables the Cross-Origin Resource Sharing header in IIIF info requests (Access-Control-Allow-Origin: *).-->    
    <parameter name="iiif-info-cors" value="true" />

    <!-- Enables the Cross-Origin Resource Sharing header in IIIF image requests (Access-Control-Allow-Origin: *).-->    
    <parameter name="iiif-image-cors" value="true" />

    <!-- The prefix (after Scaler) that leads to the IIIF API.-->    
    <parameter name="iiif-prefix" value="IIIF" />

    <!-- The character that replaces a slash in the identifier of IIIF requests. -->
    <parameter name="iiif-slash-replacement" value="!" />
</digilib-config>
EOF

# run the command given in the Dockerfile at CMD 
exec /docker-entrypoint.sh