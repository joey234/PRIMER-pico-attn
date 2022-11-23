import pandas as pd

df_train = pd.read_csv('cochrane_pico_train_all.csv')
df_dev = pd.read_csv('cochrane_pico_dev_all.csv')
df_test = pd.read_csv('cochrane_pico_test.csv')


# count_open = 0
# count_end = 0

train_docs = list(df_train['document'])
for doc in train_docs:
	count = 0
	texts = doc.split('|||||')
	for text in texts:
		text = text.split()
		for tok in text:
			if tok == '<ent>':
				count+=1
			elif tok == '</ent>':
				count-=1
	# print(count)
	if count != 0:
		print(doc)


train_docs = list(df_train['summary'])
for doc in train_docs:
	count = 0
	texts = doc.split('|||||')
	for text in texts:
		text = text.split()
		for tok in text:
			if tok == '<ent>':
				count+=1
			elif tok == '</ent>':
				count-=1
	# print(count)
	if count != 0:
		print(doc)


dev_docs = list(df_dev['document'])
for doc in dev_docs:
	count = 0
	texts = doc.split('|||||')
	for text in texts:
		text = text.split()
		for tok in text:
			if tok == '<ent>':
				count+=1
			elif tok == '</ent>':
				count-=1
	# print(count)
	if count != 0:
		print(doc)


dev_docs = list(df_dev['summary'])
for doc in dev_docs:
	count = 0
	texts = doc.split('|||||')
	for text in texts:
		text = text.split()
		for tok in text:
			if tok == '<ent>':
				count+=1
			elif tok == '</ent>':
				count-=1
	# print(count)
	if count != 0:
		print(doc)

test_docs = list(df_test['document'])
for doc in test_docs:
	count = 0
	texts = doc.split('|||||')
	for text in texts:
		text = text.split()
		for tok in text:
			if tok == '<ent>':
				count+=1
			elif tok == '</ent>':
				count-=1
	# print(count)
	if count != 0:
		print(doc)

# print(count_open)
# print(count_open)
# print(count_end)