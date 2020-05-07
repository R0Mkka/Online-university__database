USE online_university;

describe chats;
describe courses;

select * from users;
select * from users_statuses;
select * from courses;
select * from courses_data;
select * from courses_items;
select * from users_chats;
select * from chats;
select * from days_of_the_week;
select * from timetable_items;
select * from courses_items_types;
select * from courses_items_attachments;

describe courses_items_attachments;

ALTER TABLE courses_items_attachments
MODIFY mimeType VARCHAR(100) NOT NULL;

UPDATE timetable_items
SET
	userId = 1
WHERE
	timetableItemId = 3;


ALTER TABLE courses MODIFY courseCode VARCHAR(20) NOT NULL UNIQUE;

INSERT INTO chats(chatOwnerId, chatName)
VALUES(3, 'Чат курса лел');

DROP TABLE courses_items;
DROP TABLE users_courses;
DROP TABLE courses;
DROP TABLE courses_data;

DELETE
FROM courses_items
WHERE courseItemId > 0;

TRUNCATE courses_items;

select
	*
from
	users_entries left join (
		select MAX(userEntryId) userEntryId
        from users_entries
        group by userId
	) maxes
using(userEntryId)
group by userId;

select 
	userId,
    userStatusId,
    enteredAt
from users_entries
where (SELECT MAX(userEntryId) from users_entries group by userId)
group by userId;

select * from users_entries group by userId order by enteredAt DESC;

ALTER TABLE courses_items
MODIFY courseItemTextContent TEXT NULL; 