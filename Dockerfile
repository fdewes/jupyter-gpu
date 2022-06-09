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
RUN python3 -mvenv env
RUN env/bin/pip install -U pip wheel setuptools
RUN env/bin/pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
RUN env/bin/pip install jupyterlab ipywidgets datasets tqdm transformers bertviz matplotlib seqeval
CMD ["/home/jupyter/env/bin/jupyter-lab","--ip","0.0.0.0"]
