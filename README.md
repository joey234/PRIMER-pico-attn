# PRIMER-pico-attn
Code for the paper ``LED down the rabbit hole: exploring the potential of global attention for biomedical multi-document summarisation'' (SDP Workshop at COLING 2022).



# Run script
## Fewshot
'''
DATA_NAME="wallace"
GLOBAL_ATTENTION_MODE="ent_markers_spans"
MODEL_NAME="PRIMER_wallace_fewshot10_pico_"$GLOBAL_ATTENTION_MODE
MODEL_PATH="allenai/PRIMERA"
CKPT_PATH="checkpoints/"
DATA_PATH="RCT-summarization-data/"
RAND_SEED=1111
NUM_TRAIN_DATA=10
SAVE_DIR="fewshot10_pico_"$GLOBAL_ATTENTION_MODE

python script/primer_hf_main.py  \
                --gpus 1 \
                --mode train \
                --lr 3e-5 \
                --label_smoothing 0.1 \
                --accum_data_per_step 10 \
                --warmup_steps 20 \
                --total_steps 200 \
                --batch_size 2 \
                --model_path ../models/$MODEL_NAME/  \
                --dataset_name ${DATA_NAME} \
                --primer_path ${MODEL_PATH} \
                --num_workers 4 \
                --progress_bar_refresh_rate 50 \
                --rand_seed ${RAND_SEED} \
                --saveTopK 1 \
                --test_imediate \
                --test_batch_size 2 \
                --grad_ckpt \
                --ckpt_path ${SAVE_DIR} \
                --data_path ${DATA_PATH} \
		--max_length_tgt 128 \
		--num_train_data $NUM_TRAIN_DATA \
		--fewshot \
                --global_attention_mode $GLOBAL_ATTENTION_MODE
echo "Finished processing"

'''