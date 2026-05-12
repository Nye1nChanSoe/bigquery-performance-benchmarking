-- Need about 1,024 GB / 300M rows
-- ≈ 3.4 KB per row

-- SHA256 hex string = 64 characters
-- 64 × 55 = 3,520 characters ≈ 3.5 KB
-- 300M rows × 3.5 KB ≈ 1.05 TB+

CREATE OR REPLACE TABLE `project-7abcab2d-24a7-4f5d-80a.query_performance_benchmark.large_1tb_grouped_random_data`
OPTIONS(
  expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 7 DAY)
)
AS
SELECT
  MOD((outer_id * 100000) + inner_id, 1000) AS group_id,
  RAND() AS random_value,
  RAND() AS random_value_2,
  GENERATE_UUID() AS uuid_col,
  TO_HEX(MD5(CAST(inner_id * outer_id AS STRING))) AS hash_col,
  TIMESTAMP_ADD(
    TIMESTAMP '2020-01-01 00:00:00',
    INTERVAL CAST(RAND() * 157680000 AS INT64) SECOND
  ) AS event_time,

  REPEAT(
    TO_HEX(SHA256(CONCAT(
      CAST(outer_id AS STRING), 
      '-', 
      CAST(inner_id AS STRING), 
      '-', 
      GENERATE_UUID()
    ))),
    55
  ) AS payload

FROM UNNEST(GENERATE_ARRAY(0, 2999)) AS outer_id
CROSS JOIN UNNEST(GENERATE_ARRAY(0, 99999)) AS inner_id;