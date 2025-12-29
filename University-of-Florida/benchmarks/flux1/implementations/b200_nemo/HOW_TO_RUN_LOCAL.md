
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
make setup-all # this includes tiny data download

# the setup will prompt interactively for energon prepare step, Y, Y, 11

source flux_training_local.sh
source run_and_time.sh
# Note: the scripts above have been adapted for local single node run 8xb200. MBS has been reduced to 16 from the original 32 to fit in memory.
```

**see git history to find out what have been changed.**


<details> 
</summary>

* Results from more organizations available, we only pick those with large range of GPU counts.

* MLCommons reference pretraining for FLUX.1 uses the [TorchTitan](https://github.com/mlcommons/training/tree/master/text_to_image) framework, while most submissions rely on NeMo.

* The model is a customized subclass of MegatronFluxModel, trained in MXFP8 using Transformer Engine.

* Scaling is handled via Megatron DP with distributed optimizer (ZeRO-1), as defined in `flux1_schnell.yaml`.

* We sampled multiple operating points from the plot and inspected the corresponding logs. We confirm that global batch size varies across scales with no gradient accumulation, and that learning rates are adjusted accordingly as you would expect.

* Our local reproduction is based on the University of Florida submission and adapted to run on a single 8×B200 node. This setup is intended for implementation understanding rather than benchmarking. Modifications include using a small CC12M subset for faster iteration (while retaining the full COCO validation set) and disabling IB interface. 
    `code --diff flux_training_scale.sh flux_training_local.sh`

</summary>