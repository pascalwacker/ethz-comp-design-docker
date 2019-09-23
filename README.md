# (Unofficial) Docker for ETH Compiler Design (Fall 2019)
Note: This is a unofficial Docker image provided as is. It's built using the instruction about the tool chain (https://moodle-app2.let.ethz.ch/mod/page/view.php?id=378843).

## Requirements:
- Docker (https://www.docker.com/)

## Howto:
1) Run `docker run pascalwacker/ethz-comp-design-docker:latest` in your terminal of choice

## Syncing files from your computer to the docker container/saving state:
- Linux/Mac Run ```docker run -v `pwd`:/home/ocaml pascalwacker/ethz-comp-design-docker:latest```
- Windows Run `docker run -v %CD%:/home/ocaml pascalwacker/ethz-comp-design-docker:latest` (untested!)  

Note: You could also create a volume to save the state of the files instead of linking them directly. However to use an IDE on your computer it's recommended to sync the files

## Build it localy
1) Clone (or download) this repo
2) Run `docker build -t what-ever-name-you-would-like .`
3) Run `docker run what-ever-name-you-would-like` (optionally with syncing as described above `-v ...`)

## Access Container


## Note
- You can change `what-ever-name-you-would-like` in the self built docker to what ever you like, just don't use white spaces or fancy special characters and use the same name for line 3 and 4!
- You can of course also map your loacal folder (saving state), to your self built image

## Disclaimer:
This software is provided as is. The are not responsible for any damages on your system or legal actions brought forward against you.
