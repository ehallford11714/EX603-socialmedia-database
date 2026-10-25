# Task 4.1 Writeup 
## Name the person who would act on the per-producer breakdown, and say what the aggregate hides — an average conceals its distribution, a count conceals who is counted. What would you need to see next?

The aggregation hides posts where the user doesn't scroll towards the entire length and it also weights according to high volume producers that shifts the distribution towards whatever the high volume is. This may lead to wrong conclusions so someone interested to see how individual platforms perform they would be interested in the individual post metrics to assess how they perform overall. The counts appear to mostly come from high volume so it might hide to see how volume and high averages contribute to the underlying averages.

# Task 4.2 Writeup 

## Part A, state the two questions your conditional aggregation answers side by side.

The following conditional aggregation stores how many events there are for the following posts, it also stroes the posts that were removed and the associated reasons for why they were removed. 

## For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not.

The user that needs subtotals would be someone interested in how the audiences performs overall within a region and how that varies and if there are differences from one region to another. 

## For Part C, state the question the pipeline answers.

Higher volume producers contribute a higher dwell time than the overall posts. By specifically filtering for these metrics we can see that on average, higher volume posts have larger volumes. 