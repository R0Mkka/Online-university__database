USE online_university;

describe chats;
describe courses;

select * from users;
select * from users_statuses;
select * from courses;
select * from courses_data;
select * from courses_items;
select * from courses_items_types;
select * from users_chats;
select * from chats;
select * from days_of_the_week;
select * from timetable_items;
select * from courses_items_types;
select * from courses_items_attachments;
select * from timetable_item_stickers left join users_timetable_items_stickers using(timetableItemStickerId) where userId = 8 or isCommon = TRUE;
select * from `timetable_items_timetable_items_stickers`;
select * from courses_blocked_users;
select * from course_tasks;
select * from course_task_attachments;

DELETE
FROM courses
WHERE courseId = 10;

select * from timetable_item_stickers left join timetable_items_timetable_items_stickers using(timetableItemStickerId) left join users_timetable_items_stickers using(timetableItemStickerId) where timetableItemId = 4;

truncate timetable_item_stickers;

delete from timetable_item_stickers where timetableItemStickerId > 0;
ALTER TABLE timetable_item_stickers AUTO_INCREMENT=1;

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
FROM days_of_the_week
WHERE dayOfTheWeekId > 0;

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

UPDATE
	timetable_item_groups
SET
	name = '123',
    isPrivate = 1
WHERE
	userId = 8 AND `timetableItemGroupId` = 49;
    
DELETE
FROM timetable_items_timetable_items_stickers
WHERE timetableItemId > 0;