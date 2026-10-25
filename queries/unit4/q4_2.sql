
----4.2a Build Breakdown leadership
----Breakdown of reasons for removal of posts
-----Includes total of events, the removed posts, and then a breakdown of each reason across spam, user requests, duplicate reactions
select count(*) as totalEvents,
       sum(case when removal_reason in ('Spam Detected','User request','Policy violation','Duplicate reaction') then 1 else 0 end) as removedPost,
       sum(case when removal_reason = 'Spam detected' then 1 else 0 end) as countSpam,
       sum(case when removal_reason = 'User request' then 1 else 0 end) as countUserRequestRemoval,
       sum(case when removal_reason = 'Policy violation' then 1 else 0 end) as countViolation,
       sum(case when removal_reason = 'Duplicate reaction' then 1 else 0 end) as countDuplicateReaction

    from likes;

---4.2b subtotal and total of all statistics


---Grand Total and region breakout subtotals. First column is Grand Total
select  CASE
        WHEN GROUPING(client_country) = 1 THEN 'Grand Total'
        ELSE COALESCE(client_country, 'Unknown country')
    END AS region,
    client_country,count(*) as countEvents, avg(dwell_ms) as avgDwellTime,
       avg(likes.scroll_depth) as avgScrollDepth,
       avg(weight) as averagePostWeight
       from likes
group by  CUBE(client_country)
order by grouping(client_country);
----PART C TWO-STEP PIPELINE
--With CLAUSE producing intermediate aggregate
--second aggregation producing filter

WITH postStats as (
select a.post_id,count(*) as countEvents, avg(dwell_ms) as avgDwellTime,
       avg(a.scroll_depth) as avgScrollDepth,
       avg(weight) as averagePostWeight,
       avg(like_count) as avgLikes

       from likes a
       join posts b
       on a.post_id = b.post_id
group by a.post_id
)

select post_id, countEvents, avgDwellTime, avgScrollDepth, averagePostWeight  from postStats
where avgLikes > 100
order by countEvents desc;
