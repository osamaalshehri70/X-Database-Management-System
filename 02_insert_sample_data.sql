USE x_db;

-- 1. Insert Users
INSERT INTO users (email, password_hash)
VALUES
('ahmed@example.com', SHA2('Ahmed123', 256)),
('mohammed@example.com', SHA2('Mohammed123', 256)),
('khalid@example.com', SHA2('Khalid123', 256)),
('sara@example.com', SHA2('Sara123', 256));

-- 2. Insert Profiles
INSERT INTO profiles (user_id, username, display_name, bio)
VALUES
(1, 'ahmed_x', 'Ahmed', 'Technology enthusiast'),
(2, 'mohammed_x', 'Mohammed', 'Software developer'),
(3, 'khalid_x', 'Khalid', 'Sports and gaming'),
(4, 'sara_x', 'Sara', 'Data and technology');

-- 3. Insert Posts
INSERT INTO posts (user_id, content)
VALUES
(1, 'Welcome to X! This is my first post.'),
(1, 'Learning SQL and database design.'),
(2, 'Building my first database project.'),
(2, 'Today I learned about foreign keys.'),
(3, 'Who is excited for the weekend?'),
(3, 'Technology keeps changing every day.'),
(4, 'Exploring data analysis with SQL.'),
(4, 'My new project is coming soon!');

-- 4. Insert Follows
INSERT INTO follows (follower_id, following_id)
VALUES
(1, 2), (1, 3), (1, 4),
(2, 1), (2, 3),
(3, 1),
(4, 1), (4, 2);

-- 5. Insert Likes
INSERT INTO likes (user_id, post_id)
VALUES
(1, 3), (1, 5), (1, 7),
(2, 1), (2, 5),
(3, 1), (3, 2), (3, 7),
(4, 1), (4, 3);
