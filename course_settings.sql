USE ou_main;

DROP TABLE course_data;
DROP TRIGGER createCourseData;

CREATE TABLE course_data (
	courseId INT NOT NULL PRIMARY KEY,
    courseStatus BOOL DEFAULT TRUE,
    coursePaletteId SMALLINT DEFAULT 1,
    courseIconId SMALLINT DEFAULT 1
);

CREATE TRIGGER createCourseData AFTER INSERT
ON courses
FOR EACH ROW
INSERT INTO course_data(courseId)
VALUES (NEW.courseId);

SELECT * FROM course_data;