import pandas as pd


SELECTED_FEATURES = ['title','price','desc','id']
DATA_PATH = '../Data/divar_posts_dataset.csv'
TEST_DATA_PATH = '../Data/phase_2_dataset.csv'
TARGET_FIELDS = ['cat1']


def load_data(file_path, selected_features):
    data = pd.read_csv(file_path, nrows=100)
    df = pd.DataFrame(data)
    return df[selected_features]

posts = load_data(DATA_PATH, SELECTED_FEATURES+TARGET_FIELDS)
test_posts = load_data(TEST_DATA_PATH, SELECTED_FEATURES)

print("posts:")
print(posts.head())

print("test_posts:")
print(test_posts.head())