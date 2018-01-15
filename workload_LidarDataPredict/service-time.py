from flask import Flask, request
from flask_restful import Resource, Api
import sys
import time

from subprocess import call
#call(["java", "-version"])

app = Flask(__name__)
api = Api(app)


class TodoSimple(Resource):
    def get(self):
        # 1. TODO Extract data from request (or replace this by TCP)
        # For now, just consider the static data file.

        # 2. Run the Spark application
        # call(["/bin/bash", "./submit_job_AWS.sh"])
        
        return { 'time' : time.strftime("%b %d %Y %H:%M:%S") }

api.add_resource(TodoSimple, '/time')


if __name__ == '__main__':
    if(len(sys.argv) > 1):
        run_port = sys.argv[1]
    else:
        run_port = 10003
    app.run(host='0.0.0.0',port=int(run_port), debug=True)




