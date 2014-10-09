#Checkout directory
COD=.
DEST=build
SETUP-DIR=setup-ovpl-centos
OVPL-DIR=ovpl
UI-DIR=ui-1.0-toolkit

setup-ovpl-centos=https://github.com/vlead/setup-ovpl-centos.git
ovpl=https://github.com/vlead/ovpl.git
ui-toolkit=https://github.com/vlead/ui-1.0-toolkit.git

all: init build-setup-ovpl-centos build-ui-toolkit

init: 
	rm -rf ${COD}/${DEST}
	rm -rf ${COD}/${SETUP-DIR}
	rm -rf ${COD}/${OVPL-DIR}
	rm -rf ${COD}/${UI-DIR}
	(mkdir -p ${COD}; mkdir -p ${COD}/${DEST})
	(mkdir -p ${COD}/${DEST}/ovpl-kit)
	(mkdir -p ${COD}/${DEST}/ui-kit)

co:   co-setup-ovpl-centos co-ovpl


co-setup-ovpl-centos:
	(cd ${COD}; git clone ${setup-ovpl-centos})

co-ovpl:
	(cd ${COD}; git clone ${ovpl})

co-ui-toolkit:
	(cd ${COD}; git clone ${ui-toolkit})

build-setup-ovpl-centos: co-setup-ovpl-centos co-ovpl
	cd ${COD}/${SETUP-DIR}; make -k

build-ui-toolkit: co-ui-toolkit
	cd ${COD}/${UI-DIR}; make -k
