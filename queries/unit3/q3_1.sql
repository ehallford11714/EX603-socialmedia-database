--Assignment 3.1a Find all highly rated producers with theme filter
select post_id,post_title,like_count
from posts
where like_count > 100 and is_visible = true
order by like_count DESC
limit 10;

--Assignment 3.1b
--Find all possible event statuses. Display the distinct values in the event status column. Look carefully at the results. Are there more statuses than you expected?
select distinct reaction_status from likes;
--There are 3 that some may be removed.

--Assignment 3.1c
---Filter the events in two different ways. Write: one query that filters a numeric range, and one query that filters using an explicit list of values with IN.
select like_id,user_id,post_id,dwell_ms,reaction_status from likes where dwell_ms > 2500
order by dwell_ms DESC;
select like_id,user_id,post_id,reaction_status from likes where reaction_status in ('active','flagged');

--Assignment 3.1d
---Work with text and missing values. Write queries that: find producers whose names match a text pattern using LIKE, and identify
-- records where a reason/value is missing (NULL). Use COALESCE to replace a missing value with a useful label such as: No reason provided.

---using like on text pattern in post_title
select post_id,post_title from posts where post_title ilike '%01%';

---identifying null records in table
select like_id,user_id,post_id,liked_at,unliked_at,client_country,dwell_ms,scroll_depth,reaction_status,removal_reason from likes
where removal_reason is null;

--COLASECE null records with no reason
---identifying null records in table
select like_id,user_id,post_id,liked_at,unliked_at,client_country,dwell_ms,scroll_depth,reaction_status,COALesce(removal_reason,'no reason') from likes
where removal_reason is null;

---Assignnment 3.1e
---Make the results easier to understand. Create a query with calculated/computed columns that would make sense to someone who does not work with SQL. Depending on your theme, you might calculate or label:

select like_id,avg(dwell_ms) as AverageTimeDwellingOnLike from likes group by 1 ORDER BY avg(dwell_ms) DESC;