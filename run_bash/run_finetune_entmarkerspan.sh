DATA_NAME="wallace"
GLOBAL_ATTENTION_MODE='ent_markers_spans'

TORCH_DISTRIBUTED_DEBUG=DETAIL

# original PRIMER model
MODEL_NAME="PRIMER_wallace_full_pico_"$GLOBAL_ATTENTION_MODE"_last3"
MODEL_PATH="allenai/PRIMERA"
CKPT_PATH="/root/thinh/PRIMER/checkpoints"
DATA_PATH="/home/yuliao/RCT-summarization-data/"
SAVE_DIR="/root/thinh/PRIMER/full_pico_"$GLOBAL_ATTENTION_MODE"_last3"

RAND_SEED=1111

CUDA_VISIBLE_DEVICES=1 python /root/thinh/PRIMER/script/primer_hf_thinh_main.py  \
                --gpus 1 \
		        --accelerator dp \
                --mode train \
                --lr 3e-5 \
                --label_smoothing 0.1 \
                --accum_data_per_step 10 \
                --warmup_steps 250 \
                --total_steps 2500 \
                --batch_size 2 \
                --model_path ../models/$MODEL_NAME/ \
                --dataset_name ${DATA_NAME} \
                --primer_path ${MODEL_PATH} \
                --num_workers 0 \
                --progress_bar_refresh_rate 50 \
                --rand_seed ${RAND_SEED} \
                --saveTopK 1 \
                --test_imediate \
                --test_batch_size 2 \
                --grad_ckpt \
                --ckpt_path ${SAVE_DIR} \
                --data_path ${DATA_PATH} \
                --max_length_tgt 128 \
                --global_attention_mode $GLOBAL_ATTENTION_MODE \
                --select_last_k 3

echo "Finished processing"