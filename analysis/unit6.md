# Analysis of Unit 6 

## Task 6.1 
Question 1: We need each row shown beside the group average to do the comparison. If we do not have it
and only have the group by we can't see how the group average has behaved. 

Question 2: a Platform that is interested in the ordered rank of the dimensions would be for a leaderboard to track the most liked posts with dense rank. Top featured posts to just show the oredered posts that appear. Rank would just what posts occur with ties given the same weight. 

# Task 6.2 

Question 1: Large delta would suggest that there are record removals on the site look to see there is an issue with tracking engagement 

Question 2: A Running total shows how the likes accumulated whereas the sum just shows how to recorded likes. It shows how likes build over a period of time 

Question 3: We choose seven rather than daily because there can be big moves day to day and providing a 7 week period we have a more stable comparison period. 

Question 4: The gap means that there is a large span in where there are consecutive likes on the platform. This could mean that the specific post might not have been visible to the platform or there was issues with this post visibility. It could be a specific platform problem or a data quality problem. It should prompt further investigation. 


# Task 6.3 

Question 1: We could build a dashboard showing the highest ranked reactions and the lonest dwell times. If we only showed 1 it owuld hide the distribution if would showed 10 it would show every reaction. 

Question 2: A large month to month change would mean that some issue might exist in the underlying data. A large drop in dwelling time should be investigated as a data qualtiy issue. 



# Reflection 

In the case of the group by, it omits the current rows and doesn't allow cross comparison, but keeping the window partitions we can see rows toegther and do the comparison. This allows us to track the progress and running total over time and look at period over rperiod comparisons. This would give us a better understanding of the system and reduce the overhead to run queries in isolation. 

A specific reporting question in our theme that would be impossible with group by is specifically looking at period over time and comparing YoY growth, which a group by would not enable. If wanted to see Month on month or year on year, we can compose queries that accomplish this task. 

Window partitions enable us to build more complex queries and they allow us to compare window fields together.




