import pandas as pd 
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model


# Use the environment variable for the data path and load all partitions

#file_path = "/home/sima/data/test.csv"
#print_path = "/home/sima/data/prediction.txt"
#model_path="/home/sima/data/stock_model.keras"




file_path  ="/app/data/test.csv"
print_path ="/app/data/prediction.txt"
model_path ="/app/data/stock_model.keras"



model = load_model(model_path)
test_df = pd.read_csv(file_path) 

X_test = test_df.drop(columns=["target", "weights"]).values  # Remove non-feature columns

# Reshape X_test if needed for LSTM (3D input: [samples, timesteps, features])
X_test = X_test.reshape((X_test.shape[0], X_test.shape[1], 1))  # Adjust dimensions if required


predictions = model.predict(X_test).flatten()


test_df["predictions"] = predictions


test_df.to_csv(print_path, index=False)










