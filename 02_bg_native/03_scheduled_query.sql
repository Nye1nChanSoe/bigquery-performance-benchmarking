-- Scheduled queries -> Create scheduled query
-- Schedule: "every 24 hours", starting now
-- Destination table: query_performance_benchmark.scheduled_group_mean

SELECT
  group_id,
  AVG(random_value) AS mean_value,
  COUNT(*)          AS row_count
FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.large_1tb_grouped_random_data`
GROUP BY group_id;