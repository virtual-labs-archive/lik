#Checkout directory
COD=.
DEST=build
RELEASE=lik-release-0.5.0
USER-DOCS=user-docs
SETUP-DIR=setup-ovpl-centos
OVPL-DIR=ovpl
UI-DIR=ui-1.0-toolkit

setup-ovpl-centos=https://github.com/vlead/setup-ovpl-centos.git
ovpl=https://github.com/vlead/ovpl.git
ui-toolkit=https://github.com/vlead/ui-1.0-toolkit.git

all: publish create-release

init: 
	(rm -rf ${COD}/${DEST}; rm -rf ${COD}/${SETUP-DIR}; \
	rm -rf ${COD}/${OVPL-DIR}; rm -rf ${COD}/${UI-DIR}; \
	rm -rf ${COD}/*.tar*; \
	mkdir -p ${COD}; mkdir -p ${COD}/${DEST}; \
	mkdir -p ${COD}/${RELEASE}; \
	mkdir -p ${COD}/${DEST}/${USER-DOCS}; \
	mkdir -p ${COD}/${DEST}/ovpl-kit; \
	mkdir -p ${COD}/${DEST}/ui-kit)

publish: init
	emacs --script ${COD}/${USER-DOCS}/elisp/publish.el
	(rm -rf ${DEST}/*~; mv ${DEST}/*.html ${DEST}/${USER-DOCS}; \
	mv ${DEST}/org-templates ${DEST}/${USER-DOCS}; \
	mv ${DEST}/style ${DEST}/${USER-DOCS})

create-release: build-setup-ovpl-centos build-ui-toolkit
	rsync -raz --progress ${COD}/${SETUP-DIR}/build/ ${COD}/${DEST}/ovpl-kit
	rsync -raz --progress ${COD}/${OVPL-DIR} ${COD}/${DEST}/ovpl-kit
	rsync -raz --progress ${COD}/${UI-DIR}/build/ ${COD}/${DEST}/ui-kit
	(rm -rf ${COD}/${SETUP-DIR}; rm -rf ${COD}/${OVPL-DIR}; \
	rm -rf ${COD}/${UI-DIR})
	(mv ${COD}/${DEST}/* ${COD}/${RELEASE}; rm -rf ${COD}/${DEST})
	(tar -zcvf ${COD}/${RELEASE}.tar.gz ${COD}/${RELEASE}; \
	rm -rf ${COD}/${RELEASE})

build-setup-ovpl-centos: co-setup-ovpl-centos co-ovpl
	cd ${COD}/${SETUP-DIR}; make -k

build-ui-toolkit: co-ui-toolkit
	cd ${COD}/${UI-DIR}; make -k

co-setup-ovpl-centos:
	(cd ${COD}; git clone ${setup-ovpl-centos})

co-ovpl:
	(cd ${COD}; git clone ${ovpl})

co-ui-toolkit:
	(cd ${COD}; git clone ${ui-toolkit})

