USE x_db;

DELIMITER //

-- 1. Create X Account Procedure
CREATE PROCEDURE createXAccount(
    IN p_email VARCHAR(191),
    IN p_password VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_display_name VARCHAR(100),
    IN p_bio TEXT
)
BEGIN
    DECLARE new_user_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO users (email, password_hash)
    VALUES (p_email, SHA2(p_password, 256));

    SET new_user_id = LAST_INSERT_ID();

    INSERT INTO profiles (
        user_id,
        username,
        display_name,
        bio
    )
    VALUES (
        new_user_id,
        p_username,
        p_display_name,
        p_bio
    );

    COMMIT;
END //

-- 2. Follow User Procedure
CREATE PROCEDURE followUser(
    IN p_follower_username VARCHAR(50),
    IN p_following_username VARCHAR(50)
)
BEGIN
    DECLARE v_follower_id INT;
    DECLARE v_following_id INT;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username not found';
    END;

    SELECT user_id
    INTO v_follower_id
    FROM profiles
    WHERE username = p_follower_username;

    SELECT user_id
    INTO v_following_id
    FROM profiles
    WHERE username = p_following_username;

    IF v_follower_id = v_following_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot follow yourself';
    END IF;

    INSERT INTO follows (follower_id, following_id)
    VALUES (v_follower_id, v_following_id);
END //

DELIMITER ;
