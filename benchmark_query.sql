SELECT
  creation_time,
  -- Identify the benchmark based on the table or view name in the SQL text
  CASE 
    WHEN query LIKE '%vw_sheets_group_mean%' THEN 'D: Sheets View (External)'
    WHEN query LIKE '%scheduled_sheets_group_mean%' THEN 'E: Sheets Scheduled (Native)'
    WHEN query LIKE '%vw_group_mean%' THEN 'A: Logical View (Native)'
    WHEN query LIKE '%scheduled_group_mean%' THEN 'B: Scheduled Table (Native)'
    WHEN query LIKE '%mv_group_mean%' THEN 'C: Materialized View (Native)'
    ELSE 'Other / Maintenance'
  END AS benchmark_test,
  total_slot_ms,
  -- Billed Bytes for Sheets (External) is often 0, but Slot MS will show the effort
  ROUND(total_bytes_billed / POWER(1024, 3), 4) AS gb_billed,
  TIMESTAMP_DIFF(end_time, start_time, MILLISECOND) AS duration_ms,
  query
FROM `region-asia-southeast1`.INFORMATION_SCHEMA.JOBS
WHERE creation_time > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 HOUR) -- Expanded to 1 hour
  AND statement_type = 'SELECT'
  AND query NOT LIKE '%INFORMATION_SCHEMA%'
ORDER BY creation_time DESC;