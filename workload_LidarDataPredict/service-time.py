from flask import Flask, request
from flask_restful import Resource, Api
import sys
import time
import os
from datetime import datetime

from subprocess import call
#call(["java", "-version"])

app = Flask(__name__)
api = Api(app)

SPARK_DATA_DIR = "./dataDirectory"

nr_crt = 0

class TodoSimple(Resource):

    def get(self):
        # 1. TODO Extract data from request (or replace this by TCP)
        # For now, just consider the static data file.

        # 2. Run the Spark application
        # call(["/bin/bash", "./submit_job_AWS.sh"])

        return { 'time' : time.strftime("%b %d %Y %H:%M:%S") }

    def post(self):
        global nr_crt
        # Create new file with an increasing counter in the end of its name
        nr_crt += 1
        file_name = SPARK_DATA_DIR + "/" + str(nr_crt) + "_predict_this"


        print str(datetime.now()) + ": Received data "
        data = request.data
        with open(file_name, "w") as csv_file:
            csv_file.write(data)

        # Wait until file _SUCCESS is createad and then "cat" the content of part-00000 to the returned json.
        success_file_name = file_name + "-classified/_SUCCESS"
        predicted_file_name = file_name + "-classified/part-00000"
        print str(datetime.now()) + ": Waiting now for Spark Streaming to finish ..."

        # TODO: fail after certain number of tries?
        while not os.path.exists(success_file_name):
            time.sleep(0.05)


        #ret_val = call(["./submit_job_EDGE.sh"])  -- do nothing here, just let Spark Streaming monitor the directory
        print str(datetime.now()) + ": Finished, reading file and sending resposne ..."

        #  TODO: return data
        # if ret_val != 0:
        #     return { 'data' : "Spark ret_val = " + ret_val }
        with open(predicted_file_name, "r") as predicted_file:
             return { 'data' : predicted_file.read() }
        return { 'data': ''}

api.add_resource(TodoSimple, '/time')


if __name__ == '__main__':
    if(len(sys.argv) > 1):
        run_port = sys.argv[1]
    else:
        run_port = 10003
    app.run(host='0.0.0.0',port=int(run_port), debug=True)

