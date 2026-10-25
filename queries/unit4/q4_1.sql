---Stats about the posts
---1A

select
    count(*) as totalPosts,
    count(distinct likes.user_id) as distinctUsers,
    min(like_count) as minLikes,
    max(like_count) as maxLikes,
    avg(like_count) as avgLikes,
    min(dwell_ms) as minDwellTime,
    max(dwell_ms) as maxDwellTime,
    avg(dwell_ms) as avgDwellTime,
    min(scroll_depth) as minScrollDepth,
    max(scroll_depth) as maxScrollDepth,
    avg(scroll_depth) as avgScrollDepth,
    min(weight) as minWeight,
    max(weight) as maxWeight,
    avg(weight) as avgWeight

from posts
join likes
on posts.post_id = likes.post_id;
---1B

---1B
---Stats per each post
select post_id, count(*) as countEvents, avg(dwell_ms) as avgDwellTime,
       avg(likes.scroll_depth) as avgScrollDepth,
       avg(weight) as averagePostWeight
       from likes
    group by post_id
order by countEvents desc;

---1C Having a threshold -- need to have at minimum 10 in order to have valid statitiscs
---Stats
select post_id, count(*) as countEvents, avg(dwell_ms) as avgDwellTime,
       avg(likes.scroll_depth) as avgScrollDepth,
       avg(weight) as averagePostWeight
       from likes
    group by post_id
    having count(*) > 10
order by countEvents desc;


---1D  BREAKOUT BY CLIENT COUNTRY
select  client_country,reaction_status, count(*) as countEvents, avg(dwell_ms) as avgDwellTime,
       avg(likes.scroll_depth) as avgScrollDepth,
       avg(weight) as averagePostWeight
       from likes
group by  client_country,reaction_status
order by countEvents desc;
