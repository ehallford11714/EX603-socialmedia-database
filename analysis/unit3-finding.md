##Unit 3 Analysis of The disputed situation 


###Where the error originates from 

The dashboard showed disputed events and likes that were removed. However, due to failure to account for unknown values, this resulted in an inaccurate results. 
The error originates from the fact that there exists three ways data can represented in a database. These three mechanisms are true, false or unknown. In this case, we have data that is failing to show up in the dashboard since they are not correctly being captured because one of these conditions is failing. However, the data is populated, it just is null for some of these records. 

As a general solution, we need to add condition to handle these unknown values and allow them to flow back into the dashboard so our data is accurate. Going forward, it is important that we keep in mind what records can be potentially omitted from our dashboard. 

