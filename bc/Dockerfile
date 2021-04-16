FROM python:3.8

LABEL maintainer="Hritvik Patel <hritvik.patel4@gmail.com>"

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN mkdir -p /usr/src/app/logs

RUN apt update \
    && apt install -y git \
    && curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-334.0.0-linux-x86_64.tar.gz > /tmp/gcloud-sdk.tar.gz \
    && mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/gcloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh --quiet

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
COPY <YOUR_JSON_FILE> /tmp
RUN gcloud auth activate-service-account <service-account>@<project-id>.iam.gserviceaccount.com --key-file=/tmp/<YOUR_JSON_FILE> --project=<project-id>
RUN cd /tmp && rm -f <YOUR_JSON_FILE> gcloud-sdk.tar.gz

WORKDIR /usr/src/app

COPY github_key .
RUN eval $(ssh-agent) \
    && ssh-add github_key \
    && ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts \
    && git clone <YOUR_GIT_REPO> \
    && cd eVote && git checkout dev && rm -rf webserver && rm -rf dbserver && rm -f *.sh *.json *.py *.md *.txt \
    && rm -rf Blockchain && rm -rf load_balancer && rm -rf orderer && rm -rf timer && rm -rf eVote-spark \
    && cd bc && pip install -r requirements.txt

RUN rm -f github_key && rm -rf /etc/ssh && rm -rf ~/.ssh
COPY <YOUR_JSON_FILE> /usr/src/app/eVote/bc

EXPOSE 80

CMD ["sh", "-c", "cd eVote/bc && gunicorn --log-level debug bc"]
