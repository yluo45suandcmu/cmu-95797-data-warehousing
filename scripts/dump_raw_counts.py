import duckdb

try:
    with duckdb.connect('main.db') as conn:
        tables = [
            "bike_data",
            "central_park_weather",
            "fhv_bases",
            "fhv_tripdata",
            "fhvhv_tripdata",
            "green_tripdata",
            "yellow_tripdata"
        ]

        for table in tables:
            try:
                query = f"SELECT COUNT(*) FROM {table}"
                row_count = conn.execute(query).fetchone()[0]
                print(f"{table}: {row_count}")
            except Exception as e:
                print(f"Failed to fetch row count for {table}: {str(e)}")
except Exception as e:
    print(f"Failed to connect to the database: {str(e)}")
