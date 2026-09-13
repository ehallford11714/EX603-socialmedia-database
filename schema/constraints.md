# Task 1.3 Constraints for Social Media Platform 

The following constraints are for the following relations: 

# Users
 User ids should be UNIQUE and NOT NULL to ensure that every
 user cannot be entered into the database as a null value. Delete behavior should be CASCADE to ensure all users post are also deleted if user is deleted. 

# Posts 
Posts have a foreign key on users so that a user can create a post on user_id referencing users. Posts should be CASCADE to delete associate likes to that post. 

# Likes
like_id will have not null on like_id to ensure its populated, have a foreign key on user_id referencing users and foreign key on post_id referencing posts and delete behavior set null to prevent post being deleted if like is removed. 


# Hashtags 
hashtag have a not NULL on hastag text, not null on hashtag text and not null on created_at. delete behavior SET NULL from being deleting the posts.

# post_hashtags
It has foreign key on post_id and foreign key on hashtag_id 
It has has not null on both candidate keys 

# Dwell 
It has a foreign key on post_id referencing posts and a foreign key on user_id referencing users. Dwell_id is also NOT NULL to ensure its always populated. Delete behavior set null to prevent post from being deleted.
