# Data-driven-fluid-simulation



After downloading the repo, Install dependencies:
```
  conda create -n tf15 python tensorflow=1.15
  conda activate tf15
  pip install -r requirements.txt
```

Download dataset (e.g. WaterRamps):

    mkdir -p /tmp/datasets
    bash ./download_dataset.sh WaterRamps /tmp/datasets

Train a model:

    mkdir -p /tmp/models
    python -m train \
        --data_path=/tmp/datasets/WaterRamps \
        --model_path=/tmp/models/WaterRamps

Generate some trajectory rollouts on the test set:

    mkdir -p /tmp/rollouts
    python -m train \
        --mode="eval_rollout" \
        --data_path=/tmp/datasets/WaterRamps \
        --model_path=/tmp/models/WaterRamps \
        --output_path=/tmp/rollouts/WaterRamps

Plot a trajectory:

    python -m render_rollout \
        --rollout_path=/tmp/rollouts/WaterRamps/rollout_test_0.pkl


## Datasets

Datasets are available to download via:

* Metadata file with dataset information (sequence length, dimensionality, box bounds, default connectivity radius, statistics for normalization, ...):

  `https://storage.googleapis.com/learning-to-simulate-complex-physics/Datasets/{DATASET_NAME}/metadata.json`

* TFRecords containing data for all trajectories (particle types, positions, global context, ...):

  `https://storage.googleapis.com/learning-to-simulate-complex-physics/Datasets/{DATASET_NAME}/{DATASET_SPLIT}.tfrecord`

Where:

* `{DATASET_SPLIT}` is one of:
  * `train`
  * `valid`
  * `test`

* `{DATASET_NAME}` one of the datasets following the naming used in the paper:
  * `WaterDrop`
  * `Water`
  * `Sand`
  * `Goop`
  * `MultiMaterial`
  * `RandomFloor`
  * `WaterRamps`
  * `SandRamps`
  * `FluidShake`
  * `FluidShakeBox`
  * `Continuous`
  * `WaterDrop-XL`
  * `Water-3D`
  * `Sand-3D`
  * `Goop-3D`

The provided script `./download_dataset.sh` may be used to download all files from each dataset into a folder given its name.

An additional smaller dataset `WaterDropSample`, which includes only the first two trajectories of `WaterDrop` for each split, is provided for debugging purposes.


## Code structure

* `train.py`: Script for training, evaluating and generating rollout trajectories.
* `learned_simulator.py`: Implementation of the learnable one-step model that returns the next position of the particles given inputs. It includes data preprocessing, Euler integration, and a helper method for building normalized training outputs and targets.
* `graph_network.py`: Implementation of the graph network used at the core of the learnable part of the model.
* `render_rollout.py`: Visualization code for displaying rollouts such as the example animation.
* `{noise/connectivity/reading}_utils.py`: Util modules for adding noise to the inputs, computing graph connectivity and reading datasets form TFRecords.
*  `model_demo.py`: example connecting the model to input dummy data.
