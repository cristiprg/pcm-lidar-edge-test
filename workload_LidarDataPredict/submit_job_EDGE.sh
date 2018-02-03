#!/bin/bash

# Don't forget to install/bootstrap AWS EMR with Python packages
# pip install --user scikit-learn
# pip install --user pandas
# pip install --user s3fs

echo "Don't forget to set \
spark.executor.memory            20000M \
spark.executor.cores             8 \
spark.default.parallelism        100 \
spark.executor.instances         5 \
spark.driver.extraJavaOptions    -Xmx10240m \
"

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
        $kNNpicklePath $savedModelPath $doEvaluation

