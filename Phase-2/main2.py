import sys
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
from utils import load_data, CombinedAttr, SELECTED_FEATURES, DATA_PATH, TEST_DATA_PATH

pipe = Pipeline([
    ('attribute_adder', CombinedAttr()),
    ('tfidf', TfidfVectorizer()),
    ])

TARGET_FIELDS = [str(sys.argv[1])]

posts = load_data(DATA_PATH, SELECTED_FEATURES+TARGET_FIELDS)
posts[TARGET_FIELDS[0]].fillna('', inplace=True)
# posts['cat3'].fillna('&', inplace=True)

posts_prepared = pipe.fit_transform(posts)

oe = OrdinalEncoder()
cat_encoded = oe.fit_transform(posts[TARGET_FIELDS])

SVG_model = SGDClassifier(random_state=42)
SVG_model.fit(posts_prepared, cat_encoded)

dump(pipe, 'pipe.joblib') 
dump(oe, 'oe.joblib') 
dump(SVG_model, 'svg.joblib')
