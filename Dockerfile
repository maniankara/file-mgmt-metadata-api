FROM python:3.11

# Transfer the needed files
COPY requirements.txt main.py test_main.py sample.json /

# Install the necessary packages
RUN pip install -r requirements.txt

# Define CMD
CMD fastapi run main.py --port 80