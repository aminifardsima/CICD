import os
from pyspark.sql import SparkSession
import pandas as pd  # Ensure pandas is imported

# Create Spark session
spark = SparkSession.builder.appName("Kaggle Dataset Training").getOrCreate()

# Use the environment variable for the data path and load all partitions
file_path = "/app/data/train.parquet"
print_path = "/app/data/printed.txt"

# Read parquet files (loads all partitions)
train_df = spark.read.parquet(file_path)

# Write schema and sample data to the specified file path
with open(print_path, "w") as output_file:
    # Capture schema information
    output_file.write("Data Schema:\n")
    schema_str = train_df.schema.simpleString()
    output_file.write(f"{schema_str}\n\n")

    # Capture sample data as a string
    sample_data = train_df.limit(5).toPandas()
    output_file.write("Sample Data:\n")
    output_file.write(sample_data.to_string(index=False))
