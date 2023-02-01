import yaml
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--num_gpu', type=int, help='number of GPUs to specify', default=8)
args = parser.parse_args()

with open('/home/ubuntu/.cache/huggingface/accelerate/default_config.yaml') as f:
    read = yaml.safe_load(f)
    read['num_processes'] = args.num_gpu

with open('/home/ubuntu/.cache/huggingface/accelerate/default_config.yaml', 'w') as f:
    yaml.dump(read, f)
