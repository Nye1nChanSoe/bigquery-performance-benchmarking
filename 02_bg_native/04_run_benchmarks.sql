-- ============================================================
-- BENCHMARK A: View  (run this TWICE, note elapsed time each run)
-- ============================================================
SELECT * FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.vw_group_mean`
ORDER BY group_id;

-- ============================================================
-- BENCHMARK B: Scheduled query result table  (run TWICE)
-- ============================================================
SELECT * FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.scheduled_group_mean`
ORDER BY group_id;

-- ============================================================
-- BENCHMARK C: Materialized view  (run TWICE)
-- ============================================================
SELECT * FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.mv_group_mean`
ORDER BY group_id;