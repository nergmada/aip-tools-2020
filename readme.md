# AI Planning Coursework tools 2020

Hello and welcome!

You're lucky enough to be on the AIP module at KCL in 2020, which means you've got myself Adam Green as your TA. In this repo you'll find a bunch of tools to get started with planning. This repo is provided as a convenience and is designed to get you up and running and ready to do the coursework, whatever the coursework may be.

*please note* no actual coursework material is contained in this tooling repo, that is to say there are no marks to be found here by completing tasks etc. However, you may be advised or told to use tools and scripts available in this repo to complete your coursework.

## Docker container of Planners

This repo contains two `Dockerfile`s. Unless you are really familiar with Docker you don't need to worry about the main `Dockerfile` instead, focus on `student.Dockerfile`. This guide will only look at `student.Dockerfile`.

### Prerequisites

- [Docker!](https://www.docker.com/)


### How to run planners using the `student.Dockerfile`
Let's quickly go through the `student.Dockerfile` line by line

`FROM adamfgreen/aip2020:latest`

This first line, pulls the latest image of the main Docker image created in `Dockerfile`. This is image is something I've created that automatically builds all the planners and planning tools you need and nearly instantly puts them at your disposal. **You won't need to change this line.**

`COPY . /src`

This tells docker to copy anything in the folder we're currently in `.`, into your container. We do this so that files, such as domains, problems and plans that are outside the container, can be copied into the container. In the folder for this repo, you should place any domains or problem files you wish to run, and any plans you wish to validate.

`WORKDIR /src`

This tells docker to start by running in the `/src` folder. When Docker copies everything in the repo folder into `/src` it doesn't by default start you inside that folder. This command makes it so that when you run any commands inside docker, it'll start in this `/src` folder. You can check this by setting `CMD` to `ls` (the `ls` function lists files on unix). e.g. `CMD ls`

`CMD optic domain.pddl problem.pddl`

This is the most important line, and the only line you'll need to modify. the `CMD` tells docker what to run, when this container is executed. In this case, we are running `domain.pddl` and `problem.pddl` on the planner `optic`.

All available planners and software are listed further down. Simply use the name shown further down to run a different piece of software.

Inside your this repo folder, we assume you've put a domain pddl file called `domain.pddl`. Let's say instead you put a domain called `driverlog.pddl`. You can change `domain.pddl` to `driverlog.pddl` to use the `driverlog.pddl` domain instead e.g.

`CMD optic driverlog.pddl problem.pddl`

or maybe you've added a plan file `plan.txt` into this repo folder, you could validate it by doing

`CMD Validate driverlog.pddl problem.pddl plan.txt`

**When you add domains to the repo folder, you need to run build again**

### Quick steps (You should read the detailed explanation before following this)

1. set `CMD` to be whatever planner you want to execute and whatever domain/problem file you want to run, that is located in `./input`

2. Run `./build.sh` (You need to do this every time you change the contents of `./input` or change `/bin` to target some other program)

3. Run `./run.sh`

4. Run `./stop.sh` if the planner keeps running and you can't stop it

### Advice for Windows and Mac users

You can install Docker on Windows and Mac. The commands located inside `./build,sh`, `./run.sh` and `./stop.sh` will all be available on Windows and Mac too, but the scripts as provided here won't run. Instead, just execute them line by line manually.

Please note that this part of the command `$(cat $(readlink -f VERSION))` just copies whatever the current version number is in the `VERSION` file. You can hard code it instead


### Available Programs in /bin

`/bin/optic` allows you to run OPTIC. OPTIC is a Temporal Numeric planner designed in the early 2010s. It's predecessors POPF and COLIN will most likely be covered in lectures.

`/bin/metricff` allows you to run a flavour of FF called `MetricFF`. This is a classical planner which is a precursor to many modern search strategies.

`/bin/fd` allows you to run `FD` or Fast Downward. This is a classical planner which is the technical and theoretical basis for many if not all modern classical planning systems

`/bin/smtplan` allows you to run `SMTPlan+` a niche planner designed to handle expressive domains modelled in PDDL+ syntax.

`/bin/enhsp` allows you to run `ENHSP` a planner designed to handle expressive domains, particularly those with non-linear continuous numeric effects

`/bin/Validate` allows you to run `VAL`s `Validate` program. Validate is way to check the correctness of plans, independently of planners. Please not that `Validate` has a capital `V`



