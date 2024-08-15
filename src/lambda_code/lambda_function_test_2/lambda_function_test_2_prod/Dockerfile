FROM public.ecr.aws/lambda/python:3.10

# Set the label for the Docker image, the author and the creation date.
LABEL maintainer=" João Thomaz Lemos <joaothomaz@2neuron.com> "
LABEL date="2024-05-24"
# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

#Environment variables
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
# Install the specified packages #include --no-cache-dir to avoid caching the package index when the version is final;
RUN pip install --upgrade pip
RUN pip install --quiet -r ${LAMBDA_TASK_ROOT}/requirements.txt 

# #copy my lambda handler
# COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Copy everything inside the app folder
COPY app/ ${LAMBDA_TASK_ROOT}/app/

# Set the CMD to your Lambda handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["lambda_function.handler"]
