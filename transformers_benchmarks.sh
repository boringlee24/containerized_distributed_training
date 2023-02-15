!#/bin/sh

./exec_benchmark_transformers.sh $1 bert-base-uncased $2 $3 $4 \
./exec_benchmark_transformers.sh $1 xlnet-base-cased $2 $3 $4 \
./exec_benchmark_transformers.sh $1 xlm-mlm-en-2048 $2 $3 $4 \
./exec_benchmark_transformers.sh $1 roberta-base $2 $3 $4 \
./exec_benchmark_transformers.sh $1 distilbert-base-cased $2 $3 $4 
