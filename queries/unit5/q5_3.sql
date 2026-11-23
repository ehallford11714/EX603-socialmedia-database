--Task 5.3 Understanding Join performacne and execution plans 

---Explore CROSS JOIN 
---We will write a cross join between two small tables 


SELECT
    p.post_id,
    p.post_title,
    c.client_country,
    COUNT(l.post_id) AS posts_liked
FROM posts AS p
CROSS JOIN (
    SELECT DISTINCT client_country
    FROM likes
    WHERE client_country IS NOT NULL
) AS c
LEFT JOIN likes AS l
    ON l.post_id = p.post_id
   AND l.client_country = c.client_country
GROUP BY
    p.post_id,
    p.post_title,
    c.client_country
ORDER BY
    p.post_id,
    posts_liked DESC;