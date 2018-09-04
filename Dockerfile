# Distributed under the terms of the Modified BSD License.

FROM jupyter/minimal-notebook:177037d09156

LABEL maintainer="Greg Caporaso <gregcaporaso@gmail.com>"

USER root

RUN apt-get update
RUN apt-get install -y xvfb

COPY IAB-notebooks* ${HOME}
RUN chown -R ${NB_UID} ${HOME}
RUN rm -rf work

USER ${NB_USER}

RUN conda install python=3.5 pyqt=4
RUN pip install https://github.com/caporaso-lab/An-Introduction-To-Applied-Bioinformatics/archive/master.zip
CMD ["xvfb-run", "start-notebook.sh"]
