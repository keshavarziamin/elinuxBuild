# Embedded Linux builder

The elinuxbuild (Embedded Linux builder) is an open-source project building embedded Linux with [Buildroot](https://github.com/buildroot/buildroot/tree/8cca1e6de1c69a0a5e876116906bb3f6da4a5bd5). **Yocto and the manual building will be added to the project in the next versions.**  The main project's goal is building, making and testing Linux images, libraries, and packages. 

## License
[GPLv2](https://github.com/keshavarziamin/elinuxBuild/blob/main/LICENSE)

## Usage
```
Usage: $0 [-B|--buildroot <config>] [-c|--config <config>] [menuconfig]
Usage: $0 [-B|--buildroot] <-C|--clean>
Usage: $0 [-B|--buildroot] <-l|--list>
Options:
-B, --buildroot   Build the root filesystem
-c, --config      Build the specified configuration
-l, --list        List the supported configurations
-C, --clean       remove all output fiels and images
menuconfig        Show menu configuration
Examples:
$0 --buildroot --config my_config
$0 -B -c my_config menuconfig
$0 -B -l
$0 -B --list
$0 -B --clean
```