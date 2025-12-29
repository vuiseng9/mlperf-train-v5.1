DATASET_ROOT=/root/work/dataset

install-dependencies:
	pip install datasets

make-dirs:
	mkdir -p $(DATASET_ROOT)/energon

# dl-cc12m-train: make-dirs
# 	bash parallel-mlc-r2-downloader.sh -d $(DATASET_ROOT)/cc12m_preprocessed https://training.mlcommons-storage.org/metadata/flux-1-cc12m-preprocessed.uri

dl-tiny-cc12m-train: make-dirs
	git clone https://huggingface.co/datasets/vuiseng9/cc12m_tiny_1024_preprocessed $(DATASET_ROOT)/cc12m_tiny_preprocessed

dl-empty-encodings: make-dirs
	bash parallel-mlc-r2-downloader.sh -d $(DATASET_ROOT)/energon/empty_encodings https://training.mlcommons-storage.org/metadata/flux-1-empty-encodings.uri

dl-coco-2014-val: make-dirs
	bash parallel-mlc-r2-downloader.sh -d $(DATASET_ROOT)/coco_preprocessed https://training.mlcommons-storage.org/metadata/flux-1-coco-preprocessed.uri

# use coco as train set too for fast dataset preparation
# energon-train-wds: make-dirs
# 	python /workspace/flux/scripts/to_webdataset.py --input_path $(DATASET_ROOT)/cc12m_preprocessed --output_path $(DATASET_ROOT)/energon/train --num_workers 8

energon-tiny-train-wds:
	python /workspace/flux/scripts/to_webdataset.py --input_path $(DATASET_ROOT)/cc12m_tiny_preprocessed --output_path $(DATASET_ROOT)/energon/train --num_workers 8 \
	&& rm -rf $(DATASET_ROOT)/cc12m_tiny_preprocessed/

energon-val-wds: make-dirs
	python /workspace/flux/scripts/to_webdataset.py --input_path $(DATASET_ROOT)/coco_preprocessed --output_path $(DATASET_ROOT)/energon/val --num_workers 8
	&& rm -rf $(DATASET_ROOT)/coco_preprocessed/

# this step will prompt multiple times, select Y, Y, 11
energon-prepare:
	cd $(DATASET_ROOT)/energon && energon prepare --split-parts 'train:train/.*' --split-parts 'val:val/.*' ./

setup-all: install-dependencies dl-tiny-cc12m-train dl-coco-2014-val dl-empty-encodings energon-tiny-train-wds energon-val-wds energon-prepare
