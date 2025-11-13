
# Docker Image
```bash
# Note: it is in detach mode
docker run -d --gpus all -it --rm --network=host --ipc=host --shm-size=16g --ulimit memlock=-1 --ulimit stack=67108864 \
    vuiseng9/mlperfv5.1-nvidia-smci:llama31_8b-pyt
```
or build
```bash
git clone https://github.com/vuiseng9/mlperf-train-v5.1
cd mlperf-train-v5.1 && git checkout 251112-local
docker build --no-cache -t mlperfv5.1-nvidia-smci:llama31_8b-pyt .
```

# Container runtime
```bash
# download tokenizer and setup a tiny c4 dataset
huggingface-cli login
cd /workspace/llm/aux
make all

# run interactively
# llama31_8b on 8xb200 
cd /workspace/llm
source config_SYS-422GS-NBRT-LCC_1x8x2xtp1pp1cp1_8b.sh
bash ./run_and_time.sh

# fp4
cd /workspace/llm
source config_SYS-422GS-NBRT-LCC_1x8x2xtp1pp1cp1_8b_fp4.sh
bash ./run_and_time.sh
```

See log from cublaslt for actual precision used for matmuls
```
export CUBLASLT_LOG_LEVEL=2
export CUBLASLT_LOG_FILE=./log.cublaslt

# fp4, notice R_4F_E2M1
# Adesc=[type=R_4F_E2M1 rows=4096 cols=28672 ld=4096] B=0X7815E2000000 Bdesc=[type=R_4F_E2M1 rows=4096 cols=16384 ld=4096]

# fp8, notice R_8F_E4M3
# Adesc=[type=R_8F_E4M3 rows=4096 cols=6144 ld=4096] B=0X7D9370000000 Bdesc=[type=R_8F_E5M2 rows=6144 cols=16384 ld=6144]
```


**see git history to find out what have been changed.**