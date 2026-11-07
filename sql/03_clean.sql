-- 03_clean.sql
-- Builds events_clean from events_raw using docs/cleaning_decisions.md
-- events_raw is never modified.

DROP TABLE IF EXISTS events_clean;

CREATE TABLE events_clean AS
SELECT DISTINCT
    event_time,
    event_type,
    product_id,
    category_id,
    COALESCE(category_code, 'unknown') AS category_code,
    COALESCE(brand, 'unknown')         AS brand,
    price,
    NULLIF(price, 0)                   AS price_clean,
    user_id,
    user_session
FROM events_raw;

-- Check: expected rows_clean = 4,221,682, null_cat = 0, null_brand = 0
SELECT
    COUNT(*)                                      AS rows_clean,
    COUNT(*) FILTER (WHERE category_code IS NULL) AS null_cat,
    COUNT(*) FILTER (WHERE brand IS NULL)         AS null_brand,
    COUNT(*) FILTER (WHERE price_clean IS NULL)   AS zero_price_rows
FROM events_clean;