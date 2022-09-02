# Wallace dataset
DATA_NAME="cochrane"

GLOBAL_ATTENTION_MODE="ent_markers_spans"

# original PRIMER model
MODEL_NAME="PRIMER_cochrane_fewshot100_pico_"$GLOBAL_ATTENTION_MODE"_last3"
MODEL_PATH="allenai/PRIMERA"
CKPT_PATH="/root/thinh/PRIMER/checkpoints/"
DATA_PATH="/home/yuliao/RCT-summarization-data/"

#

#for RAND_SEED in 1111 1234 5555 6789 7362
#do
RAND_SEED=1111
NUM_TRAIN_DATA=100
SAVE_DIR="/root/thinh/PRIMER/fewshot100_pico_"$GLOBAL_ATTENTION_MODE"_last3"

python ../script/primer_hf_main.py  \
                --gpus 1 \
                --accelerator dp \
                --mode train \
                --lr 3e-5 \
                --label_smoothing 0.1 \
                --accum_data_per_step 10 \
                --warmup_steps 100 \
                --total_steps 1000 \
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
                --global_attention_mode $GLOBAL_ATTENTION_MODE \
                --use_pico
	# > ../fewshot_${DATA_NAME}_${MODEL_NAME}_${RAND_SEED}.out &

#done



echo "Finished processing"