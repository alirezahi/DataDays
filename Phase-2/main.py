import pandas as pd
from sklearn.externals import joblib
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import OrdinalEncoder
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import SGDClassifier
from sklearn.pipeline import Pipeline
import numpy as np


SELECTED_FEATURES = ['title','price','desc','id']
DATA_PATH = '../Data/divar_posts_dataset.csv'
TEST_DATA_PATH = '../Data/phase_2_dataset.csv'
TARGET_FIELDS = ['cat1','cat2','cat3']


def load_data(file_path, selected_features):
    data = pd.read_csv(file_path)
    df = pd.DataFrame(data)
    df = df[selected_features]
    return df


def create_pipeline():
    return Pipeline([
    ('attribute_adder', CombinedAttr()),
    ('tfidf', TfidfVectorizer()),
])

class CombinedAttr(BaseEstimator, TransformerMixin):
    def fit(self, X, y=None):
        return self

    def transform(self, X, y=None):
        X_df = pd.DataFrame(X, columns=SELECTED_FEATURES+TARGET_FIELDS)
        X_df['text'] = X_df['title'] + ' '  +X_df['desc']
        X_df = X_df[['text']]
        return np.asarray(X_df['text']).astype(str)


data_pipelined = create_pipeline()

posts = load_data(DATA_PATH, SELECTED_FEATURES+TARGET_FIELDS)
posts_prepared = data_pipelined.fit_transform(posts)
joblib.dump(data_pipelined, 'pipeline.txt')


posts_cat1 = posts[['cat2']]
oe = OrdinalEncoder()
cat_encoded = oe.fit_transform(posts_cat1)
joblib.dump(data_pipelined, 'oe.txt')

import pdb;pdb.set_trace()
gg = pd.DataFrame(list(posts_prepared))

model = SGDClassifier(random_state=42)
model.fit(posts_prepared, cat_encoded)
joblib.dump(model, 'model.txt')

scores = cross_val_score(model, posts_prepared, cat_encoded, cv=5)

# cat_encoder = OneHotEncoder(sparse=False)
# posts_cat1_1hot = cat_encoder.fit_transform(posts_cat1)
# train_set, test_set = train_test_split(posts_prepared, test_size=0.2, random_state=42)

import pdb;pdb.set_trace();