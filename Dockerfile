
FROM jupyter/scipy-notebook:latest AS base

RUN pip install --quiet --no-cache-dir \
  'transformers==4.22.2' \
  'shap' \
  'accelerate' \
  'datasets==2.5.1' \
  'sentencepiece' \
  'scipy' \
  'scikit-learn' \
  'protobuf' \
  'evaluate' \
  'wandb' \
  'openai' \
  'sklearn' \
  'openai[embeddings]' \
  'bertopic' \
  && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

FROM base as nb-no-gpu
RUN pip install --quiet --no-cache-dir torch==1.11.0 torchvision==0.12.0 -f https://download.pytorch.org/whl/torch_stable.html && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

FROM base as nb-use-gpu
RUN pip install --quiet --no-cache-dir torch==1.11.0+cu113 torchvision==0.12.0+cu113 -f https://download.pytorch.org/whl/torch_stable.html && \
  fix-permissions "${CONDA_DIR}" && \
  fix-permissions "/home/${NB_USER}"

