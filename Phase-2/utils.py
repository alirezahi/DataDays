import pandas as pd
from sklearn.externals import joblib
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer, TfidfVectorizer
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import OrdinalEncoder
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import SGDClassifier
from sklearn.pipeline import Pipeline
import numpy as np
from joblib import dump, load


SELECTED_FEATURES = ['title','price','desc','id']
DATA_PATH = '../Data/divar_posts_dataset.csv'
TEST_DATA_PATH = '../Data/phase_2_dataset.csv'


def load_data(file_path, selected_features):
    data = pd.read_csv(file_path)
    df = pd.DataFrame(data)
    return df[selected_features]


def save_file(data,file_name,column_name='column'):
    df = pd.DataFrame({
        column_name: data
    })
    df.to_csv(file_name)

def concat_file():
    list_ = []

    for file_ in allFiles:
        df = pd.read_csv(file_,index_col=None, header=0)
        list_.append(df)


class CombinedAttr(BaseEstimator, TransformerMixin):
    def fit(self, X, y=None):
        return self

    def transform(self, X, y=None):
        X_df = pd.DataFrame(X, columns=SELECTED_FEATURES)
        X_df['text'] = X_df['title'] + ' '  +X_df['desc']
        X_df = X_df[['text']]
        return np.asarray(X_df['text']).astype(str)

