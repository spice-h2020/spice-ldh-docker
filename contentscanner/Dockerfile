FROM python:3
LABEL maintainer="Jason Carvalho https://github.com/JaseMK"
LABEL version="$SCANNER_VERSION"
LABEL description="SPICE LDH Content Scanner."

WORKDIR /contentscanner

RUN git clone https://github.com/spice-h2020/ldh-scanning-framework.git && cd ldh-scanning-framework
WORKDIR /contentscanner/ldh-scanning-framework
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN python -m spacy download en_core_web_sm
COPY . .
#RUN python main.py
CMD ["python", "main.py"]
