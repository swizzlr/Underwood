FROM swiftdocker/swift:latest

ADD . /code
WORKDIR /code
RUN swift build
