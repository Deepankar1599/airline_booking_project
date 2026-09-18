# Use an official lightweight Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /usr/app

# Install system dependencies needed for git/builds if necessary
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install dbt Core and the Databricks adapter
RUN pip install --no-cache-dir dbt-core dbt-databricks

# Copy the entire dbt project into the container
COPY . .

# Set environment variables for dbt profiles to read dynamically
ENV DBT_PROFILES_DIR=/usr/app

# Default command to test connectivity; Airflow will override this later
CMD ["dbt", "debug"]
