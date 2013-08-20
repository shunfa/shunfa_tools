#!/bin/bash

# ./autoCompileHadoop "hadoop-corePath" "jobName" "javaFile"

# steps:
# javac -classpath hadoop-*-core.jar -d MyJavaDir MyCode.java
# jar -cvf MyJar.jar -C Δ MyJavaDir .
function javaCompile(){
    echo "Start Java Compile"
    echo "javac -classpath $hadoopCorePath -d /tmp/hadoopAutoCompile/$jobName $javaFile"
    javac -classpath $hadoopCorePath -d /tmp/hadoopAutoCompile/$jobName $javaFile
}

function pacJar(){
    echo "Start Package Jar File."
    echo "jar -cvf $jobName.jar -C /tmp/hadoopAutoCompile/$jobName ."
    jar -cvf $jobName.jar -C /tmp/hadoopAutoCompile/$jobName .
}

function main(){
    hadoopCorePath=$1
    jobName=$2
    javaFile=$3
    if [ "$3" = "" ];then
      echo "usage: ./autoCompileHadoop hadoop-corePath jobName javaFile" 
      exit 0;
    fi
    if [ ! -f $hadoopCorePath ]; then
        echo "$hadoopCorePath not exist"
        exit 0;
    fi

    if [ ! -f $javaFile ]; then
        echo "$javaFile not exist"
        exit 0;
    fi
     
    if [ ! -d /tmp/hadoopAutoCompile/$jobName ]; then
        mkdir -p /tmp/hadoopAutoCompile/$jobName
    fi
    javaCompile
    pacJar
}

main $1 $2 $3
echo "hello hadoop compile"
