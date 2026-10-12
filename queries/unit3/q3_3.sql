---Assignment 3.3a Express actors are involved in disputed events. 

---a First as subquery using in or not in 


select user_id,user_name
from users where user_id in
(select user_id from likes where reaction_status = 'flagged' )



---b Then as a CTE with
with reactionStatus as (
    select user_id,reaction_status
    from likes
    where reaction_status = 'flagged'
)
select distinct a.user_id, a.user_name,reactionStatus.reaction_status from users a
inner join reactionStatus
on reactionStatus.user_id = a.user_id

---c third way, using case based construction or set-based approach

    SELECT
    a.user_id,
    a.user_name

FROM users a
WHERE EXISTS (
    SELECT 1
    FROM likes l
    WHERE l.user_id = a.user_id
      AND l.reaction_status = 'flagged'
);



---d write query to demonstrate they all equal share same result 
WITH CheckAllSame AS (
    -- subquery
    SELECT user_id, user_name, 'Method A' AS query_source
    FROM users 
    WHERE user_id IN (SELECT user_id FROM likes WHERE reaction_status = 'flagged')
    
    UNION ALL
    
    -- CTE
    SELECT DISTINCT a.user_id, a.user_name, 'Method B' AS query_source 
    FROM users a
    INNER JOIN likes l ON l.user_id = a.user_id
    WHERE l.reaction_status = 'flagged'
    
    UNION ALL
    
    -- exists
    SELECT a.user_id, a.user_name, 'Method C' AS query_source
    FROM users a
    WHERE EXISTS (
        SELECT 1 FROM likes l 
        WHERE l.user_id = a.user_id AND l.reaction_status = 'flagged'
    )
)
SELECT 
    user_id, 
    user_name,
    COUNT(*) AS countRecords
FROM CheckAllSame
GROUP BY 
    user_id, 
    user_name


----e name one input condition that three would not be equaivalent 

---The condition in which they break is if the reaction status is null due to the 3 value condition, it will end up ommitting the null values. 
