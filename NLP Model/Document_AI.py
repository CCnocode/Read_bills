from google.api_core.client_options import ClientOptions
from google.cloud import documentai_v1 as documentai
import os

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r'flash-asset-358914-3f985ba05d7b.json'

def process_document(project_id: str, location: str,
                     processor_id: str, file_path: str,
                     mime_type: str) -> documentai.Document:
    """
    Processes a document using the Document AI API.
    """

    # Instantiates a client
    opts = ClientOptions(api_endpoint=f"{location}-documentai.googleapis.com")

    client = documentai.DocumentProcessorServiceClient(client_options=opts)

    # The full resource name of the processor, e.g.:
    # projects/project-id/locations/location/processor/processor-id
    # You must create new processors in the Cloud Console first
    resource_name = client.processor_path(
        project_id, location, processor_id)

    # Read the file into memory
    with open(file_path, "rb") as image:
        image_content = image.read()

    # Load Binary Data into Document AI RawDocument Object
    raw_document = documentai.RawDocument(content=image_content, mime_type=mime_type)

    # Configure the process request
    request = documentai.ProcessRequest(name=resource_name, raw_document=raw_document)

    # Use the Document AI client to process the sample form
    result = client.process_document(request=request)

    return result.document


if __name__ == '__main__':
    project_id = 'flash-asset-358914'
    location = 'eu'  # Format is 'us' or 'eu'
    processor_id = '5d5b08924c75a9de'  # Create processor in Cloud Console

    file_path = '../bills/1.pdf'  # The local file in your current working directory
    # Refer to https://cloud.google.com/document-ai/docs/processors-list for the supported file types
    mime_type = 'application/pdf'

    document = process_document(project_id=project_id, location=location,
                                processor_id=processor_id, file_path=file_path,
                                mime_type=mime_type)

    print("Document processing complete.")
    print(document.text)
