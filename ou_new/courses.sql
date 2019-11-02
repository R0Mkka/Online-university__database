USE online_university;

CREATE TABLE IF NOT EXISTS courses_pictures (
	coursePictureId SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pictureName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS courses_color_palettes (
	courseColorPaletteId SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    colorPaletteName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS courses_data (
	courseDataId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    coursePictureId SMALLINT,
    courseColorPaletteId SMALLINT,
    courseMode BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS courses (
	courseId INT NOT NULL AUTO_INCREMENT,
    courseDataId INT NOT NULL,
    courseOwnerId INT NOT NULL,
    chatId INT NOT NULL,
    courseName NVARCHAR(100) NOT NULL,
    courseGroupName NVARCHAR(30),
    courseDescription TEXT NOT NULL,
    courseCode VARCHAR(20) NOT NULL UNIQUE,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (courseId, courseDataId),
    
    CONSTRAINT fk_COURSES_courseDataId
    FOREIGN KEY (courseDataId)
    REFERENCES courses_data(courseDataId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    
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

CREATE TABLE IF NOT EXISTS courses_items (
	courseItemId INT NOT NULL AUTO_INCREMENT,
    courseId INT NOT NULL,
    courseDataId INT NOT NULL,
    creatorId INT NOT NULL,
    courseItemTitle NVARCHAR(60) NOT NULL,
    courseItemTextContent TEXT NOT NULL,
    
    PRIMARY KEY(courseItemId),
    
    CONSTRAINT fk_COURSES_ITEMS_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_COURSES_ITEMS_courseDataId
    FOREIGN KEY (courseDataId)
    REFERENCES courses_data(courseDataId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_COURSES_ITEMS_creatorId
	FOREIGN KEY (creatorId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS users_courses (
	userId INT NOT NULL,
    courseId INT NOT NULL,
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

CREATE TRIGGER after_course_delete
AFTER DELETE
   ON courses FOR EACH ROW
   DELETE
   FROM chats
   WHERE chatId = OLD.chatId;
