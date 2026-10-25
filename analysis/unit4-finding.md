# Unit 4 Finding for Leadership 

## Breakdown of what was found in our analysis 

We investigated the overall metrics from a social media platform. The following findings were found specifically that more 22/200 posts were removed or 11% of the posts due to a variety of different reasons. 
The highest volume reason was due to spam followed by policy violations. Therefore, a system its important to keep track of the posts that either violate the platform and compute statistics appropriately to prevent wrong conclusions. 

I would investigate posts that have been flagged specifically as scam and identify if there are any features that can be used to automatically flag these to allow the metrics to be a true representation of behavior on the platform and not be skewed by these outlier events. 

# Reflection 

If we ran filtered queries over the sets by removing posts that were removed, it would give a better representation of the behavior on the system. In addition, high volume posts contribute to the a lot of the statistics by pulling up the averages or pulling them downd epending upon their contributions. At a million rows, we can see that have extreme outliers can skew our daata and lead to wrong conclusions. 

In practice, outlier and anamoly detection can create a system that can catch these events and lead to two different metrics -- the overall platform and then a cleansed dataset with these outliers and policy violations removed. By creaitng these two different aggregation patterns, we can identify how different cohorts behave and have a moer complete picture of how the system is functioning. 

In our specific study, we have looked at scroll depth, weight of the posts, likes as well as dwell time. Further analysis could identify if there is a relationship between this and the amount of likes a post receives. Deeper analysis can be unlocked by drilling down across different segmentation cohorts and deepen our understanding of the system. 