---Each event by its producers average

SELECT
    l.*,
    AVG(l.dwell_ms) OVER (PARTITION BY l.post_id) AS post_avg_dwell_ms
FROM likes AS l
ORDER BY l.post_id, l.like_id;

-- Q1b. Group nby post id without partition
SELECT
    post_id,
    AVG(dwell_ms) AS dwell_time_avg
FROM likes
GROUP BY post_id
ORDER BY post_id, dwell_time_avg DESC;





---Rank the likes in three ways 
WITH post_counts AS (
    SELECT p.post_id, p.post_title, COUNT(l.like_id) AS event_count
    FROM posts AS p
    LEFT JOIN likes AS l ON l.post_id = p.post_id
    GROUP BY p.post_id, p.post_title
)
SELECT
    post_id,
    post_title,
    event_count,
    ROW_NUMBER() OVER (ORDER BY event_count DESC, post_id) AS RowNumber,
    RANK()       OVER (ORDER BY event_count DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY event_count DESC) AS denseRank
FROM post_counts
ORDER BY RowNumber;


--Do by NTILE 
SELECT
    p.post_id,
    p.post_title,
    COUNT(l.like_id) AS event_count,
    NTILE(4) OVER (ORDER BY COUNT(l.like_id) DESC, p.post_id) AS band
FROM posts AS p
LEFT JOIN likes AS l ON l.post_id = p.post_id
GROUP BY p.post_id, p.post_title
ORDER BY event_count DESC, p.post_id;
