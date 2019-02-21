import pandas as pd


all_files = ['cat1', 'cat2', 'cat3']
list_ = []

for file_ in all_files:
    df = pd.read_csv(file_+str('_prediction.csv'),index_col=None, header=0)
    list_.append(df[file_])

frame = pd.concat(list_, axis = 1, ignore_index = True)
frame.columns = all_files
frame.to_csv('result.csv')