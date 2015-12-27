FROM swiftdocker/swift:latest

WORKDIR /code
ADD Package.swift ./
RUN swift build
ADD Sources/ ./
RUN swift build
