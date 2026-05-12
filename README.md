# BigQuery Performance Benchmarking (1TB Scale)

This repository contains SQL scripts and performance logs for benchmarking Google BigQuery's execution engine. The project focuses on generating a 1TB synthetic dataset and measuring the efficiency of various query methods, including native SQL and View-based abstractions.

## Project Structure

```text
.
├── 01_setup
│   ├── 01_create_dataset.sql
│   └── query_viz.png
├── 02_bg_native
├── 03_sheets
├── 04_results
├── information_schema.sql      # extract job metadata and slot usage
└── README.md
```
