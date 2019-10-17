#!/usr/bin/env bash

export BERT_BASE_DIR=./roberta_zh_l12
export DATA_DIR=./train_data
export TRAINED_CLASSIFIER=./model_files
export MODEL_NAME=roberta-base-zh_law_epoch2

#如果你从现有的模型基础上训练，指定一下BERT_BASE_DIR的路径，并确保bert_config_file和init_checkpoint两个参数的值能对应到相应的文件上。
python run_classifier_serving.py \
  --task_name=sentence_pair \
  --do_train=True \
  --do_eval=True \
  --do_predict=False \
  --data_dir=$DATA_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=8 \
  --learning_rate=2e-5 \
  --num_train_epochs=2.0 \
  --output_dir=$TRAINED_CLASSIFIER/$MODEL_NAME