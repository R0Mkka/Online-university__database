USE ou_main;

INSERT INTO courses (
    courseName,
    courseDescription,
    courseCode
)
VALUES (
    'Biology',
    'Some course description...',
    '222'
);

INSERT INTO course_items (
    courseItemTitle,
    courseItemText,
    courseId
)
VALUES (
    'Lesson 1',
    'The beginning of the course...',
    1
);

SELECT
	*
FROM
	courses;
    
DELETE
FROM courses
WHERE courseId = 2;
