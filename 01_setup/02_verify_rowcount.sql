-- after creation to confirm shape
SELECT
  COUNT(*)                    AS total_rows,
  COUNT(DISTINCT group_id)    AS distinct_groups,
  ROUND(MIN(random_value), 4) AS min_val,
  ROUND(MAX(random_value), 4) AS max_val,
  ROUND(AVG(random_value), 4) AS mean_val
FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.large_1tb_grouped_random_data`;