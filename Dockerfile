# Fusion detection DockerFile using STAR-Fusion and FusionInspector software
# https://github.com/STAR-Fusion/STAR-Fusion/wiki
# https://github.com/FusionInspector/FusionInspector

FROM ubuntu:16.04
FROM rocker/r-ver:3.4.4

MAINTAINER Jacob Pfeil, jpfeil@ucsc.edu

# Update and install required software
RUN apt-get update --fix-missing

RUN apt-get install -y wget git bzip2 build-essential software-properties-common libxml2-dev libcurl4-openssl-dev

WORKDIR /opt

RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda

ENV PATH=/root/miniconda/bin:$PATH

RUN conda update -y conda

RUN conda install -y numpy pandas

# Add wrapper scripts
COPY pipeline /opt/pipeline

RUN Rscript /opt/pipeline/lib/install.R

# Data processing occurs at /data
WORKDIR /data

ENTRYPOINT ["python"]
CMD ["-h"]
