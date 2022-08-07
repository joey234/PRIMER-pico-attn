#!/bin/bash

python prep_for_eval.py --input "models/PRIMER_wallace_fewshot100_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_fewshot100_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_fewshot10_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_fewshot10_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_pico_doc_sep_only_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_doc_sep_only_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_pico_ent_markers_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_ent_markers_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_pico_ent_spans_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_ent_spans_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_pico_ent_markers_spans_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_ent_markers_spans_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_full_pico_ent_only_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_full_ent_only_last3.csv"

python prep_for_eval.py --input "models/PRIMER_wallace_zeroshot_last3/dev/generated_txt_fewshot0_wallace_beam=1_4096_128_-1" --output "dev_zetoshot_last3.csv"