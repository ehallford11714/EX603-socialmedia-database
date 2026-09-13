# Task 1.4 Write up your reasoning 

# Modelling justification 

When desinging these specifications, we selected that each of the constructs would be there relation to create track of their unique id, so that we might be able to easily additional metadata as is required. By using this normalized structure, it allows us to easily scaled descriptions, make changes to underlying schema and add and remove records without breaking the underlying relationships. In that case, we have users, posts, likes, hashtags, a junction table with hashtags and posts and dwell. 

The following relations were created. 

Users, Posts, Likes, Hashtags, Post_hashtags, Dwell 
Each specific table has a unique id that must be populated. Therefore constraint NOT NULL exists in all records to be added. 
Each table has a timestamp for when the records were created and updated time stamp if any change is made. This structure allows the metadata and any additional changes we make in the future. The referential integrity on the foreign keys by adding constraints explicitly in the schema ensures that records cannot be entered into unless they exist in the other tables. In this case, we don't add orphaned values into likes for example, if it doesn't have an associated post id and and posts if it doesn't have a user that made that post. 

In addition, by creating the juction table we allow many to many relationships between hashtags and posts. 

There is a 1 to many relationship between user and posts. 1 to many relationship between posts and likes. 1 to many relationships. By adding in these factors, we can model effectively. 

The NOT NULL and unique characterstic user ensures that all users will be unique and populated when added, this is to ensure that only the we don't need to issues where we have multiple user_ids mapped to different posts. 

Additional attributes can be added to a model design which are requierd as the need arises. 

In additional, the on delete behaviors for each are discussed below: 

Users
ON delete set behavior set to NULL to ensure that posts aren't deleted. So for example if a user is deleted, all their associated posts and likes are also deleted and not orphaned. 
Posts 
On Delete set behavior set to CASCADE to delete any associated likes on that post 

Likes 
on DELETE Set behavior to SET NULL to prevent post from being deleted if the like is deleted. 

Hashtags 
on Delete set behavior to CASCADE to ensure that any post hashtag is deleted as composite. 

Post_hashtags 
on delete set null to ensure that any post remains if the hashtag is deleted 

Dwell 
on delete set null to ensure that any post remains if dwell time is deleted. 

These behaviors allow us to delete records to maintain data integrity and ensure there is no data loss. 

# Reflection 

The following design was based on the specifications of the social media platform to create posts, like other people's posts, and add hashtags and record the dwell time on each post. However, dwell time could have been an attribute itself on posts. We keep it solely by its post_id as foreign key but a different designer might add dwell_id directly as a foreign key on posts. Dwell time allows further metadata to store specifically about it and hence that decision was made to store as it own relation. We specifically chose to store posts as its id for each. I think generally this was the best approach to ensure that every table has a unique candidate key to join on other tables if that is necessary. People might have different naming convention for the keys but generating just making sure the relation is named _id ensure that we can keep track of the underlying relationship. we also kept created_at and updated_at to ensure if there's any change to the table. Someone may create distinct change table to store all metadata changes directly and not specifiy the changes within the table themselves and just reference the change_id on that change transaction table. In this we ensured that the relation is retained. I also added schema constraints in the SQL that way the referential integrity can prevent rows from being written when they don't exist in the other table. For example, a like must have post_id already present in order for it to be liked. 

