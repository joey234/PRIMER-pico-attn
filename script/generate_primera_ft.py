import torch
import jsonlines as jl
import json
from tqdm import tqdm
import pytorch_lightning as pl
from pytorch_lightning.loggers import TestTubeLogger
from pytorch_lightning.callbacks import ModelCheckpoint
from primer_yulia_main import PRIMERSummarizer



from transformers import AutoTokenizer, LEDForConditionalGeneration, LEDConfig


use_cuda = torch.cuda.is_available()
device = torch.device("cuda:0" if use_cuda else "cpu")


args = {
  "gpus": 1,
  "mode": "test",
  "model_name": "primer",
  "primer_path": "allenai/PRIMERA"
  "join_method": "concat_start_wdoc_global",
  "progress_bar_refresh_rate": 5,
  "model_path": "../models/PRIMER_wallace/",
  "data_path": "/home/yuliao/RCT-summarization-data/wallace",
  "dataset_name": "wallace",
  "num_workers": 0,
  "batch_size": 8,
  "max_length_tgt": 256,
  "beam_size": 1,
  "test_batch_size": 8
}



CHECKPOINT = '/root/yuliao/PRIMER/checkpoints/step=2094-vloss=3.72-avgr=0.1602.ckpt'

tokenizer = AutoTokenizer.from_pretrained('allenai/PRIMERA')
#model = LEDForConditionalGeneration.from_pretrained('allenai/PRIMERA')


model = PRIMERSummarizer.load_from_checkpoint(CHECKPOINT, args=args)

#qmodel.gradient_checkpointing_enable()
PAD_TOKEN_ID = tokenizer.pad_token_id
DOCSEP_TOKEN_ID = tokenizer.convert_tokens_to_ids("<doc-sep>")


def process_document(data):
    input_ids_all=[]
    all_docs = data.split("|||||")
    
    for i, doc in enumerate(all_docs):
        doc = doc.replace("\n", " ")
        doc = " ".join(doc.split())
        all_docs[i] = doc

    #### concat with global attention on doc-sep
    input_ids = []
    for doc in all_docs:
        input_ids.extend(
            tokenizer.encode(
                doc,
                truncation=True,
                max_length=4096 // len(all_docs),
            )[1:-1]
            )
        input_ids.append(DOCSEP_TOKEN_ID)
    input_ids = (
            [tokenizer.bos_token_id]
            + input_ids
            + [tokenizer.eos_token_id]
    )
    input_ids_all.append(torch.tensor(input_ids))
    input_ids = torch.nn.utils.rnn.pad_sequence(
        input_ids_all, batch_first=True, padding_value=PAD_TOKEN_ID
    )
    return input_ids


def generate_summary(article):
    input_ids = process_document(article)
    global_attention_mask = torch.zeros_like(input_ids).to(input_ids.device)

    global_attention_mask[:, 0] = 1
    global_attention_mask[input_ids == DOCSEP_TOKEN_ID] = 1

    generated_ids = model.generate(
        input_ids=input_ids,
        global_attention_mask=global_attention_mask,
        use_cache=True,
        max_length=256,
        num_beams=4,
    )

    summary = tokenizer.batch_decode(
            generated_ids.tolist(), skip_special_tokens=True
        )
    
    return summary
 

input_f = "/home/yuliao/summarization/undecorated_level3.jsonl"
output_f = "/home/yuliao/summarization/primera_ft_level3.jsonl"

with jl.open(input_f) as reader:
    with jl.open(output_f, 'w') as writer:
        for line in tqdm(reader):
            input_text = line['input_text']
            generated_text = generate_summary(input_text)
            #print(generated_text)
            line['generated'] = generated_text
            writer.write(line)

