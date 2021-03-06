#! /bin/sh

#AUTHOR: Abey Tom

### Introduction 
# This file is used to dynamically inject agent argument to into any spawned JVM. 
# This was initially written for the to instrument the short-lived JVMs that wre spawned by the Hadoop Jobs.

### Deployment 
# Update the JAVA_OPTS with relevant data
# Rename the default java executable to "java_" and save this file as executable[chmod +x] in the PATH
# The last line executes the actual java executable "java_"

### Deployment
# Update the JAVA_OPTS with relevant data
# Rename the default java executable to "java_" and save this file as executable[chmod +x] in the PATH
# The last line executes the actual java executable "java_"
APPD_CONTROLLER=apprenda.saas.appdynamics.com
APPD_PORT=443
APPD_SSL=true
APPD_APPLICATION_NAME=Hadoop
APPD_AGENT=-javaagent:/root/jobs/AppdynamicsHadoop/AppServerAgent/ver4.0.4.0/javaagent.jar

JAVA_OPTS="-Dappdynamics.controller.hostName=$APPD_CONTROLLER -Dappdynamics.controller.port=$APPD_PORT -Dappdynamics.controller.ssl.enabled=false -Dappdynamics.agent.applicationName=$APPD_APPLICATION_NAME $APPD_AGENT "

if [[ $@ == *"YarnChild"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=YarnChild -Dappdynamics.agent.reuse.nodeName=true -Dappdynamics.agent.reuse.nodeName.prefix=YarnChild -Dappdynamics.cron.vm=true $@"
  #JAVA_OPTS="-javaagent:/home/hadoop/debug-agent/debug-agent.jar $@"
elif [[ $@ == *"MRAppMaster"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=MRAppMaster -Dappdynamics.agent.reuse.nodeName=true -Dappdynamics.agent.reuse.nodeName.prefix=MRAppMaster -Dappdynamics.cron.vm=true $@"
  #JAVA_OPTS="-javaagent:/home/hadoop/debug-agent/debug-agent.jar $@"
elif [[ $@ == *"ResourceManager"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=ResourceManager -Dappdynamics.agent.nodeName=ResourceManager $@"
elif [[ $@ == *"NodeManager"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=NodeManager -Dappdynamics.agent.nodeName=NodeManager_Node $@"
elif [[ $@ == *"org.apache.hadoop.hdfs.server.namenode.NameNode"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=NameNode -Dappdynamics.agent.nodeName=PrimaryNameNode $@"
elif [[ $@ == *"SecondaryNameNode"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=NameNode -Dappdynamics.agent.nodeName=SecondaryNameNode $@"
elif [[ $@ == *"DataNode"* ]]
then
  JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=DataNode -Dappdynamics.agent.reuse.nodeName=true -Dappdynamics.agent.reuse.nodeName.prefix=DataNode $@"
else
  JAVA_OPTS="$@"
fi

echo $(date): $JAVA_OPTS >> /tmp/java.log
$JAVA_HOME/bin/java_ $JAVA_OPTS
