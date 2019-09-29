USE ou_main;

DROP TABLE course_items;
DROP TABLE courses;

CREATE TABLE courses (
	courseId INT AUTO_INCREMENT,
    courseName VARCHAR(100) NOT NULL,
    courseDescription TEXT NOT NULL,
    courseCode VARCHAR(20) NOT NULL UNIQUE,
    addedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (courseId)
);

CREATE TABLE course_items (
	courseItemId BIGINT AUTO_INCREMENT,
    courseItemTitle NVARCHAR(100) NOT NULL,
    courseItemText TEXT NOT NULL,
    courseId INT NOT NULL,
    PRIMARY KEY(courseItemId),
    
    CONSTRAINT fk_coursesId
    FOREIGN KEY (courseId)
		REFERENCES courses(courseId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);