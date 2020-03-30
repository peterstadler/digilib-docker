# digilib-docker

A docker image for the [Digilib Image Server](https://github.com/robcast/digilib)

## How to run

```
docker run --rm \
    -p 8080:8080 \
    --name digilib \
    -v /your/path/to/images:/var/lib/digilib/images \
    stadlerpeter/digilib-docker
```

### Available parameters

All settings of the  XML file 
[digilib-config.xml](https://github.com/robcast/digilib/blob/master/webapp/src/main/webapp/WEB-INF/digilib-config.xml.template)—which drives the Digilib webapp—can be overridden or set with Docker environment variables. To set a variable, you'll need to prefix its key with "DIGILIB_" and turn it into upper-case while replacing hyphens with underscores. Some examples:

* **DIGILIB_IIIF_PREFIX=IIIF**: The prefix (after Scaler) that leads to the IIIF API
* **DIGILIB_DEFAULT_QUALITY=2**: The default interpolation quality.
        0: do not use interpolation (worst),
        1: use linear interpolation,
        2: use bilinear interpolation and blur-before-scale (best)
* **DIGILIB_MAX_IMAGE_SIZE**: The maximum size of delivered images as pixel area, 40000 means up to 200x200 or 100x400, 0 means no limit
* **DIGILIB_ERROR_IMAGE=https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Dialog-error-round.svg/48px-Dialog-error-round.svg.png**: This image is sent to indicate a general failure.

Further information about these parameters is available at https://robcast.github.io/digilib/digilib-config.html 