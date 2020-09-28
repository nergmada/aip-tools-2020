# AI Planning Coursework tools 2020

Hello and welcome!

You're lucky enough to be on the AIP module at KCL in 2020, which means you've got myself Adam Green as your TA. In this repo you'll find a bunch of tools to get started with planning. This repo is provided as a convenience and is designed to get you up and running and ready to do the coursework, whatever the coursework may be.

*please note* no actual coursework material is contained in this tooling repo, that is to say there are no marks to be found here by completing tasks etc. However, you may be advised or told to use tools and scripts available in this repo to complete your coursework.

## Docker container of Planners

This repo contains a `Dockerfile` which when built will allow you to run a plethora of planners on your very own machine. To get started with [docker](https://www.docker.com/get-started), you will need to install it on your machine! Please note that I have only provided scripts for `linux ubuntu 20.04`. These scripts will **probably** work on 16.04+, but most likely **will not** work on Mac or Windows.

I cannot provide technical support for either Mac or Windows because I simply do not use either of them anymore. To learn how to execute equivalent docker commands on Windows or Mac please turn to stack overflow and google.

## What is docker

Docker is basically a way to run a Virtual Machine as a command line program, whilst having all the software you need on it ready to go. 

Docker thinks of a virtual machine as an `image` an image is essential "this is what the machine should look like" for example it should have these things installed and these programs ready.

When you use an `image` you create a `container`. A `container` is essentially a running version of that image, i.e. All Dell laptops come out the factory the same e.g. they have one `image` but when you start them up and use one, it changes because it's executing programs becoming a `container`. This is the same principle but virtual rather than physical.

We built the docker `image` for you, with all the planning software you need already built by the time you come to start your `container`. However, if you use this 

## Understanding the scripts (Please read carefully, this is for your benefit!)

1. Build the docker image see the `./docker-build.sh` script. This will make an image tagged as `aip:0.1` or whatever the current version number is in the `VERSION` file. Double check the version file, to be sure.

2. Run the docker image see `./shell.sh`. I've copied the docker command I used and explained it below, note that you need to read this understand this if you want to do more advanced and clever things when running the planner

`docker run -v "$PWD:$PWD" -w "$PWD" --name aipdocker -it aip:$(cat $(readlink -f VERSION)) "$@"`

`docker run` - the standard command used to run a built docker image. Imagine a the `aip` docker image we built in step 1 as an imaginary "ubuntu" computer, with all the planning software built and installed when we ran `./docker-build.sh`

`-v "$PWD:$PWD"` - Because a docker container is separate from your computer, you have to tell it what folders you want to allow it to access. $PWD is another way of saying the current directory you're running the script from, for example if you download this folder to your documents and open a command line, `$PWD` will be something like `/home/<your-name>/documents/aip-coursework-tools`. 

This command will essentially link up whatever folder you're in and put it on exactly the same path in the container. Note that on Windows and Mac `$PWD` may not work or may have a different name. 

`-w "$PWD"` - This tells docker than when you run the container, what folder you want to start in. Because in the previous part of the command we told it to copy whatever folder we're currently in and put it in exactly the same place inside the container as it was outside the container, this command says "Okay, now I want you to start the container in this folder". 

Again, similar to the previous part of the command, `$PWD` may or may not work for you on Windows or Mac.

`--name aipdocker` This is to make cleaning up easier later. A name can be pretty much anything you want. We use it so that if the container gets out of control we can open another terminal and type `docker kill aipdocker`

`-it` Basically makes the experience interactive. Most containers aren't designed to run like a command line tool, instead they're designed to run servers and stuff and not really put anything on the command line. `-it` basically tells docker "Actually, whatever I tell you to do, I want to see the results on my CLI".

`aip:$(cat $(readlink -f VERSION))`, this is just a clever way to read whatever version number is in the file `VERSION` and automatically attach it to `aip:`. To be honest, you can hard code this value to whatever number is in the `VERSION` file. Just remember, if you or I change it later, you'll need to change the hard coded copy.

For Mac and Windows users, it's probably easier to hard code this value than find an equivalent command

`"$@"` This is a way just to carry everything you write after `./shell.sh` straight into the end. e.g. if I write `./shell.sh a b c d e` then `"$@"` is `a b c d e` and in the full command it would be 

`docker run -v "$PWD:$PWD" -w "$PWD" --name aipdocker -it aip:$(cat $(readlink -f VERSION)) a b c d e`

The ability to add stuff to the end of this command is pretty much the most important part because you're essentially saying at the start "Hey docker, I want you to link all the files of the folder I'm currently in and have them ready for me when I start this container, then I want you to this command" 

Here's a basic scenario

`docker run -v "$PWD:$PWD" -w "$PWD" --name aipdocker -it aip:$(cat $(readlink -f VERSION)) /bin/optic domain.pddl problem.pddl`

You have a `domain.pddl` file and a `problem.pddl` file contained in the folder you're current in (on the command line). You want to run this domain on the `optic` planner. All planners are located in `/bin` (You can find each planner listed in the individual scripts for each one).

Because OPTIC has a format like `/bin/optic <domain> <problem>` we would write what we wrote above

`docker run -v "$PWD:$PWD" -w "$PWD" --name aipdocker -it aip:$(cat $(readlink -f VERSION))`

Plus, the actual thing we want to run

`/bin/optic domain.pddl problem.pddl`.

### IMPORTANT

in some cases, docker won't stop when you CTRL+C. if this happens, open a new tab and run `./dockerkill.sh` this will shut down any running planner instance. **If you close the window it'll just keep running in the background**

### MetricFF

You can run MetricFF using

`./metricff.sh`

### OPTIC

You can run OPTIC using

`./optic.sh`

### SMTPlan

you can run SMTPlan+ by running

`./smtplan.sh`

### Validate

You can run validators validate program by running

`./validate.sh`