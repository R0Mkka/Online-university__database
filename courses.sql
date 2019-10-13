USE ou_main;

DROP TABLE course_items;
DROP TABLE courses;

CREATE TABLE courses (
	courseId INT AUTO_INCREMENT,
    courseName VARCHAR(100) NOT NULL,
    courseDescription TEXT NOT NULL,
    courseGroupName NVARCHAR(50) NOT NULL DEFAULT 'Без группы',
    courseCode VARCHAR(20) NOT NULL UNIQUE,
    courseOwnerId INT NOT NULL,
    chatId INT NOT NULL,
    addedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (courseId),
    
    CONSTRAINT fk_course_owner_id
    FOREIGN KEY (courseOwnerId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
	
    CONSTRAINT courses_chatId
	FOREIGN KEY (chatId)
		REFERENCES chat(chatId)
		ON UPDATE CASCADE
);

ALTER TABLE courses
ADD COLUMN chatId INT NOT NULL DEFAULT 1;

ALTER TABLE courses
ADD CONSTRAINT courses_chatId
	FOREIGN KEY (chatId)
		REFERENCES chat(chatId)
		ON UPDATE CASCADE;

ALTER TABLE courses
ADD COLUMN courseOwnerId INT NOT NULL;

ALTER TABLE courses
ADD COLUMN courseGroupName NVARCHAR(50) NOT NULL DEFAULT 'Без группы';

ALTER TABLE courses
ADD CONSTRAINT fk_course_owner_id
    FOREIGN KEY (courseOwnerId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

DESCRIBE courses;

DROP TABLE course_items;

CREATE TABLE course_items (
	courseItemId BIGINT AUTO_INCREMENT,
    courseItemTitle NVARCHAR(100) NOT NULL,
    courseItemText TEXT NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    courseId INT NOT NULL,
    PRIMARY KEY(courseItemId),
    
    CONSTRAINT fk_coursesId
    FOREIGN KEY (courseId)
		REFERENCES courses(courseId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

SELECT * FROM courses;

DELETE
FROM courses
WHERE courseId = 17;