--Task 5.2 Find records that may exclude
--PART A Write two queries that return all producers, including those that never had an event
select a.post_id, b.like_id from posts a
left join likes b
on a.post_id = b.post_id;

select a.post_id, b.like_id from posts a
inner join likes b
on a.post_id = b.post_id;

--PART B
--1. Explore right JOIN
select b.post_id, a.like_id from likes a
right join posts b
on a.post_id = b.post_id;

--2. FULL outer JOIN
select a.post_id, b.like_id from posts a
full outer join likes b
on a.post_id = b.post_id;


--Part C
--Write two queries that identify producers that never had an event and compare them

SELECT a.post_id
FROM posts AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM likes AS l
    WHERE l.post_id = a.post_id
);

--Using EXCEPT
select a.post_id from posts a except
                            select post_id from likes;
