import os, io

import export as export
from google.cloud import vision
from google.cloud import vision_v1
from google.cloud.vision_v1 import types

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r'flash-asset-358914-3f985ba05d7b.json'


def text_extract(img_url):
    client = vision.ImageAnnotatorClient()

    # Read the file content
    with io.open(img_url, 'rb') as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    # image.source.Image_uri = img_url

    response = client.text_detection(image=image)

    for text in response.text_annotations:
        print('=' * 30)
        print(text.description)
        vertices = ['(%s,%s)' % (v.x, v.y) for v in text.bounding_poly.vertices]
        print('bounds:', ",".join(vertices))

    return 0


if __name__ == '__main__':
    imgurl = '../image_test/image_0.png'
    text_extract(imgurl)
