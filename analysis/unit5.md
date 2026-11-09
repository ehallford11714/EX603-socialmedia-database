# Task 5.1 Connect Producers to Their Data

## What feature or report on your platform could use the three-table join from Question 1? What information would it display?
A dashboard that specifically liked a post for an analytics dashboard within the application. This could allow people to monitor how their system is performing over time. It can also assess the overall time that each specific post. It would display the person who liked a post, the event id and the post and the time of the like. 

## Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?
The junction table is important because hashtags is a many to many relationship in which posts can have many hashtags and those descriptions are not easy to join without a junction table. The junction table simplifies the query that we need to and allows us to evaluate what hashtags are associated with each post. 

# Task 5.2 Find Records That Joins May Exclude
## Which producers were excluded by the inner join? Report their identifiers.
post_id 15 and post_14 were excluded by the inner join. 


## What does it mean when a producer has no events? What are some possible explanations?
It doesn't have any like for that post in this case or it could have been removed by some reason. 
## How could a report based only on an inner join give leadership an incomplete picture of the platform?
A report based on an inner join can drop records and lead to innaccurate count about the specific metric. 
## Why might leadership want to identify producers who have never been active?
Leadership might want to remove these producers from the platform as they represent a bot or some spam account or might be an account that was accidently created. In order to keep track of these elements and to diagnose the reasons, leadership can quickly identify the cause and make the decision to remove users or accounts that might be skewing percentages or other metrics in reporting. 
## What action could leadership take based on these findings?
They could either deactivate these accounts or they can identify the cause for why there's no activity that might be some underlying bug perhaps with the software that is not properly tracking. But the first step is triaging these and identifying their cause. 

# Task 5.3  Understand Join Performance and Execution Plans

# Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.
The cartesian product we saw was looking at likes across country for each post. In some cases, you can accomplish the same thing with more joins. 
# Which join algorithms did PostgreSQL choose for your query?
Hash Join
# What information in the execution plan helps explain those choices?
The id that is using the equivalence check as hash joins using equivelence check when running the query. 
# Why is it useful to understand the selected join algorithms?
It helps you understand how the SQL server is choosing to execute the query and the method it is using to do so. 
# What changes to the data or database might make another join algorithm more appropriate?
If the data scales, or the database is not indexed it can change the impact. In such instances, another algorithm might be appropriate.