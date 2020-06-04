# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'

# %%
import boto3
from PIL import Image
import requests
from io import BytesIO
import os

os.environ['AWS_DEFAULT_REGION'] = 'eu-west-1'

# %%
def get_response(documentName):
    s3BucketName = 'textract2123'

    textract = boto3.client('textract')
    response = textract.detect_document_text(
        Document={
            'S3Object': {
                'Bucket': s3BucketName,
                'Name': documentName
            }
        })
    return response


# %%
# Print detected text
def evaluate_response(response):
    counter=0
    for item in response["Blocks"]:
        if item["BlockType"] == "LINE":
            counter+=1
            if counter==2:
                line=item["Text"]
                index_doublepoint=line.find(":")
                index_komma=line.find(",")
                pair=line[index_doublepoint+1:index_komma]
                return pair


# %%
def pipeline(link):
    img = requests.get(link).content
    #img_show = Image.open(BytesIO(response.content))
    img_name=link.split("/")[-2]+".png"
    s3.Bucket('textract2123').put_object(Key=img_name, Body=img)
    response=get_response(img_name)
    pair=evaluate_response(response)
    return pair


# %%

session = boto3.Session(
    region_name="eu-west-1",
    aws_access_key_id='AKIAT5LRZETLK5CXF4Y7',
    aws_secret_access_key='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',
)


s3 = session.resource('s3', aws_access_key_id='AKIAT5LRZETLK5CXF4Y7',
    aws_secret_access_key='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',)
client = session.client('textract', aws_access_key_id=',AKIAT5LRZETLK5CXF4Y7',
    aws_secret_access_key='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',)
#print(pipeline("https://www.tradingview.com/x/37K2HpUZ/"))


import flask
from flask import request

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"

@app.route('/getpair', methods=['GET'])
def api_id():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'id' in request.args:
        image_url = request.args['id']
    else:
        return "Error: No id field provided. Please specify an id."
    pair=pipeline(image_url)

    response = flask.jsonify({"pair":pair})
    response.headers.set('Access-Control-Allow-Origin', '*')
    response.headers.set('Access-Control-Allow-Methods', 'GET, POST')
    
    return response

if __name__ == '__main__':
    # This is used when running locally only. When deploying to Google App
    # Engine, a webserver process such as Gunicorn will serve the app. This
    # can be configured by adding an `entrypoint` to app.yaml.
    # Flask's development server will automatically serve static files in
    # the "static" directory. See:
    # http://flask.pocoo.org/docs/1.0/quickstart/#static-files. Once deployed,
    # App Engine itself will serve those files as configured in app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)