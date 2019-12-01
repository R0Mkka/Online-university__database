CREATE DATABASE IF NOT EXISTS online_university
CHARACTER SET utf8mb4;

USE online_university;

CREATE TABLE IF NOT EXISTS roles (
	roleId TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    roleName VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS themes (
	themeId SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    themeName VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS languages (
	languageId TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    languageName NVARCHAR(35) NOT NULL
);

CREATE TABLE IF NOT EXISTS account_images (
	accountImageId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    path VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    originalName NVARCHAR(50) NOT NULL,
    mimeType VARCHAR(35) NOT NULL,
    size INT NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
	userId INT NOT NULL AUTO_INCREMENT,
    roleId TINYINT NOT NULL,
    login NVARCHAR(30) NOT NULL UNIQUE,
    firstName NVARCHAR(30) NOT NULL,
    lastName NVARCHAR(30) NOT NULL,
    educationalInstitution NVARCHAR(60) NOT NULL,
    email NVARCHAR(60) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL,
    registeredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accountImageId INT,
    themeId SMALLINT,
    languageId TINYINT,
    
    PRIMARY KEY (userId),
    
    CONSTRAINT fk_USERS_roleId
    FOREIGN KEY (roleId)
    REFERENCES roles(roleId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_USERS_accountImageId
    FOREIGN KEY (accountImageId)
    REFERENCES account_images(accountImageId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_USERS_themeId
    FOREIGN KEY (themeId)
    REFERENCES themes(themeId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_USERS_languageId
    FOREIGN KEY (languageId)
    REFERENCES languages(languageId)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS users_statuses (
	userStatusId TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    statusName VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS users_entries (
	userEntryId BIGINT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    userStatusId TINYINT DEFAULT 1,
    enteredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leftAt TIMESTAMP,
    
    PRIMARY KEY(userEntryId),
    
	CONSTRAINT fk_USERS_ENTRIES_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_USERS_ENTRIES_userStatusId
    FOREIGN KEY (userStatusId)
    REFERENCES users_statuses(userStatusId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);
    
DELIMITER //
CREATE TRIGGER before_users_delete
BEFORE DELETE
	ON users FOR EACH ROW
	BEGIN
		DELETE
        FROM courses
        WHERE OLD.userId = courses.courseOwnerId;
        
        DELETE
        FROM chats
        WHERE OLD.userId = chats.chatOwnerId;
        
        DELETE
        FROM users_entries
        WHERE OLD.userId = users_entries.userId;
	END;//
    
DELIMITER //
CREATE TRIGGER after_users_delete
AFTER DELETE
	ON users FOR EACH ROW
	BEGIN
		DELETE
        FROM account_images
        WHERE OLD.accountImageId = account_images.accountImageId;
	END;//