#!/bin/sh 
DEMO="Red Hat JBoss A-MQ, MQTT and Android Demo"
JBOSS_HOME=./target/jboss-a-mq-6.0.0.redhat-024
SERVER_DIR=$JBOSS_HOME/deploy/
SERVER_CONF=$JBOSS_HOME/etc/
LIB_DIR=./support/lib
SRC_DIR=./installs
AMQ=jboss-a-mq-6.0.0.redhat-024.zip
AMQ_REPO=jboss-eap-6.0.1-maven-repository
VERSION=6.0.0


echo
echo "Setting up the ${DEMO} environment..."
echo

# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$AMQ || -L $SRC_DIR/$AMQ ]]; then
		echo A-MQ sources are present...
		echo
else
		echo Need to download $AMQ package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi

# Create the target directory if it does not already exist.
if [ ! -x target ]; then
		echo "  - creating the target directory..."
		echo
		mkdir target
else
		echo "  - detected target directory, moving on..."
		echo
fi

# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $JBOSS_HOME ]; then
		echo "  - existing A-MQ 6 detected..."
		echo
		echo "  - moving existing A-MQ 6 aside..."
		echo
		rm -rf $JBOSS_HOME.OLD
		mv $JBOSS_HOME $JBOSS_HOME.OLD

		# Unzip the JBoss A-MQ instance.
		echo Unpacking A-MQ 6...
		echo
		unzip -q -d target $SRC_DIR/$AMQ
else
		# Unzip the JBoss A-MQ instance.
		echo Unpacking new A-MQ 6...
		echo
		unzip -q -d target $SRC_DIR/$AMQ
fi

echo "Copy activemq.xml"
cp support/activemq.xml target/jboss-a-mq-6.0.0.redhat-024/etc/activemq.xml


echo "A-MQ ${VERSION} - ${DEMO} Setup Complete."
echo
