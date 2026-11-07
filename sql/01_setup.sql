-- 01_setup.sql
-- Project: Product Analytics on E-commerce Behaviour Data (REES46, Oct 2019)
-- Grain: one row = one event

CREATE TABLE events_raw (
    event_time     TIMESTAMPTZ,
    event_type     TEXT,
    product_id     BIGINT,
    category_id    BIGINT,
    category_code  TEXT,
    brand          TEXT,
    price          NUMERIC(10,2),
    user_id        BIGINT,
    user_session   TEXT
);

-- Sample loaded from C:\datasets\events_sample_oct2019.csv
-- Sampling rule: user_id % 10 = 0 (user-level, ~10% of users)
-- Rows before sampling: 42,448,764 | after: 4,224,899

-- Check: row count must equal 4,224,899
SELECT COUNT(*) FROM events_raw;