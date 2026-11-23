---Task 6.3 

--Part A 

WITH measurements AS (
    SELECT post_id, like_id, liked_at, 'dwell_ms' AS metric, dwell_ms AS metric_value
    FROM likes

    UNION ALL

    SELECT post_id, like_id, liked_at, 'scroll_depth', scroll_depth
    FROM likes

    UNION ALL

    SELECT post_id, like_id, liked_at, 'weight', weight
    FROM likes
), ranked AS (
    SELECT
        m.*,
        COUNT(*) OVER post_metric AS recorded_likes,
        ROUND(AVG(metric_value) OVER post_metric, 2) AS post_metric_avg,
        FIRST_VALUE(metric_value) OVER best_first AS Firstvalue,
        ROW_NUMBER() OVER best_first AS position -- we use the row_number to handle ties by taking the position of the row
    FROM measurements AS m
    WINDOW
        post_metric AS (PARTITION BY post_id, metric),

        best_first AS (
            PARTITION BY post_id, metric
            ORDER BY metric_value DESC, liked_at, like_id
        )
)
SELECT
    post_id, metric, position, like_id, liked_at, metric_value,
    recorded_likes, post_metric_avg, Firstvalue
FROM ranked
WHERE position <= 3
ORDER BY post_id, metric, position;



--Part B 



WITH monthly AS (
    SELECT DATE_TRUNC('month', liked_at) AS month_start,
           COUNT(*) AS recorded_likes,
           AVG(dwell_ms) AS avg_dwell_ms,
           AVG(scroll_depth) AS avg_scroll_depth,
           AVG(weight) AS avg_weight
    FROM likes
    GROUP BY DATE_TRUNC('month', liked_at)
), compared AS (
    SELECT m.*,
           LAG(month_start) OVER w =
               (month_start - INTERVAL '1 month')  AS consecutive,
           LAG(recorded_likes) OVER w AS prev_likes,
           LAG(avg_dwell_ms) OVER w AS prev_dwell_ms
    FROM monthly AS m
    WINDOW w AS (ORDER BY month_start)
)
SELECT month_start, recorded_likes,
       ROUND(avg_dwell_ms, 2) AS avg_dwell_ms,
       ROUND(avg_scroll_depth, 2) AS avg_scroll_depth,
       ROUND(avg_weight, 2) AS avg_weight,
       CASE WHEN consecutive THEN
           ROUND(100.0 * (recorded_likes - prev_likes) / NULLIF(prev_likes, 0), 2)
       END AS likes_change_pct,
       CASE WHEN consecutive THEN
           ROUND(100.0 * (avg_dwell_ms - prev_dwell_ms) / NULLIF(prev_dwell_ms, 0), 2)
       END AS dwell_change_pct
FROM compared
ORDER BY month_start;