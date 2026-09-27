# Task 2.2: Write up your reasoning

# Reasoning and changes made

The underyling schema was changed to allow for distinct sessions. Previously, the schema stored the relationship of dwell by dwell_id. However, when considering if there is multiple times they come, there wouldn't be distinct method to determine how much time they dwell. Therefore, sessions was added as a table to keep track of distinct sessions a user has and those sessions then correspond to the amount of time they dwell. In those instances, dwell is now modeled session_id and post_id. Sessions store the entire session a user has on the platform when they first enter and then exit. We can then track the dwell time on each post through these sessions.

Some of the schema was also changed wuth delete behavior. We set constraints that no field would be capable of being NULL except user_id on posts for set null behavior. We also changed the remove Set NUll on Likes since this is already a child record and it won't affect it's parent record posts.

# Constraints Table 


| Foreign key | ON DELETE choice | Reason |
|---|---|---|
| `POSTS.user_id` references `USERS.user_id` | `SET NULL` | when a person deletes their user, their posts should still remain.  |
| `SESSIONS.user_id` references `USERS.user_id` | `CASCADE` | Deleting a user should delete all their sessions. |
| `LIKES.user_id` references `USERS.user_id` | `CASCADE` | Deleting a user should delete all of their likes. |
| `LIKES.post_id` references `POSTS.post_id` | `CASCADE` |  Deleting a post should remove all of its likes. |
| `DWELL.session_id` references `SESSIONS.session_id` | `CASCADE` | Deleting a session should remove all of its dwelling time. |
| `DWELL.post_id` references `POSTS.post_id` | `CASCADE` | Deleting a post should remove how its dwelling time. |
| `POST_HASHTAG.post_id` references `POSTS.post_id` | `CASCADE` | Deleting a post should remove any hashtag associations with it. |
| `POST_HASHTAG.hashtag_id` references `HASHTAGS.hashtag_id` | `CASCADE` | Deleting a hashtag should remove its hashtag while keeping the posts |

When a user deletes their account the posts that they created should still be visible on the platform. However, when htey deleete their session, all of their details about the dwell time should also be removed. Likewise, with posts all of its likes should be removed. All of its posts dwell time shoul dalso be removed. The post deletion should also trigger any hashtag associations with it. If we didn't remove these child interactions, we would have orphaned records of likes that have no posts, dwell time that have no sessions and hashtag assocations that have no hashtags. 

# Check Constraints 

The following check constraints exist. 

| Table | Check Constraint | Reason 
|---|---|---|
|Users | username <> '' | username should not be an empty string| 
| Posts | length(btrim(post_text) > 0) | posts should not be empty strings. |
| Hashtag | hashtag_text <> '' | hashtags should not be empty strings. 
| DWELL | dwell_ms > 0 | a person must have dwelled on a post for more than 0 ms 

If these values aren't true, they wouldn't be allowed to enter the database. If we have 0 ms we can't properly find out how long someone dwells, this way it catches it before hand. 
Someone always will dwell moment they come to the platform.
Users cannot leave their username empty or blank and they can't create blank posts or hashtags and so these values are just not permitted to enter the database. 




