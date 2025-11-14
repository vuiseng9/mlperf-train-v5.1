
# Docker Image
```bash
# Note: it is in detach mode
docker run -d -it --network=host --device=/dev/kfd --device=/dev/dri --group-add=video --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --shm-size 8G -v $HOME/dockerx:/dockerx -w /dockerx \
    vuiseng9/mlperfv5.1-amd-llama31_8b
```
or build
```bash
git clone https://github.com/vuiseng9/mlperf-train-v5.1
cd mlperf-train-v5.1 && git checkout 251112-local
cd AMD/benchmarks/llama31_8b/implementations/MI355X_EPYC_9575F_pytorch_llama3_8b/
# take forever
# docker build --no-cache -t mlperfv5.1-amd-llama31_8b .

docker build --no-cache -f Dockerfile.local -t mlperfv5.1-amd-llama31_8b .
```

# Container runtime
```bash
source /opt/venv/bin/activate 

# download tokenizer and setup a tiny c4 dataset
huggingface-cli login
cd /workspace/code/aux
make all

# run interactively
# llama31_8b on 8xMI3.. ... tested on MI300 too
cd /workspace/code/
source config_MI355X_1x8x1_8b.sh  # use appropriate config
bash run_and_time.sh
```

See log from hipblaslt for actual precision used for matmuls
```
export HIPBLASLT_LOG_LEVEL=2
export HIPBLASLT_LOG_FILE=./log.hipblaslt

# fp8, R_8F_E4M3_FNUZ
# Adesc=[type=R_8F_E4M3_FNUZ rows=14336 cols=4096 ld=14336] B=0x77a8f7400000 Bdesc=[type=R_8F_E4M3_FNUZ rows=14336 cols=16384 ld=14336]

# just for comparison, nvidia's
# fp8, notice R_8F_E4M3
# Adesc=[type=R_8F_E4M3 rows=4096 cols=6144 ld=4096] B=0X7D9370000000 Bdesc=[type=R_8F_E5M2 rows=6144 cols=16384 ld=6144]
```

**see git history to find out what have been changed.**