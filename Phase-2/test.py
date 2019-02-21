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
from utils import load_data, CombinedAttr, SELECTED_FEATURES, DATA_PATH, TEST_DATA_PATH, save_file

TARGET = str(sys.argv[1])

pipe = load('pipe.joblib') 
oe = load('oe.joblib') 
SVG_model = load('svg.joblib') 

test_posts = load_data(TEST_DATA_PATH, SELECTED_FEATURES)

test_posts_prepared = pipe.transform(test_posts)
predicted = SVG_model.predict(test_posts_prepared)


predicted_converted = list(oe.inverse_transform([[i] for i in predicted]))
predicted_converted = [i[0] for i in predicted_converted]
save_file(predicted_converted, TARGET+'_prediction.csv', TARGET)