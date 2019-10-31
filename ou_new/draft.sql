USE online_university;

describe chats;
describe courses;

select * from courses;
select * from courses_data;
select * from users_courses;
select * from chats;

ALTER TABLE courses MODIFY courseCode VARCHAR(20) NOT NULL UNIQUE;

INSERT INTO chats(chatOwnerId, chatName)
VALUES(3, 'Чат курса лел');

DROP TABLE courses_items;
DROP TABLE users_courses;
DROP TABLE courses;
DROP TABLE courses_data;

DELETE
FROM chats
WHERE chatId > 0;