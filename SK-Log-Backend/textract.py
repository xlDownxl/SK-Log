# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'

# %%
import boto3
from PIL import Image
import requests
from io import BytesIO


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

s3 = boto3.resource('s3')
client = boto3.client('textract')
print(pipeline("https://www.tradingview.com/x/37K2HpUZ/"))



# %%