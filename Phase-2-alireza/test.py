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
import sys
from joblib import dump, load
from utils import load_data, CombinedAttr, SELECTED_FEATURES, TARGET_FIELDS

TEST_DATA_PATH = sys.argv[0]

pipe = load('pipe.joblib') 
oe = load('oe.joblib') 
SVG_model = load('svg.joblib') 

test_posts = load_data(TEST_DATA_PATH, SELECTED_FEATURES)

test_posts_prepared = pipe.transform(test_posts)
predicted = SVG_model.predict(test_posts_prepared)


predicted_converted =  list(oe.inverse_transform([[i] for i in predicted]))

file = open('sth.csv','w')
counter = 0
file.write(',cat1,cat2,cat3\n')
for t in predicted_converted:
    file.write(str(counter)+','+str(t[0]).replace('nan', '')+'\n')
    counter += 1