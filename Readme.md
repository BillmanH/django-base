# Baseline Template for Django Project
For use with other applications.

## To build:
to build the local docker container goes in a couple of steps as the first container takes a long time to install. 
* `docker build -t dsvm:latest .` to build the image (it takes a long time)
    * has ubuntu, vim, anaconda (activated)
    * about 5.02GB, so might not be the best system for embedded IoT systems.
    * `docker build -t {name}:{tag} .` change up the name and tag to manage different versions.  
    * once it is going you can shell into it with `docker run --rm -it dsvm:latest bin/bash`
Then you can install your local version.
* `docker build -f azure/dockerfile -t dsvm:azure .`


# To Operate:

* First you will need to rename the file `TEMPLATE_settings.py` to `settings.py`

```
docker-compose up
```


