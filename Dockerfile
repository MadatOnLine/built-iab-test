# Distributed under the terms of the Modified BSD License.

FROM jupyter/minimal-notebook:177037d09156

LABEL maintainer="Greg Caporaso <gregcaporaso@gmail.com>"

USER root

ENV DISPLAY=:99

RUN apt-get update
RUN apt-get install -y xvfb x11-utils

COPY IAB-notebooks* ${HOME}
# `fix-permissions` ships with jupyter/minimal-notebook
RUN fix-permissions ${HOME}
RUN rm -rf work

USER ${NB_UID}

ENTRYPOINT ["tini", "-g", "--", "xvfb-run"]
RUN conda install python=3.5 pyqt=4
RUN pip install https://github.com/caporaso-lab/An-Introduction-To-Applied-Bioinformatics/archive/master.zip
