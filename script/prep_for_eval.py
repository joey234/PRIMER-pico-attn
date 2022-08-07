import pandas as pd
from pathlib import Path
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--input')
parser.add_argument('--output')
args = parser.parse_args()

test_file = '/root/thinh/cochrane/cochrane_test.csv'
output_folder = Path('/root/mslr_outputs/test/')
input_folder = Path('/root/thinh/PRIMER/') / args.input
#print(input_folder)
    
df = pd.read_csv(test_file)
for i, row in df.iterrows():
    filename = str(i)+".txt"
    pred = open(input_folder / filename).read()
    pred = pred.replace(" .", ".").replace(" ,", ",")
    pred = " ".join(pred.split())

    df.loc[i, 'Generated'] = pred

df_new = df[['ReviewID', 'Generated']]

df_new.to_csv(output_folder / args.output, index=False)
