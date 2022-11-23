import pandas as pd

df_1 = pd.read_csv('cochrane_pico_train_1.csv')
df_2 = pd.read_csv('cochrane_pico_train_2.csv')
df_3 = pd.read_csv('cochrane_pico_train_3.csv')
df_4 = pd.read_csv('cochrane_pico_train_4.csv')

df = pd.concat([df_1,df_2,df_3,df_4]).reset_index().drop(columns = ['index'])
print(df.columns)
print(len(df))
df.to_csv('cochrane_pico_train.csv', index = False)