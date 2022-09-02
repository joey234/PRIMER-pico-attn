DATA_NAME="cochrane"
GLOBAL_ATTENTION_MODE='ent_markers_spans'

TORCH_DISTRIBUTED_DEBUG=DETAIL

# original PRIMER model
MODEL_NAME="PRIMER_cochrane_full_pico_"$GLOBAL_ATTENTION_MODE"_last3"
MODEL_PATH="allenai/PRIMERA"
CKPT_PATH="/root/thinh/PRIMER/checkpoints"
DATA_PATH="/home/yuliao/RCT-summarization-data/"
SAVE_DIR="/root/thinh/PRIMER/full_pico_"$GLOBAL_ATTENTION_MODE"_last3"

#for RAND_SEED in 1111 1234 5555 6789 7362
#do
RAND_SEED=1111


CUDA_VISIBLE_DEVICES=2 python /root/thinh/PRIMER/script/primer_hf_thinh_main.py  \
                --batch_size 8 \
                --gpus 1  \
                --mode test \
                --model_path ../$MODEL_NAME/  \
                --dataset_name ${DATA_NAME} \
                --primer_path ${MODEL_PATH} \
                --resume_ckpt ${SAVE_DIR} \
                --num_workers 0 \
                --progress_bar_refresh_rate 10 \
                --beam_size 1 \
		--max_length_tgt 128 \
                --select_last_k 3

echo "Done"