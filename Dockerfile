######################################################################
# 1. A python build environment is created, this builds any C->Python
# library code (mainly crypto).

FROM python:3.7-slim AS compile-image
# Install the GCC suite necessary for compiling. See
# <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get>
# regarding best practices with apt.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
 && rm -rf /var/lib/apt/lists/*

# Create a Python virtual environment.
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies.
COPY ./django-app/requirements.txt /usr/src/app/requirements.txt
RUN pip install --upgrade pip \
 && pip install -r /usr/src/app/requirements.txt


######################################################################
# 2. A final image is built from a slim python environment; the python
# source is copied into it, as are the pre-build javascript and python
# libraries.

FROM python:3.7-slim as build-image
WORKDIR /usr/src/app
COPY --from=compile-image /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY django-app /usr/src/app

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]