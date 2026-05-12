# BigQuery Performance Benchmarking

Comparing aggregation query performance across five method combinations on BigQuery,
using a 1 TB native dataset and a 1M-row Google Sheets external table.

---

## Datasets

| Dataset                         | Rows        | Size                                 | Source                 |
| ------------------------------- | ----------- | ------------------------------------ | ---------------------- |
| `large_1tb_grouped_random_data` | 300,000,000 | 1,013 GB logical / 30.17 GB physical | BigQuery native        |
| `sheets-1m-benchmark`           | 1,000,000   | —                                    | Google Sheets external |

Both datasets contain 1,000 distinct `group_id` values and a `random_value` column.

---

## Methods Compared

All five methods compute `AVG(random_value) GROUP BY group_id` on their respective source.

| Label | Method                | Source          |
| ----- | --------------------- | --------------- |
| A     | Logical view          | BQ native       |
| B     | Scheduled query table | BQ native       |
| C     | Materialized view     | BQ native       |
| D     | Logical view          | Sheets external |
| E     | Scheduled query table | Sheets external |

---

## Results

| Method                        | Run 1 (ms) | Run 2 (ms) | GB Billed       |
| ----------------------------- | ---------- | ---------- | --------------- |
| A: Logical view (native)      | 218        | 118        | 0.0098 / 0.00   |
| B: Scheduled table (native)   | 241        | 97         | 0.0098 / 0.00   |
| C: Materialized view (native) | 199        | 187        | 0.0098 / 0.00   |
| D: Sheets view (external)     | 24,858     | 25,250     | 0.0439 / 0.0439 |
| E: Sheets scheduled (native)  | 235        | 99         | 0.0098 / 0.00   |

Full analysis → [`04_results/timings.md`](04_results/timings.md)

**Key finding:** Data residency matters more than query method. All native-BQ methods finish
under 250 ms. The Sheets-backed view takes ~25 s — a **106× slowdown** — because every
query re-fetches 1M rows across the Drive API with no caching.

---

## Repo Structure

```
bigquery-performance-benchmarking/
├── 01_setup/
│   ├── 01_create_dataset.sql
│   ├── 02_verify_rowcount.sql
│   ├── query_viz.png
│   └── row_count.json
├── 02_bq_native/
│   ├── 01_create_view.sql
│   ├── 02_create_materialized_view.sql
│   ├── 03_scheduled_query.sql
│   ├── 04_run_benchmarks.sql
│   └── benchmark_results.csv
├── 03_sheets/
│   ├── 01_create_view.sql
│   ├── 02_scheduled_query.sql
│   ├── 03_run_benchmarks.sql
│   ├── app_script.gs
│   └── benchmark_results.csv
├── 04_results/
│   └── timings.md              <- final conclusions
├── benchmark_query.sql
├── information_schema.sql
└── README.md
```
