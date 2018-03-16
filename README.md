# digilib-docker

A docker image for the [Digilib Image Server](https://github.com/robcast/digilib)

## How to run

```
docker run --rm -it \
    -p 8080:8080 \
    --name digilib \
    -v /your/path/to/images:/var/lib/digilib/images \
    stadlerpeter/digilib-docker
```

### available parameters
* **IIIF_PREFIX**: The prefix (after Scaler) that leads to the IIIF API
* **DEFAULT_QUALITY**: The default interpolation quality.
        0: do not use interpolation (worst),
        1: use linear interpolation,
        2: use bilinear interpolation and blur-before-scale (best)
* **MAX_IMAGE_SIZE**: The maximum size of delivered images as pixel area, 40000 means up to 200x200 or 100x400, 0 means no limit

Further information about these parameters is available at https://robcast.github.io/digilib/digilib-config.html 