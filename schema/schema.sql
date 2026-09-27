-- =================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Social Media Database
-- Author: Ephraim Hallford
-- Target: PostgreSQL 14+
-- =================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.

DROP TABLE IF EXISTS POST_HASHTAG CASCADE;
DROP TABLE IF EXISTS DWELL CASCADE;
DROP TABLE IF EXISTS LIKES CASCADE;
DROP TABLE IF EXISTS HASHTAGS CASCADE;
DROP TABLE IF EXISTS SESSIONS CASCADE;
DROP TABLE IF EXISTS POSTS CASCADE;
DROP TABLE IF EXISTS USERS CASCADE;


--User table is created first since it doesn't have any dependencies.
CREATE TABLE USERS (
    user_id INTEGER GENERATED ALWAYS AS IDENTITY,
    user_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT pk_users_id PRIMARY KEY (user_id),
    CONSTRAINT uq_users_name UNIQUE (user_name),
    CONSTRAINT chk_user_name_empty CHECK (user_name <> '')
);



--Sessions only rely on users and therefore it should be created next.
CREATE TABLE SESSIONS (
    session_id INTEGER GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER NOT NULL,
    started_at TIMESTAMP NOT NULL,
    ended_at TIMESTAMP,
    CONSTRAINT pk_sessions_session_id PRIMARY KEY (session_id),
    CONSTRAINT fk_sessions_user_id FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- Posts should be created next since likes, hashtags, and dwell all depend on it.
CREATE TABLE POSTS (
    post_id INTEGER GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER ,
    post_text TEXT NOT NULL,
    post_created_at TIMESTAMP NOT NULL,
    post_updated_at TIMESTAMP NOT NULL,
    CONSTRAINT pk_posts_post_id PRIMARY KEY (post_id),
    CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE SET NULL,
    CONSTRAINT chk_posts_post_empty CHECK (length(btrim(post_text)) > 0)
);

--Hashtags can be created next because there is no dependency.
CREATE TABLE HASHTAGS (
    hashtag_id INTEGER GENERATED ALWAYS AS IDENTITY,
    hashtag_text VARCHAR(255) NOT NULL,
    hashtag_created_at TIMESTAMP NOT NULL,
    CONSTRAINT pk_hashtags_hashtag_id PRIMARY KEY (hashtag_id),
    CONSTRAINT uq_hashtags_hashtag_text UNIQUE (hashtag_text),
    CONSTRAINT chk_hashtags_hashtag_text_nonempty CHECK (hashtag_text <> '')
);


-- Likes must be created after posts and users since they both depend on those tables.
CREATE TABLE LIKES (
    like_id INTEGER GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT pk_likes_like_id PRIMARY KEY (like_id),
    CONSTRAINT fk_likes_user_id FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_likes_post_id FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    CONSTRAINT uq_likes_user_post UNIQUE (user_id, post_id)
);

--Dwell must be created after posts and users as they both depend on users and posts.
CREATE TABLE DWELL (
    session_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    dwell_ms BIGINT NOT NULL,
    CONSTRAINT pk_dwell PRIMARY KEY (session_id, post_id),
    CONSTRAINT fk_dwell_session_id FOREIGN KEY (session_id) REFERENCES SESSIONS(session_id) ON DELETE CASCADE,
    CONSTRAINT fk_dwell_post_id FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    CONSTRAINT chk_dwell_nonnegative CHECK (dwell_ms >= 0)
);


--Post hash tag must be created after posts and hashtags as they both depend on those tables.
CREATE TABLE POST_HASHTAG (
    post_id INTEGER NOT NULL,
    hashtag_id INTEGER NOT NULL,
    CONSTRAINT pk_post_hashtag PRIMARY KEY (post_id, hashtag_id),
    CONSTRAINT fk_post_hashtag_post_id FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    CONSTRAINT fk_post_hashtag_id FOREIGN KEY (hashtag_id) REFERENCES HASHTAGS(hashtag_id) ON DELETE CASCADE
);
