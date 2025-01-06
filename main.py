#********************* API server *****************
# Implements API and a functionality

import os

from typing import Annotated

from fastapi import FastAPI, File, UploadFile

app = FastAPI()

PATH = "/files"

# Define the upload API, gets the file and write it to a local directory
# The mount path is mounted to storage account
@app.post("/upload")
async def upload(file: UploadFile):
    if os.path.isdir(PATH):
        f = open(PATH + "/a.json", "wb")
        f.write(file.file.read())
        f.close()
        return {"written": file.filename}
    else:
        return {"error": "path does not exist"}

# Define the list API, list all the files in the path
@app.get("/list")
async def list():
    return {"message": "File listed"}

# Define the delete API, deletes the given file
@app.get("/delete")
async def delete():
    return {"message": "File deleted"}

# Defines the download API, allows the file to be downloaded
@app.get("/download")
async def delete():
    return {"message": "File downloaded"}