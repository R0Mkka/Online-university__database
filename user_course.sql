USE ou_main;

DROP TABLE IF EXISTS user_course;

CREATE TABLE user_course (
	userId INT NOT NULL,
    courseId INT NOT NULL,
    
    PRIMARY KEY(userId, courseId),
    
    CONSTRAINT fk_USER_COURSE_userId
    FOREIGN KEY (userId)
		REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_USER_COURSE_courseId
    FOREIGN KEY (courseId)
		REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO user_course(userId, courseId)
VALUES(22, 1);

SELECT courses.courseName, courses.courseDescription, courses.courseCode, courses.addedAt
FROM users
INNER JOIN user_course
USING (userId)
INNER JOIN courses
USING (courseId)
WHERE users.userId = 22;