#Using the Planner image on my repo to get the base image 
FROM adamfgreen/aip2020:latest
#Copy the input folder into the container and call it input e.g.
# ./input on your computer > /input on the container
COPY ./input /input
#Set the working directory to the input folder
WORKDIR /input

#Run the domain.pddl and problem.pddl in ./input on optic
CMD /bin/optic domain.pddl problem.pddl

#You can also use, /bin/metricff, /bin/fd, /bin/smtplan, /bin/enhsp
# Which are alternative planners

#Also we include /bin/Validate which is VALs validate tool, which lets you validate plans
#Remember that validate works by checking the plan against the domain and problem file

#So you run it like this /bin/Validate domain.pddl problem.pddl plan.txt 

#Also, Validate has a capital V in it
