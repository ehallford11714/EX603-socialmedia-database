---Assignment 3.2a
--Pick a nullable column on your event or producer table. If the dataset has no NULLs in it, insert a few deliberately and say that you did.
---Write a query with a negation or inequality predicate on that column — for example WHERE status != 'completed' — and record the row count it returns.


---PART A
select count(removal_reason) as CountNotSpam
from likes
where removaL_reason != 'Spam detected';


select count(*) as CountNotSpam from likes where removal_reason != 'Spam detected' or removal_reason is null;

SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN removal_reason != 'Spam detected' THEN 1 END) AS ErrorIssue,
    count(CASE WHEN removal_reason = 'Spam detected' then 1 END) as spamInTable
FROM likes;

---fix the query
select like_id,user_id, coalesce(removal_reason,'no reason')
from likes where removal_reason != 'Spam detected' or removal_reason is null;

---PART B
---query with broken alias
select post_id, posted_on,author_country as authorCountry from posts where authorCountry = 'Brazil';

---Two correct Rewrites: first CTE
with authors as (
    select
    post_id, posted_on, author_country as authorCountry
    from posts
    )

    select  post_id, posted_on, authorCountry from authors;
--subquery

select post_id, posted_on, authorCountry from
(select post_id, posted_on, author_country as authorCountry from posts) post

