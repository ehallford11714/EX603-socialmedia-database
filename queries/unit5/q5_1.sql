---question 1 Who are the people behind the events 
select d.user_id, a.like_id, c.post_id, a.liked_at 
from likes a 
join posts c 
on a.post_id = c.post_id 
join users d on 
a.user_id = d.user_id 

--Question 2: Do the producers identified in assignemnt 4 share catalog 
--credentials 

select posts.post_id,hashtags.hashtag_id,hashtags.hashtag_description

from posts
join post_hashtags on posts.post_id = post_hashtags.post_id 
join hashtags on post_hashtags.hashtag_id = hashtags.hashtag_id

---question 3: self join on producers 

--Q3 Explore post before and after each other within country if there is incresae in engagment within country

SELECT
    p1.post_id,
    p1.post_title,
    p1.author_country,
    p1.posted_on,
    p1.like_count,
    p2.post_id AS other_post_id,
    p2.post_title AS other_post_title,
    p2.posted_on AS other_post_date,
    p2.like_count AS other_post_likes,
    p2.like_count - p1.like_count AS likes_difference,
    CASE
        WHEN p2.posted_on < p1.posted_on THEN 'Before'
        WHEN p2.posted_on > p1.posted_on THEN 'After'
        WHEN p2.posted_on = p1.posted_on THEN 'Same date'
        ELSE 'Unknown date'
    END AS posting_order
FROM posts AS p1
JOIN posts AS p2
    ON p1.author_country = p2.author_country
   AND p1.post_id <> p2.post_id
ORDER BY
    p1.author_country,
    p1.posted_on,
    p1.post_id,
    p2.posted_on;


