FROM ubuntu:14.04
MAINTAINER Piotr Radkowski <piotr.radkowski@uj.edu.pl>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# Install ansible
RUN apt-get update && \
	apt-get install -y software-properties-common && \
	apt-add-repository -y ppa:ansible/ansible && \
	apt-get update && \
	apt-get install -y ansible

# Setup ansible roles
ENV ANSIBLE_HOME /etc/ansible
RUN mkdir -p ${ANSIBLE_HOME}/roles/nuada.dockerize
ADD defaults ${ANSIBLE_HOME}/roles/nuada.dockerize/defaults
ADD handlers ${ANSIBLE_HOME}/roles/nuada.dockerize/handlers
ADD tasks ${ANSIBLE_HOME}/roles/nuada.dockerize/tasks

# Playbook
ADD site.yml ${ANSIBLE_HOME}/site.yml
RUN ansible-playbook ${ANSIBLE_HOME}/site.yml

CMD bash
