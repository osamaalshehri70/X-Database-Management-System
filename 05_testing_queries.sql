USE x_db;

-- 1. Create a New X Account
CALL createXAccount(
    'nora@example.com',
    'Nora123',
    'nora_x',
    'Nora',
    'Interested in technology and data analysis'
);


-- 2. Verify New Account
SELECT
    u.user_id,
    u.email,
    p.username,
    p.display_name,
    p.bio
FROM users u
JOIN profiles p
    ON u.user_id = p.user_id
WHERE p.username = 'nora_x';


-- 3. Follow Another User
CALL followUser('nora_x', 'ahmed_x');


-- 4. Verify Follow Relationship
SELECT
    follower.username AS follower,
    following.username AS following,
    f.followed_at
FROM follows f
JOIN profiles follower
    ON f.follower_id = follower.user_id
JOIN profiles following
    ON f.following_id = following.user_id
WHERE follower.username = 'nora_x';


-- 5. Verify Foreign Key Relationships
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'x_db'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;


-- 6. Negative Test Cases
-- Run these individually after the successful tests.
-- Each should return an expected error.

-- CALL followUser('nora_x', 'unknown_x');
-- CALL followUser('nora_x', 'nora_x');
-- CALL followUser('nora_x', 'ahmed_x');
