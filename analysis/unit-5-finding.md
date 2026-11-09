## The Memo 

Some groups fail to acquire likes or have all their likes removed. Some posts in general are just spam and therefore use bot farms to pump up their likes and views. Building systems that can address these challenges is central to combating spam and other issues with our social media platform. In these instances, we should build in queries to identify where posts do not have any events and identify them appropriately and then also flag posts that have Policy Violations or other terms of service issues. In this way, we can ensure that our system can handle requests and report the underlying data accurately. Devleoping a tiered quality control system and mechanism to monitor these things can help us identify 1) when these fail, 2) why they fail 3) turnover time and lead to better improved system reliability. 


It is also important to monitor it at the query level to ensure that analysts that report on these results or build features and tools reflect the actual data. Escalation protocols and other strategies can help mitigate these comncerns and help us lead to accurate systems and reliable reporting. 



## Reflection 

In this case of our initial query, it used a hash join. Hash join can match post id quickly when data is unsorted. If there were very for posts or likes that were indexed, then a nested loop would be used as this would be more efficient. If both of the systems were large, merge join would be effective. Databases make decisions based on the query complexity and build out their plans to spend the least amount of resources to accomplish the query. 

It also suggests that the query itself should be designed to work alongside this as well to optimize and ensure that the cost for each specific element is maximized appropriately. 
Building out these we can ensure that our systems are robust and don't sequester too many resources especially as systems scale. It's not necessary often to bring in all data. 

Least data we need to answer our question should always be the goal. 
