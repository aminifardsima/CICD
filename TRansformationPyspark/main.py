from pyspark.sql import SparkSession
from pyspark.sql.functions import col, mean, stddev, when, lit, abs

file_path = "/app/data/train.parquet"
print_path = "/app/data/output"
spark = SparkSession.builder.appName("Kaggle Dataset Training2").getOrCreate()
#spark = SparkSession.builder.master("local[*]").appName("OutlierProcessing").getOrCreate()
# Read the Parquet file
df = spark.read.parquet(file_path)
selected_columns = [col_name for col_name in df.columns if col_name.startswith('feature_')]

def process_outliers(spark_df):
    # Select columns matching 'feature_' and symbol_id
   # selected_columns = [col_name for col_name in spark_df.columns if col_name.startswith('feature_')]

    # Group by symbol_id and process each feature column
    for column in selected_columns:
        # Calculate mean and standard deviation for each symbol group
        stats_df = spark_df.groupBy("symbol_id").agg(
            mean(col(column)).alias("mean"),
            stddev(col(column)).alias("stddev")
        )

        # Join the statistics back to the original DataFrame
        spark_df = spark_df.join(stats_df, on="symbol_id", how="left")

        # Compute Z-scores and replace outliers with NULL
        spark_df = spark_df.withColumn(
            column,
            when(
                (col("stddev").isNotNull()) & (col("mean").isNotNull()) & 
                (abs((col(column) - col("mean")) / col("stddev")) > 3),
                lit(None)
            ).otherwise(col(column))
        ).drop("mean", "stddev")

    return spark_df



# Process the DataFrame
transformed_df = process_outliers(df)

# Write the result to a new CSV
transformed_df.write.mode("overwrite").csv(print_path)

print(f"Data processing complete. Output has been written to: {print_path}")
