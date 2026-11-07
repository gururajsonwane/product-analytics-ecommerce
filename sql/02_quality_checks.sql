-- 02_quality_checks.sql
-- Data validation for events_raw (10% user sample, Oct 2019)

-- Check 1: NULL counts
SELECT
    COUNT(*)                          AS total_rows,
    COUNT(*) - COUNT(user_id)         AS null_user_id,
    COUNT(*) - COUNT(user_session)    AS null_user_session,
    COUNT(*) - COUNT(price)           AS null_price,
    COUNT(*) - COUNT(category_code)   AS null_category_code,
    COUNT(*) - COUNT(brand)           AS null_brand
FROM events_raw;

-- Check 2: Duplicate rows (all 9 columns identical)
SELECT
    (SELECT COUNT(*) FROM events_raw) AS total_rows,
    (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM events_raw) d) AS distinct_rows;

-- Check 3: Price range and bad prices
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    COUNT(*) FILTER (WHERE price < 0) AS negative_prices,
    COUNT(*) FILTER (WHERE price = 0) AS zero_prices
FROM events_raw;