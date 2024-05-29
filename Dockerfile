FROM python:3.10.6-buster

ENV APPROOT="/home/app/web" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    VERSION="0.1" 

LABEL base.name="File Sharing API" \
      base.version="${VERSION}"

RUN groupadd -r -g 2200 app && \
    useradd -rM -g app -u 2200 app

WORKDIR $APPROOT

EXPOSE 5000

RUN apt-get update && apt-get install -y \
    --no-install-recommends netcat \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY ./requirements.txt $APPROOT/requirements.txt
RUN pip install -r $APPROOT/requirements.txt

COPY . $APPROOT

# Ensure the uploads directory exists and has the correct permissions
RUN mkdir -p $APPROOT/uploads && chown -R app:app $APPROOT/uploads

RUN chown -R app:app $APPROOT

USER app

ENTRYPOINT ["python", "main.py"]
