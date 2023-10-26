import pandas as pd
import pyarrow.parquet as pq

import pyarrow.parquet as pq

def count_rows_in_csv(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        row_count = sum(1 for line in f)
    return row_count - 1  # subtract 1 to exclude the header

def count_rows_in_parquet(file_path):
    parquet_file = pq.ParquetFile(file_path)
    return parquet_file.metadata.num_rows

# Paths to your CSV files
csv_files = [
    '/home/yanluo/cmu-95797-data-warehousing/data/citibike-tripdata.csv/citibike-tripdata.csv',
    '/home/yanluo/cmu-95797-data-warehousing/data/central_park_weather.csv',
    '/home/yanluo/cmu-95797-data-warehousing/data/fhv_bases.csv'
]
file_names = ['bike_data', 'central_park_weather', 'fhv_bases']

# Count rows in CSV files
for csv_file, file_name in zip(csv_files, file_names):
    row_count_csv = count_rows_in_csv(csv_file)
    print(f"Row count in {file_name}: {row_count_csv}")

# Paths to your Parquet files
parquet_files = [
    '/home/yanluo/cmu-95797-data-warehousing/data/taxi/fhv_tripdata.parquet',
    '/home/yanluo/cmu-95797-data-warehousing/data/taxi/fhvhv_tripdata.parquet',
    '/home/yanluo/cmu-95797-data-warehousing/data/taxi/green_tripdata.parquet',
    '/home/yanluo/cmu-95797-data-warehousing/data/taxi/yellow_tripdata.parquet'
]
table_names = ['fhv_tripdata', 'fhvhv_tripdata', 'green_tripdata', 'yellow_tripdata']

# Count rows in Parquet files
for parquet_file, table_name in zip(parquet_files, table_names):
    row_count_parquet = count_rows_in_parquet(parquet_file)
    print(f"Row count in {table_name}: {row_count_parquet}")
