#/bin/bash
# this script used for replace stop-hbase
# please put this file in folder $HBASE_HOME/bin/

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin">/dev/null; pwd`
 . "$bin"/hbase-config.sh
cd $bin
echo $bin
REG_LIST=$(cat ../conf/regionservers)

    for iplist in $REG_LIST
    do
        hr_pid=$(ssh $iplist "jps" | grep HRegionServer | awk '{print $1}')
	if [ ! $hr_pid == "" ]; then
		echo "kill "$hr_pid
		ssh $iplist "kill -9 $hr_pid 2>/dev/null"
	    fi
	hm_pid=$(ssh $iplist "jps" | grep HMaster | awk '{print $1}')
	if [ ! $hm_pid == "" ]; then
	        echo "HMaster at "$iplist
		echo "kill "$hm_pid 
		ssh $iplist "kill -9 $hm_pid 2>/dev/null"
	    fi
    done
