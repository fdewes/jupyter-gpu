FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04 

EXPOSE 8888

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Etc/UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get -y upgrade 

RUN apt-get install -y git \
		       	git-lfs \
			python3 \
			python3-dev \
			python3-pip \
			python3-venv 

RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter

RUN git clone https://github.com/nlp-with-transformers/notebooks
RUN mkdir env
RUN python3 -mvenv ./env
RUN /home/jupyter/env/pip install -U pip wheel setuptools
RUN /home/jupyter/env/pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
RUN /home/jupyter/env/pip install jupyterlab ipywidgets datasets tqdm transformers bertviz matplotlib
#CMD rstudio-server start && sleep infinity
