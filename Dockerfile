# Distributed under the terms of the Modified BSD License.

FROM jupyter/minimal-notebook:177037d09156

LABEL maintainer="Greg Caporaso <gregcaporaso@gmail.com>"

USER root

# From: https://github.com/jupyter/docker-stacks/blob/137a295ff71bcdaf36047e06ba724ab842f866ef/base-notebook/Dockerfile#L32-L33
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV NB_USER=${NB_USER}
ENV NB_UID=${NB_UID}
ENV DISPLAY=:99

RUN apt-get update
RUN apt-get install -y xvfb x11-utils

ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb

COPY IAB-notebooks* ${HOME}
RUN rm -rf work
# `fix-permissions` ships with jupyter/minimal-notebook
RUN fix-permissions ${HOME}

USER ${NB_UID}

RUN /etc/init.d/xvfb start
RUN conda install python=3.5 pyqt=4
RUN pip install https://github.com/caporaso-lab/An-Introduction-To-Applied-Bioinformatics/archive/master.zip
