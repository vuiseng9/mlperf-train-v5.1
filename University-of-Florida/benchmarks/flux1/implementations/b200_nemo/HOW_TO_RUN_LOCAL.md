
# Docker Image
```bash
# Note: it is in detach mode
docker run -d --gpus all -it --rm --network=host --ipc=host --shm-size=16g --ulimit memlock=-1 --ulimit stack=67108864 \
    vuiseng9/mlperfv5.1-nvidia-UoF:flux1-pyt
```
or build
```bash
git clone https://github.com/vuiseng9/mlperf-train-v5.1
cd mlperf-train-v5.1 && git checkout 251112-local
cd University-of-Florida/benchmarks/flux1/implementations/b200_nemo
docker build --no-cache -t mlperfv5.1-nvidia-florida:flux1-pyt .
```

# Container runtime
```bash
cd /workspace/flux/
make setup-all

# the setup will prompt interactively for energon prepare step, Y, Y, 11

source flux_training_local.sh
source run_and_time.sh
# Note: the scripts above have been adapted for local single node run 8xb200. MBS has been reduced to 16 from the original 32 to fit in memory.
```

**see git history to find out what have been changed.**