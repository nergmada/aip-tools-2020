# AI Planning Coursework tools 2020

Hello and welcome!

You're lucky enough to be on the AIP module at KCL in 2020, which means you've got myself Adam Green as your TA. In this repo you'll find a bunch of tools to get started with planning. This repo is provided as a convenience and is designed to get you up and running and ready to do the coursework, whatever the coursework may be.


*please note* no actual coursework material is contained in this tooling repo, that is to say there are no marks to be found here by completing tasks etc. However, you may be advised or told to use tools and scripts available in this repo to complete your coursework.

## Docker container of Planners

This repo contains a `Dockerfile` which when built will allow you to run a plethora of planners on your very own machine. To get started with docker, you will need to install it on your machine! Please note that I have only provided scripts for `linux ubuntu 20.04`. These scripts will **probably** work on 16.04+, but most likely **will not** work on Mac or Windows.

I cannot provide technical support for either Mac or Windows because I simply do not use either of them anymore. To learn how to execute equivalent docker commands on Windows or Mac please turn to stack overflow and google.


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