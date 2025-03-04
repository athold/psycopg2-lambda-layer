FROM public.ecr.aws/amazonlinux/amazonlinux:2023 AS builder

WORKDIR /app

RUN echo "Building for architecture: $(uname -m)" | tee /dev/stderr

RUN dnf install -y \
    python3 python3-devel gcc gcc-c++ \
    postgresql-libs postgresql-devel zip \
    && dnf clean all

RUN python3 -m ensurepip && python3 -m pip install --upgrade pip
RUN pip3 install aws-psycopg2 -t /app/python/lib/python3.13/site-packages
RUN pip3 install psycopg2-binary -t /app/python/lib/python3.13/site-packages

# Must to rename FILE! _psycopg.so
RUN LATEST_FILE=$(find /app/python/lib/python3.13/site-packages/psycopg2/ -name "_psycopg.*-$(uname -m)-*.so" | sort -V | tail -n 1) && \
    cp "$LATEST_FILE" /app/python/lib/python3.13/site-packages/psycopg2/_psycopg.so

RUN ZIP_NAME="psycopg2-layer-$(uname -m).zip" && \
    cd /app && zip -r9 /app/${ZIP_NAME} python
