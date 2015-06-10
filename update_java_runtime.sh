echo "Warning this will update your Java Run Time.  Just make sure you are ready to do it."
cp /usr/lib/jvm/java-1.7.0-openjdk.x86_64/bin/java  /usr/lib/jvm/java-1.7.0-openjdk.x86_64/bin/java_
cp /usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre/bin/java  /usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre/bin/java_

cp  java_hadoop_proxy.sh    /usr/lib/jvm/java-1.7.0-openjdk.x86_64/bin/java
cp  java_hadoop_proxy.sh    /usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre/bin/java  
