#!/bin/bash

export NEXP=1
export DGXNNODES=${DGXNNODES:-1}

export NCCL_LIB_DIR="/workspace/flux/nccl/build/lib"
export DATAROOT="/root/work/dataset/energon"
export LOGDIR="/root/work/run/results/hpg.dgxb200x8.n${DGXNNODES}/flux1"
mkdir -p "${LOGDIR}"
export CONT="<CONTAINER_PATH>/flux.sif"

# Load appropriate config based on number of nodes
if [ "$DGXNNODES" -eq 2 ]; then
    source $(dirname ${BASH_SOURCE[0]})/config_DGXB200_02x08x32.sh
elif [ "$DGXNNODES" -eq 9 ]; then
    source $(dirname ${BASH_SOURCE[0]})/config_DGXB200_09x08x32.sh
else
    source $(dirname ${BASH_SOURCE[0]})/config_DGXB200_scale.sh
fi

source $(dirname ${BASH_SOURCE[0]})/config_hpg.sh
# sbatch -A rc-rse  -p hpg-b200 --gpus-per-node 8 --reservation=mlperf-training -N $DGXNNODES -t $((60 + $WALLTIME)) flux.sub

export SEED=1205

# following are set in the config_hpg.sh above, no required for single node
unset NCCL_IB_HCA
unset NCCL_SOCKET_IFNAME
unset OMPI_MCA_pml
unset OMPI_MCA_btl

# avoid any IB probing
export NCCL_IB_DISABLE=1

# for debug nccl
# export NCCL_DEBUG=INFO
# export TORCH_DISTRIBUTED_DEBUG=DETAIL

