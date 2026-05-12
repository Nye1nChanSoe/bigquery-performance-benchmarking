-- -- create materialized view "mv_group_mean"
CREATE MATERIALIZED VIEW
  `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.mv_group_mean`
OPTIONS (
  enable_refresh = true,
  refresh_interval_minutes = 1440   -- 24 hours
)
AS
SELECT
  group_id,
  AVG(random_value) AS mean_value,
  COUNT(*)          AS row_count
FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.large_1tb_grouped_random_data`
GROUP BY group_id;