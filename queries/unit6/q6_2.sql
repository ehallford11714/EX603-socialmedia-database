---Lag and Lead from previous event and next event in time order 


WITH laglead AS (
    SELECT
        post_id, like_id, liked_at,
        COUNT(*) OVER per_post AS recorded_likes,
        dwell_ms,
        LAG(dwell_ms) OVER post_time AS previous_dwell_ms,
        LEAD(dwell_ms) OVER post_time AS next_dwell_ms,
        ROUND(AVG(dwell_ms) OVER per_post, 2) AS post_avg_dwell_ms,
        scroll_depth,
        LAG(scroll_depth) OVER post_time AS previous_scroll_depth,
        LEAD(scroll_depth) OVER post_time AS next_scroll_depth,
        ROUND(AVG(scroll_depth) OVER per_post, 2) AS post_avg_scroll_depth,
        weight,
        LAG(weight) OVER post_time AS previous_weight,
        LEAD(weight) OVER post_time AS next_weight,
        ROUND(AVG(weight) OVER per_post, 2) AS post_avg_weight
    FROM likes
    WINDOW per_post  AS (PARTITION BY post_id),
           post_time AS (PARTITION BY post_id ORDER BY liked_at, like_id)
)
SELECT
    n.*,
    dwell_ms - previous_dwell_ms AS DifferenceinDwell,
    scroll_depth - previous_scroll_depth AS differenceInScrollDepth,
    weight - previous_weight AS differenceInWeight
FROM laglead AS n
WHERE post_id = 10
ORDER BY liked_at, like_id;


---Part B Cumulative and smoothed: how is the platform doing over time, 
---both in total and recent average 
WITH daily AS (
    SELECT
        liked_at AS day,
        COUNT(*) AS recorded_likes,
        SUM(dwell_ms) AS total_dwell_ms,
        SUM(scroll_depth) AS total_scroll_depth,
        SUM(weight) AS total_weight
    FROM likes
    WHERE liked_at >= DATE '2023-10-01'
      AND liked_at <  DATE '2024-01-01'
    GROUP BY liked_at
)
SELECT
    day,
    recorded_likes,
    SUM(recorded_likes) OVER qtd AS allLikes,
    200 as targetLikes,
    ROUND(100.0 * SUM(recorded_likes) OVER qtd / 50, 2) AS pct_of_target,
    ROUND(AVG(recorded_likes) OVER recent, 2) AS avg_likes_per_active_day,
    ROUND(SUM(total_dwell_ms) OVER recent / SUM(recorded_likes) OVER recent, 2)
        AS avg_dwell_ms_last_7,
    ROUND(SUM(total_scroll_depth) OVER recent / SUM(recorded_likes) OVER recent, 2)
        AS avg_scroll_depth_last_7,
    ROUND(SUM(total_weight) OVER recent / SUM(recorded_likes) OVER recent, 2)
        AS avg_weight_last_7
FROM daily
WINDOW
    qtd AS (ORDER BY day ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
    recent AS (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
ORDER BY day;

----Part C 
WITH likes_compared AS (
    SELECT
        post_id,
        liked_at,
        LAG(liked_at) OVER (
            PARTITION BY post_id
            ORDER BY liked_at, like_id
        ) AS previous_liked_at
    FROM likes
), gaps AS (
    SELECT
        post_id,
        previous_liked_at,
        liked_at AS resumed_at,
        liked_at - previous_liked_at AS GapBetweenLikeDates
    FROM likes_compared

)
SELECT
    g.post_id,
    g.previous_liked_at,
    g.resumed_at,
    g.GapBetweenLikeDates,
    (
        SELECT COUNT(*)
        FROM likes AS l
        WHERE l.post_id <> g.post_id
          AND l.liked_at > g.previous_liked_at
          AND l.liked_at < g.resumed_at
    ) AS other_likes_during_gap
FROM gaps AS g
WHERE g.GapBetweenLikeDates >= INTERVAL '90 days'
ORDER BY g.GapBetweenLikeDates DESC, g.post_id
LIMIT 1;

