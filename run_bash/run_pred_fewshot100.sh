DATA_NAME="wallace"

GLOBAL_ATTENTION_MODE="ent_spans"

# original PRIMER model
MODEL_NAME="PRIMER_wallace_fewshot100_pico_"$GLOBAL_ATTENTION_MODE
MODEL_PATH="allenai/PRIMERA"
CKPT_PATH="/root/thinh/PRIMER/checkpoints/"
DATA_PATH="/home/yuliao/RCT-summarization-data/"

#

#for RAND_SEED in 1111 1234 5555 6789 7362
#do
RAND_SEED=1111
NUM_TRAIN_DATA=100
SAVE_DIR="/root/thinh/PRIMER/fewshot100_pico_"$GLOBAL_ATTENTION_MODE

CUDA_VISIBLE_DEVICES=3 python /root/thinh/PRIMER/script/primer_hf_thinh_main.py  \
                --batch_size 8 \
                --gpus 1  \
                --mode test \
                --model_path ../models/$MODEL_NAME/  \
                --dataset_name ${DATA_NAME} \
                --primer_path ${MODEL_PATH} \
                --resume_ckpt ${SAVE_DIR} \
                --num_workers 0 \
                --progress_bar_refresh_rate 10 \
                --beam_size 1 \
		--max_length_tgt 128

echo "Done"