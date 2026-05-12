-- create view "vw_group_mean"
CREATE OR REPLACE VIEW
  `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.vw_group_mean`
AS
SELECT
  group_id,
  AVG(random_value) AS mean_value,
  COUNT(*)          AS row_count
FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.large_1tb_grouped_random_data`
GROUP BY group_id;