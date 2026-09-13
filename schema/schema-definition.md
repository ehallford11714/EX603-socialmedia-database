## Task 1.1 All relation schemas and their attributes, domains and primary keys 

The following relations were created 
users, posts, likes, hashtags, dwell and junction relation post_hashtags to reflect the basics of a social media platform. 
A user can create an account with a user name and update their username at some date with updated_at. The user can create posts 
and those posts can be liked by other users.The user can use hashtags in their posts and the dwell time of a user is tracked on each post. 


#Users
users schema has the following attributes:
user_id 
user_name
created_at
updated_at 

The primary key for the user relation is user_id. 
The domain for each attribute are BigInt for user_id
var for user_name
timestamp for created_at 
timestamp for updated_at 

#Posts 
Posts schema has the following attributes: 
post_id 
post_text 
post_created_at
post_updated_at

The primary key for the posts are post_id. 
The domains for each attribute:
Big Int for post_id
varchar for post_text
timestamp for post_created_at
timestamp for post_updated_at 

#Likes 
the relation likes has the following attributes to represent how often a post is liked. 
like_id
post_id
user_id
created_at 

The primary key is like_id to take each distinct like. 
The domains for each attribute: 

BigInt for like_id
BigInt for post_id
BigInt for user_id
timestamp for created_at

#hash_tag 
The following attribues were created for the hash_tag relation 

hashtag_id 
hashtag_text 
hashtag_created_at

The primary key is hashtag_id 

the domains for each of the attributes:
hastag_id is BigInt
hashtag_text is varchar 
hashtag_created_at is timestamp 

#post_hashtag 

post_hashtag is a junctionr relation that relates the posts to the hashtags.

The primary key is post_id. 
It has attributes post_id and hashtag_id 
the domain for both attributes is BigInt.


#dwell 
Dwell is the relation to capture how long a user stays on a post. 
The attributes are the 
dwell_id
post_id
user_id
dwell_ms 

dwell_id is the primary key.
the attributes are 
dwell_id
post_id
user_id
dwell_ms 

the domains for all 4 is BigInt. 

