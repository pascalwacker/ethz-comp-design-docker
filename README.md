# (Unofficial) Docker for ETH Compiler Design (Fall 2019)
Note: This is a unofficial Docker image provided as is. It's built using the instruction provided by the [tool chain](https://moodle-app2.let.ethz.ch/mod/page/view.php?id=378843).

## Requirements:
- [Docker](https://www.docker.com/)

## Howto:
TLDR: See point `Bringing it all together` and just run that command.
1) Run `docker run --rm pascalwacker/ethz-comp-design-docker:latest` in your terminal of choice. Congratulation, you have a container containing both `ocaml` as well as `llvm` running. Currently it probably is rather useless for you. So read on.

### Syncing files from your computer to the docker container/saving state:
- Linux/Mac Run ```docker run --rm -v `pwd`:/home/compDesign pascalwacker/ethz-comp-design-docker:latest```
- Windows Run `docker run --rm -v %CD%:/home/compDesign pascalwacker/ethz-comp-design-docker:latest` (untested!)  
Note: You could also create a volume to save the state of the files instead of linking them directly. However to use an IDE on your computer it's recommended to sync the files

### Accessing the console
- `docker run --rm -it pascalwacker/ethz-comp-design-docker:latest /bin/bash`
You should now have a container with `ocaml` and `llvm` running as well as command line access to it. However the syncing of files is gone. Let's get that back!  
Note: You could also run the container and use `docker exec` to access it, but that would require running `docker ps` first, grabing the uid and so on. Observing the KISS principle we won't do that.

### Bringing it all together
It'll be just one simple command. Trust me!
- Linux/Mac Run ```docker run --rm -v `pwd`:/home/compDesign -it pascalwacker/ethz-comp-design-docker:latest /bin/bash```
- Windows Run `docker run --rm -v %CD%:/home/compDesign -it pascalwacker/ethz-comp-design-docker:latest /bin/bash` (untested!)  
That wasn't to hard, was it? You now have a container running with `ocaml` and `llvm` inside, you're on the commandline inside that container and your local folder (the folder your local terminal was in) is also synced to the container. Awesome, isn't it?

### Automate your testing
I've updated the container on the 27th of September 2019 to include a program called [entr](http://eradman.com/entrproject/). It can be used to run commands if something changes. Ex. for `hw1`, assuming the files are in the current folder in the container, you can use `ls hellocaml.ml providedtests.ml | entr -s 'make && make test'`. If it's in a subfolder, let's say `hw1`, you could run `cd hw1 && ls hellocaml.ml providedtests.ml | entr -s 'make && make test'` (replace `hw1` with whatever you folder is called ;)).  
  
The syntax for the `entr` stuff is: `ls <all files you want to watch, divided by spaces> | entr -s '<commands you want to run on change>'`.  
If you first want to switch to a specific folder, you can use: `cd /home/compDesign/<path> && ls <all files you want to watch, divided by spaces> | entr -s '<commands you want to run on change>'`

#### Start the container with running automatical testing
If you're as lazy as I am, you'll want to do as less as possible. Instead of first starting the container and then run the `entr` stuff, you can start the container and have it directly run the `entr` command.  
Here comes the beauty: ```docker run --rm -v `pwd`:/home/compDesign -it pascalwacker/ethz-comp-design-docker:latest /bin/bash -c "make clean; ls hellocaml.ml providedtests.ml | entr -s 'make && make test'"``` (on Windows, replace ``` `pwd` with %CD%```, still untested, so let me know, if it works for you ;))  
If you're using a subfolder, let's say `hw1`, use: ```docker run --rm -v `pwd`:/home/compDesign -it pascalwacker/ethz-comp-design-docker:latest /bin/bash -c "cd hw1; make clean; ls hellocaml.ml providedtests.ml | entr -s 'make && make test'"```

### Updating the container
It might be, that during the course the need for additional tools inside the container arises. If so I'll update the container. To get this update, simply run `docker pull pascalwacker/ethz-comp-design-docker:latest`. If this didn't solve your problem, let me know, by creating an issue on [GitHub](https://github.com/pascalwacker/ethz-comp-design-docker/issues).

### Debugging and known errors
If there's a permission problem with `main.native`, just delete it and run a `make clear` as well as `make`. If you want it as single command: `rm main.native; make clear; make`.

## Build it localy
1) Clone (or download) this repo
2) Run `docker build -t what-ever-name-you-would-like .`
3) Run `docker run what-ever-name-you-would-like` (optionally with syncing as described above, you know the part about: `-v ...`)

### Note
- You can change `what-ever-name-you-would-like` in the self built docker to what ever you like, just don't use white spaces or fancy special characters and use the same name for line 3 and 4!
- You can of course also map your loacal folder (saving state), to your self built image

## Contributing
If you want to help, feel free! Fork the repo, make your changes and create a pull request. You can find all neccessary files in [this repo](https://github.com/pascalwacker/ethz-comp-design-docker). It's also the fastest way to fix any typos you find ;)

## Disclaimer:
This software is provided as is. The are not responsible for any damages on your system or legal actions brought forward against you.
