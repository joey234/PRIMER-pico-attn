# PRIMER-pico-attn
Code for the paper ``LED down the rabbit hole: exploring the potential of global attention for biomedical multi-document summarisation`` (SDP Workshop at COLING 2022).

# Data
Please download and decompress the cochrane data first: https://drive.google.com/file/d/14mcA_bN1TpGPZKv_REirL99cd3FlRO9I/view?usp=sharing


# Run script
Script to reproduce the results from the paper is in run_bash 

## Global attention mode

Specify using GLOBAL_ATTENTION_MODE variable in the run script (choose from `doc_sep_only`, `ent_only`, `ent_markers`, `ent_spans`, `ent_markers_spans`).

## Example run script

	DATA_NAME="cochrane"
	GLOBAL_ATTENTION_MODE="ent_markers_spans"
	MODEL_NAME="PRIMER_cochrane_fewshot10_pico_"$GLOBAL_ATTENTION_MODE
	MODEL_PATH="allenai/PRIMERA"
	CKPT_PATH="checkpoints/"
	DATA_PATH="cochrane/"
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
