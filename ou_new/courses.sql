USE online_university;

CREATE TABLE IF NOT EXISTS courses_pictures (
	coursePictureId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pictureName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS courses_color_palettes (
	courseColorPaletteId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    colorPaletteName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS courses_data (
	courseDataId INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    coursePictureId SMALLINT UNSIGNED,
    courseColorPaletteId SMALLINT UNSIGNED,
    courseMode BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS courses (
	courseId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    courseDataId INT UNSIGNED NOT NULL,
    courseOwnerId INT UNSIGNED NOT NULL,
    chatId INT UNSIGNED NOT NULL,
    courseName NVARCHAR(100) NOT NULL,
    courseGroupName NVARCHAR(30),
    courseDescription TEXT NOT NULL,
    courseCode VARCHAR(20) NOT NULL UNIQUE,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (courseId),
    
    CONSTRAINT fk_COURSES_courseDataId
    FOREIGN KEY (courseDataId)
    REFERENCES courses_data(courseDataId)
		ON UPDATE CASCADE,
    
    CONSTRAINT fk_COURSES_courseOwnerId
    FOREIGN KEY (courseOwnerId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_COURSES_chatId
    FOREIGN KEY (chatId)
    REFERENCES chats(chatId)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS courses_blocked_users (
	courseId INT UNSIGNED NOT NULL,
    userId INT UNSIGNED NOT NULL,
    
    PRIMARY KEY (courseId, userId),
    
    CONSTRAINT fk_CBU_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_CBU_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS courses_items_types (
	courseItemTypeId TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

INSERT INTO courses_items_types(courseItemTypeId, name)
VALUES (1, 'studyMaterials'),
	   (2, 'announcement'),
       (3, 'task');

CREATE TABLE IF NOT EXISTS courses_items (
	courseItemId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    courseItemTypeId TINYINT UNSIGNED NOT NULL,
    courseId INT UNSIGNED NOT NULL,
    creatorId INT UNSIGNED NOT NULL,
    courseItemTitle NVARCHAR(60) NOT NULL,
    courseItemTextContent TEXT NULL,
    isEdited BOOLEAN NULL DEFAULT FALSE,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY(courseItemId),
    
    CONSTRAINT fk_CI_courseItemTypeId
    FOREIGN KEY (courseItemTypeId)
    REFERENCES courses_items_types(courseItemTypeId)
		ON UPDATE CASCADE,
    
    CONSTRAINT fk_COURSES_ITEMS_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_COURSES_ITEMS_creatorId
	FOREIGN KEY (creatorId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS courses_items_attachments (
	courseItemAttachmentId INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    courseItemId INT UNSIGNED NOT NULL,
    path VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    originalName NVARCHAR(50) NOT NULL,
    mimeType VARCHAR(100) NOT NULL,
    size INT NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_CIA_courseItemId
    FOREIGN KEY (courseItemId)
    REFERENCES courses_items(courseItemId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users_courses (
	userId INT UNSIGNED NOT NULL,
    courseId INT UNSIGNED NOT NULL,
    joinedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leftAt TIMESTAMP,
    
    PRIMARY KEY(userId, courseId),
    
    CONSTRAINT fk_USERS_COURSES_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_USERS_COURSES_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER before_course_delete
BEFORE DELETE
	ON courses FOR EACH ROW
    BEGIN
		DELETE
		FROM courses_items
		WHERE OLD.courseId = courses_items.courseId;
        
        DELETE
        FROM users_courses
        WHERE OLD.courseId = users_courses.courseId;
	END;//
    
DELIMITER //
CREATE TRIGGER after_course_delete
AFTER DELETE
	ON courses FOR EACH ROW
	BEGIN
		DELETE
        FROM courses_data
        WHERE OLD.courseDataId = courses_data.courseDataId;
        
        DELETE
        FROM chats
        WHERE OLD.chatId = chats.chatId;
	END;//
    
DELIMITER //
CREATE TRIGGER after_courses_data_delete
AFTER DELETE
	ON courses_data FOR EACH ROW
	BEGIN
		DELETE
        FROM courses_pictures
        WHERE OLD.coursePictureId = courses_pictures.coursePictureId;
        
		DELETE
        FROM courses_color_palettes
        WHERE OLD.courseColorPaletteId = courses_color_palettes.courseColorPaletteId;
	END;//
