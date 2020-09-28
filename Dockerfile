#Why not Alpine? Would that I could my dude, would that I could
FROM ubuntu:18.04
#AUTHOR adam.green@kcl.ac.uk

RUN echo '\033[1;35mConfiguring settings for box\033[0m'
RUN apt-get update
RUN apt-get install -y --reinstall software-properties-common
RUN add-apt-repository universe
RUN mkdir /src && cd /src

RUN echo '\033[1;35mInstalling build tools\033[0m'
RUN apt-get update && apt-get -y install flex bison cmake build-essential mercurial python wget git

RUN echo '\033[1;35mBuilding MetricFF\033[0m'
RUN cd /src && wget https://fai.cs.uni-saarland.de/hoffmann/ff/Metric-FF.tgz
RUN cd /src && tar -xvzf Metric-FF.tgz
RUN cd /src/Metric-FF && make ff && mv ff metricff
RUN mv /src/Metric-FF/metricff /bin

RUN echo '\033[1;35mBuilding POPF/OPTIC\033[0m'
RUN cd /src
RUN cd /src && wget https://downloads.sourceforge.net/project/tsgp/OPTIC/optic-patched-for-gcc8.tar.bz2
RUN cd /src && tar -jxf optic-patched-for-gcc8.tar.bz2
RUN cd /src/optic && apt-get update && apt-get install -y doxygen coinor-libcbc-dev coinor-libclp-dev coinor-libcoinutils-dev coinor-libosi-dev coinor-libcgl-dev libgsl-dev zlib1g-dev
RUN cd /src/optic && ./run-cmake-release
RUN cd /src/optic && ./build-release
RUN mv /src/optic/release/optic/optic-clp /bin/optic
	
RUN echo '\033[1;35mBuilding Fast Downward\033[0m'
RUN cd /src && hg clone http://hg.fast-downward.org fd
RUN cd /src/fd && ./build.py
RUN ln -s /src/fd/fast-downward.py /bin/fd

RUN echo '\033[1;35mBuilding SMTPlan+\033[0m'
RUN cd /src && apt-get install -y python-dev libgmp-dev libmpfr-dev libboost-all-dev
RUN cd /src && git clone https://github.com/Z3Prover/z3
RUN cd /src/z3 && python scripts/mk_make.py
RUN cd /src/z3/build && make -j 4
RUN cd /src/z3/build && make install
RUN cd /src && git clone https://github.com/bluescarni/mppp
RUN cd /src/mppp && git checkout tags/v0.9
RUN cd /src/mppp && mkdir build
RUN cd /src/mppp/build
RUN cd /src/mppp/build && cmake ..
RUN cd /src/mppp/build cmake --build . --target install
RUN cd /src && git clone https://github.com/bluescarni/piranha
RUN cd /src/piranha && git checkout 7e42042
RUN cd /src/piranha && mkdir build
RUN cd /src/piranha/build
RUN cd /src/piranha/build && cmake ..
RUN cd /src/piranha/build && make -j 4
RUN cd /src/piranha/build && make install
RUN cd /src && wget https://github.com/KCL-Planning/SMTPlan/tarball/master
RUN cd /src && tar -xvzf master
RUN cd /src && mv KCL-Planning-SMTPlan-*/SMTPlan SMTPlan
RUN cd /src && rm -r KCL-Planning-SMTPlan-*
RUN cd /src/SMTPlan && mkdir build
RUN cd /src/SMTPlan/build && cmake ..
RUN cd /src/SMTPlan/build && make -j 4 SMTPlan
RUN mv /src/SMTPlan/build/SMTPlan /bin/SMTPlan

RUN echo '\033[1;35mBuilding ENHSP\033[0m'
RUN apt-get install -y default-jdk default-jre
RUN cd /src && git clone https://gitlab.com/enricos83/ENHSP-Public.git 
RUN cd /src/ENHSP-Public && ./compile
RUN cd /src/ENHSP-Public && ./install
RUN ln -s /src/ENHSP-Public/enhsp /bin/enhsp

RUN echo '\033[1;35mBuilding VAL\033[0m'
RUN cd /src && git clone https://github.com/KCL-Planning/VAL
RUN cd /src/VAL/scripts/linux && sh build_linux64.sh all Release
RUN cd /src/VAL && mv build/linux64/Release/bin/* /bin
	
RUN echo '\033[1;35mFinished building\033[0m'

CMD "/bin/optic"