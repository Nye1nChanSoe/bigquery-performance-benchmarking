SELECT 
  job_id,
  creation_time,
  query,
  total_slot_ms,
  total_bytes_billed,
  TIMESTAMP_DIFF(end_time, start_time, SECOND) as duration_seconds
FROM `region-asia-southeast1`.INFORMATION_SCHEMA.JOBS_BY_USER
WHERE project_id = 'project-7abcab2d-24a7-4f5d-80a'
ORDER BY creation_time DESC