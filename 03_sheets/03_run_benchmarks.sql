-- ============================================================
-- BENCHMARK D: View on Sheets  (run TWICE, note elapsed time)
-- ============================================================
SELECT * FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.vw_sheets_group_mean`
ORDER BY group_id;

-- ============================================================
-- BENCHMARK E: Scheduled query result table  (run TWICE)
-- ============================================================
SELECT * FROM `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.scheduled_sheets_group_mean`
ORDER BY group_id;