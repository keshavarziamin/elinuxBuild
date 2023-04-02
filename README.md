**THE PROJECT IS NOT COMPLETE**

# Embedded Linux builder

The Embedded Linux Builder (elinuxbuild) is an open-source project that uses Buildroot to build embedded Linux systems. Currently, the project focuses on making, building, and testing Linux images, packages, and libraries. In future versions, Yocto and manual building will also be supported.

## Milestone
|version|   status  |
|:-----:|:---------:|
| V1.0  |In Progress|
| V1.1  |   Todo    |

## Docker
A [Dockerfile](https://github.com/keshavarziamin/elinuxBuild/blob/main/Dockerfile) is available for easy deployment of elinuxbuild. You can find it on [Docker-Hub](https://hub.docker.com/repository/docker/keshavarziamin/elinuxbuild/general) or in the project repository. 

## License
Elinuxbuild is licensed under the GPL-2.0 license. You can find the full text of the license in the [LICENSE](https://github.com/keshavarziamin/elinuxBuild/blob/main/LICENSE) file.

## Usage
To use elinuxbuild, run the following command:

```
Usage: ./elb.sh [-B|--buildroot <config>] [-c|--config <config>] [menuconfig]
Usage: ./elb.sh [-B|--buildroot] <-C|--clean>
Usage: ./elb.sh [-B|--buildroot] <-l|--list>
Options:
-B, --buildroot   Build the root filesystem
-c, --config      Build the specified configuration
-l, --list        List the supported configurations
-C, --clean       remove all output fiels and images
menuconfig        Show menu configuration
Examples:
./elb.sh --buildroot --config my_config
./elb.sh-B -c my_config menuconfig
./elb.sh -B -l
./elb.sh -B --list
./elb.sh -B --clean
```
