import pandas as pd
from sklearn.externals import joblib
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer, TfidfVectorizer
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import OrdinalEncoder
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import OneHotEncoder
from sklearn.linear_model import SGDClassifier
from sklearn.svm import SVC
from sklearn.pipeline import Pipeline
import numpy as np
import sys
from joblib import dump, load
from utils import load_data, CombinedAttr, SELECTED_FEATURES, TARGET_FIELDS, DATA_PATH, TEST_DATA_PATH


print("1")
pipe = Pipeline([
    ('attribute_adder', CombinedAttr()),
    ('tfidf', TfidfVectorizer()),
    ])

print("2")
posts = load_data(DATA_PATH, SELECTED_FEATURES+TARGET_FIELDS)


print("3")
posts_prepared = pipe.fit_transform(posts)

print("4")
oe = OrdinalEncoder()
cat_encoded = oe.fit_transform(posts[['cat']])

print("5")
SVG_model = SGDClassifier(random_state=42, )

scores = cross_val_score(SVG_model, posts_prepared, cat_encoded, cv=5)
print("score: ", scores, scores.mean())

print("6")
SVG_model.fit(posts_prepared, cat_encoded)

print("7")
dump(pipe, 'pipe.joblib') 
dump(oe, 'oe.joblib') 
dump(SVG_model, 'svg.joblib')