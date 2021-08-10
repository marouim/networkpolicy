from flask import Flask, jsonify, request, Response
import json
import os

app = Flask(__name__)

@app.route("/")
@app.route("/admin")
@app.route("/user")
def home():
  if "HOSTNAME" in os.environ:
    hostname = os.environ["HOSTNAME"]
  else:
    hostname = "undefined"
  
  return jsonify(
    {
      "status": "ok",
      "hostname": hostname
    }
  )

if "LISTEN_PORT" in os.environ:
  port = os.environ["LISTEN_PORT"]
else:
  port = 8080

app.run(host="0.0.0.0", port=port)
