USE online_university;

CREATE TABLE IF NOT EXISTS days_of_the_week (
	dayOfTheWeekId TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS timetable_item_groups (
	timetableItemGroupId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    userId INT UNSIGNED NOT NULL,
    name NVARCHAR(30) NOT NULL,
    
    PRIMARY KEY (timetableItemGroupId),
    
    CONSTRAINT fk_TIG_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS timetable_item_stickers (
	timetableItemStickerId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    userId INT UNSIGNED NOT NULL,
    title NVARCHAR(30) NOT NULL,
    color VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (timetableItemStickerId),
    
    CONSTRAINT fk_TIS_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS timetable_items (
	timetableItemId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    userId INT UNSIGNED NOT NULL,
    dayOfTheWeekId TINYINT UNSIGNED NOT NULL,
    courseId INT UNSIGNED,
    timetableItemGroupId INT UNSIGNED,
    subject NVARCHAR(100) NOT NULL,
    teacherFullName NVARCHAR(50) NOT NULL,
    onlineMeeting TEXT,
    classroom NVARCHAR(15),
    comment TEXT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    
    PRIMARY KEY (timetableItemId),
    
	CONSTRAINT fk_TI_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_TI_dayOfTheWeekId
    FOREIGN KEY (dayOfTheWeekId)
    REFERENCES days_of_the_week(dayOfTheWeekId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_TI_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_TI_timetableItemGroupId
    FOREIGN KEY (timetableItemGroupId)
    REFERENCES timetable_item_groups(timetableItemGroupId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

ALTER TABLE timetable_items
ADD COLUMN teacherFullName NVARCHAR(50) NOT NULL;

CREATE TABLE IF NOT EXISTS timetable_items_timetable_items_stickers (
	timetableItemId INT UNSIGNED NOT NULL,
    timetableItemStickerId INT UNSIGNED NOT NULL,
    
    CONSTRAINT fk_TITIS_timetableItemId
    FOREIGN KEY (timetableItemId)
    REFERENCES timetable_items(timetableItemId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_TITIS_timetableItemStickerId
    FOREIGN KEY (timetableItemStickerId)
    REFERENCES timetable_item_stickers(timetableItemStickerId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO days_of_the_week (dayOfTheWeekId, name)
VALUES (0, 'Sunday'),
	   (1, 'Monday'),
	   (2, 'Tuesday'),
       (3, 'Wednesday'),
       (4, 'Thursday'),
       (5, 'Friday'),
       (6, 'Saturday');