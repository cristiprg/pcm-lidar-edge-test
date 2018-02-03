#!/bin/bash

# ["/app/spark-1.6.3-bin-hadoop2.6/bin/run-example", "streaming.NetworkWordCount", "localhost", "9999"]


# Start Spark Streaming
SPARK_DATA_DIR="./dataDirectory"
mkdir -p $SPARK_DATA_DIR
#./submit_job_EDGE.sh &
SPARK_HOME='/app/spark-1.6.3-bin-hadoop2.6/bin'
dataDirectory="./dataDirectory"
jarPath="./ml.jar"
batchSize=200000
queryKNNScriptPath="./queryKNN.py"
buildKNNObjectScriptPath="./buildKNNObject.py"
buildPickles="1"
kNNpicklePath="."
savedModelPath="./bildstein1.irfmodel"
doEvaluation=0

# Predict stream
 $SPARK_HOME/spark-submit --master local[2] --class de.tu_berlin.dima.StreamingLidarClassification \
         --conf spark.default.parallelism=2 \
         $jarPath $dataDirectory \
         $batchSize $queryKNNScriptPath $buildKNNObjectScriptPath $buildPickles \
         $kNNpicklePath $savedModelPath $doEvaluation &

#$SPARK_HOME/run-example streaming.NetworkWordCount localhost 9999



# Start python server
python ./service-time.py
