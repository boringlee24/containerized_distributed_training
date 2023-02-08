FROM imagenet_benchmarks:latest

RUN pip3 install --no-cache-dir geocoder

CMD ["/bin/bash"]