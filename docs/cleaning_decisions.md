# Cleaning Decisions

Data: events_raw (10% user sample, REES46, Oct 2019, 4,224,899 rows).
Rule: events_raw is never modified. A cleaned table is created on top of it.

## Problems found (from sql/02_quality_checks.sql)

| Problem | Rows | Share of rows |
|---|---|---|
| category_code is NULL | 1,350,263 | 32.0% |
| brand is NULL | 604,640 | 14.3% |
| Duplicate rows (all 9 columns identical) | 3,217 extra rows | 0.08% |
| price = 0 | 6,808 | 0.16% |
| price < 0 | 0 | 0% |
| user_id, user_session, price is NULL | 0 | 0% |

## Decisions

| # | Problem | Decision | Why |
|---|---|---|---|
| 1 | category_code NULL | Keep the rows, replace NULL with 'unknown' | Deleting would remove 32% of events and distort the funnel |
| 2 | brand NULL | Keep the rows, replace NULL with 'unknown' | Deleting would remove 14.3% of events |
| 3 | Duplicates | Keep one copy of each (SELECT DISTINCT) | Stops cart counts and revenue from being counted twice |
| 4 | price = 0 | Keep the rows for funnel and session counts. Exclude them from price and average price calculations | Zero price rows are only view (6,793) and cart (15). No purchase has price 0, so revenue is not affected |

## Notes and limits

- Duplicates are mostly cart events (3,004 extra rows). The data cannot tell if these are double clicks or logging errors.
- Nulls are not filled with 0. 'unknown' keeps them visible as a group.
- There is no order ID, so a purchasing session is used as a proxy for an order.
- event_type has only view, cart, purchase in this sample (no remove_from_cart).
- Cleaned table: events_clean (to be created in sql/03_clean.sql).
