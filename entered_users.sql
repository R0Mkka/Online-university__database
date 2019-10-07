USE ou_main;

DROP TABLE entered_users_archive;
DROP TABLE entered_users;

CREATE TABLE entered_users (
	enteredUserId INT NOT NULL,
    statusId TINYINT NOT NULL DEFAULT 1,
    enteredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leftAt TIMESTAMP,
    
    CONSTRAINT fk_entered_user_id
    FOREIGN KEY (enteredUserId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_entered_user_status_id
    FOREIGN KEY (statusId)
		REFERENCES statuses(statusId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE entered_users_archive (
	archivedUserId INT NOT NULL,
    statusId TINYINT NOT NULL,
    enteredAt TIMESTAMP NOT NULL,
    leftAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_archived_entered_user_id
    FOREIGN KEY (archivedUserId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_archived_user_status_id
    FOREIGN KEY (statusId)
		REFERENCES statuses(statusId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

SELECT
	*
FROM
	entered_users;
    
INSERT INTO entered_users_archive(
      archivedUserId,
      statusId,
      enteredAt
    )
    SELECT
      enteredUserId,
      statusId,
      enteredAt
    FROM
      entered_users
    WHERE
      enteredUserId = 22
    ORDER BY
      entered_users.enteredAt DESC
    LIMIT 1;

    UPDATE entered_users
    SET
      statusId = 3,
      leftAt = CURRENT_TIMESTAMP()
    WHERE
      enteredUserId = 22;
