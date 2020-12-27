# We will use Ubuntu for our image
FROM ubuntu:latest
COPY . /doc/

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2
RUN apt-get -y install sudo

# Additional toys
RUN apt-get -y install vim
RUN apt-get install -y --no-install-recommends apt-utils

# Add user ubuntu with no password, add to sudo group
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`

# Anaconda installing
# NOTE, you will need to update this to the current version if you are from the future. 
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
RUN bash Anaconda3-2020.11-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.11-Linux-x86_64.sh

# Set path to conda
#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all


# RUN conda env update --file doc/home_env.yaml

# # Configuring access to Jupyter
# RUN mkdir /home/ubuntu/notebooks
# RUN jupyter notebook --generate-config --allow-root
# #RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# # Jupyter listens port: 8888
# EXPOSE 8888

# Run Jupytewr notebook as Docker main process
#CMD ["jupyter", "lab", "--allow-root", "--notebook-dir=/home/ubuntu/notebooks", "--ip='*'", "--port=8888", "--no-browser"]