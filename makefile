#Checkout directory
COD=.
DEST=build
RELEASE=lik-release-1.0.0
USER-DOCS=user-docs
SETUP-DIR=setup-ovpl-centos
SETUP-VERSION=v1.0.2
OVPL-DIR=ovpl
OVPL-VERSION=v1.0.5
UI-DIR=ui-1.0-toolkit
UI-VERSION=v1.0.1

setup-ovpl-centos=https://github.com/vlead/setup-ovpl-centos.git
ovpl=https://github.com/vlead/ovpl.git
ui-toolkit=https://github.com/vlead/ui-1.0-toolkit.git

all: publish create-release

init:
	sed -i 's/https:\/\/github.com\/vlead\/setup-ovpl-centos\/blob\/master\/user-docs\/setup-centos.org/..\/ovpl-kit\/user-docs\/setup-centos.html/' ${USER-DOCS}/index.org
	sed -i 's/https:\/\/github.com\/vlead\/ui-1.0-toolkit\/blob\/master\/user-docs\/index.org/..\/ui-1.0-toolkit\/user-docs\/index.html/' ${USER-DOCS}/index.org
	(rm -rf ${COD}/${DEST}; rm -rf ${COD}/${SETUP-DIR}; \
	rm -rf ${COD}/${OVPL-DIR}; rm -rf ${COD}/${UI-DIR}; \
	rm -rf ${COD}/${RELEASE}; rm -rf ${COD}/${RELEASE}.tar; \
	rm -rf ${COD}/${RELEASE}.tar.gz; \
	mkdir -p ${COD}; mkdir -p ${COD}/${DEST}; \
	mkdir -p ${COD}/${RELEASE}; \
	mkdir -p ${COD}/${DEST}/${USER-DOCS}; \
	mkdir -p ${COD}/${DEST}/ovpl-kit; \
	mkdir -p ${COD}/${DEST}/${UI-DIR})

publish: init
	emacs --script ${COD}/${USER-DOCS}/elisp/publish.el
	(rm -rf ${DEST}/*~; mv ${DEST}/*.html ${DEST}/${USER-DOCS}; \
	mv ${DEST}/org-templates ${DEST}/${USER-DOCS}; \
	mv ${DEST}/style ${DEST}/${USER-DOCS}; \
	mv ${DEST}/img ${DEST}/${USER-DOCS})


create-release: build-setup-ovpl-centos build-ui-toolkit
	rsync -raz --progress ${COD}/${SETUP-DIR}/build/ ${COD}/${DEST}/ovpl-kit
	rsync -raz --progress ${COD}/${OVPL-DIR} ${COD}/${DEST}/ovpl-kit
	rsync -raz --progress ${COD}/${UI-DIR}/build/ ${COD}/${DEST}/${UI-DIR}
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
	(cd ${COD}; git clone ${setup-ovpl-centos}; \
	cd ${SETUP-DIR}; git checkout -b version tags/${SETUP-VERSION})
	sed -i 's/https:\/\/github.com\/vlead\/setup-ovpl-centos\/blob\/master\/user-docs\/setup-centos.org/..\/user-docs\/setup-centos.html/' ${SETUP-DIR}/${USER-DOCS}/how-to-deploy-a-lab.org
	sed -i 's/https:\/\/github.com\/vlead\/ovpl\/blob\/master\/docs\/how-to-deploy-a-lab.org/..\/user-docs\/how-to-deploy-a-lab.html/' ${SETUP-DIR}/${USER-DOCS}/setup-centos.org
co-ovpl:
	(cd ${COD}; git clone ${ovpl}; \
	cd ${OVPL-DIR}; git checkout -b version tags/${OVPL-VERSION})

co-ui-toolkit:
	(cd ${COD}; git clone ${ui-toolkit}; \
	cd ${UI-DIR}; git checkout -b version tags/${UI-VERSION})

