#!/bin/bash
#description: BERT fine-tuning

export BERT_BASE_DIR=./roberta_zh_l12
export DATA_DIR=./train_data
export TRAINED_CLASSIFIER=./model_files
export MODEL_NAME=roberta-base-zh_law_epoch1

python run_classifier_serving.py \
  --task_name=sentence_pair \
  --do_train=False \
  --do_eval=False \
  --do_predict=True \
  --data_dir=$DATA_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=2e-5 \
  --num_train_epochs=3.0 \
  --output_dir=$TRAINED_CLASSIFIER/$MODEL_NAME \
  --do_export=True \
  --export_dir=exported