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
    ('tfidf', TfidfVectorizer(ngram_range=(1,2), max_features=20000)),
])

def preprocess_data(datas):
    data_pipelined = create_pipeline()
    return data_pipelined.fit_transform(datas)



class CombinedAttr(BaseEstimator, TransformerMixin):
    def fit(self, X, y=None):
        return self

    def transform(self, X, y=None):
        X_df = pd.DataFrame(X, columns=SELECTED_FEATURES+TARGET_FIELDS)
        X_df['text'] = X_df['title'] + ' '  +X_df['desc']
        X_df = X_df[['text']]
        return np.asarray(X_df['text']).astype(str)

# LOAD DATA


posts = load_data(DATA_PATH, SELECTED_FEATURES+TARGET_FIELDS)

# PREPROCESS

posts_prepared = preprocess_data(posts)

posts_cat1 = posts[['cat1']]

# cat_encoder = OneHotEncoder(sparse=False)
# posts_cat1_1hot = cat_encoder.fit_transform(posts_cat1)

oe = OrdinalEncoder()
cat_encoded = oe.fit_transform(posts_cat1)



# train_set, test_set = train_test_split(posts_prepared, test_size=0.2, random_state=42)
SVG_model = SGDClassifier(random_state=42)
# scores = cross_val_score(SVG_model, posts_prepared, cat_encoded, cv=5)
SVG_model.fit(posts_prepared, cat_encoded)
joblib.dump(SVG_model, 'model.txt')

test_posts = load_data(TEST_DATA_PATH, SELECTED_FEATURES)

# PREPROCESS

test_posts_prepared = preprocess_data(test_posts)

predicted = SVG_model.predict(test_posts_prepared)
for item in list(oe.inverse_transform([[i] for i in predicted]))[:20]: print(item)
import pdb;pdb.set_trace();




# model = create_model()
# model.fit()