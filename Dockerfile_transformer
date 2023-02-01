FROM huggingface/transformers-pytorch-gpu:latest

RUN rm -r /transformers
RUN pip3 install --no-cache-dir accelerate
RUN pip3 uninstall -y transformers
RUN pip3 install --no-cache-dir git+https://github.com/huggingface/transformers

WORKDIR /workspace/transformers/examples/pytorch/question-answering

CMD ["/bin/bash"]