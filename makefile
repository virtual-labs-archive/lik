#Checkout directory
COD=.

setup-ovpl-centos=https://github.com/vlead/setup-ovpl-centos.git
ovpl=https://github.com/vlead/ovpl.git

all: co

co:   co-setup-ovpl-centos co-ovpl


co-setup-ovpl-centos:
	(mkdir -p ${COD}; cd ${COD}; git clone ${setup-ovpl-centos})

co-ovpl:
	(mkdir -p ${COD}; cd ${COD}; git clone ${ovpl})
