USE x_db;

-- 1. Posts with Total Likes
SELECT
    p.post_id,
    p.content,
    COUNT(l.user_id) AS total_likes
FROM posts p
LEFT JOIN likes l
    ON p.post_id = l.post_id
GROUP BY p.post_id, p.content
ORDER BY total_likes DESC;


-- 2. Posts with Author Information
SELECT
    p.post_id,
    pr.username,
    pr.display_name,
    p.content,
    p.created_at
FROM posts p
JOIN profiles pr
    ON p.user_id = pr.user_id
ORDER BY p.created_at DESC;


-- 3. Total Posts per User
SELECT
    pr.username,
    pr.display_name,
    COUNT(p.post_id) AS total_posts
FROM profiles pr
LEFT JOIN posts p
    ON pr.user_id = p.user_id
GROUP BY
    pr.user_id,
    pr.username,
    pr.display_name
ORDER BY total_posts DESC;


-- 4. Total Followers per User
SELECT
    p.username,
    p.display_name,
    COUNT(f.follower_id) AS total_followers
FROM profiles p
LEFT JOIN follows f
    ON p.user_id = f.following_id
GROUP BY
    p.user_id,
    p.username,
    p.display_name
ORDER BY total_followers DESC, p.username ASC;


-- 5. Total Following per User
SELECT
    p.username,
    COUNT(f.following_id) AS total_following
FROM profiles p
LEFT JOIN follows f
    ON p.user_id = f.follower_id
GROUP BY
    p.user_id,
    p.username
ORDER BY total_following DESC;


-- 6. Overall User Analytics
SELECT
    pr.username,

    (SELECT COUNT(*)
     FROM posts p
     WHERE p.user_id = pr.user_id) AS total_posts,

    (SELECT COUNT(*)
     FROM follows f
     WHERE f.following_id = pr.user_id) AS total_followers,

    (SELECT COUNT(*)
     FROM follows f
     WHERE f.follower_id = pr.user_id) AS total_following,

    (SELECT COUNT(*)
     FROM likes l
     JOIN posts p ON p.post_id = l.post_id
     WHERE p.user_id = pr.user_id) AS total_likes_received

FROM profiles pr
ORDER BY total_followers DESC;
