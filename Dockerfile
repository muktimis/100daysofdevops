#use python iamge from docker file
FROM python:3.10-slim
# setting environment variable
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONBUFFERED=1
#SET WORKING DIRECTORY INSIDE THE CONTAINER 
WORKDIR /app
#copying requiremnet file and install dependenices
COPY requirement.txt .

RUN pip install -r requirement.txt
#copying the entire app code into conatainer
COPY . .
#EXPOSING THE PORT APP RUNS ON
EXPOSE 5000
#Command to run on the app
CMD ["python", "app.py"]
