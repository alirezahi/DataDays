from sklearn.externals import joblib
from main import CombinedAttr, load_data, TEST_DATA_PATH, SELECTED_FEATURES
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer

model = joblib.load("model.txt")
data_pipelined = joblib.load("pipeline.txt")
oe = joblib.load("oe.txt")

test_posts = load_data(TEST_DATA_PATH, SELECTED_FEATURES)
test_posts_prepared = data_pipelined.transform(test_posts)
predicted = model.predict(test_posts_prepared)

for item in list(oe.inverse_transform([[i] for i in predicted]))[:20]: print(item)