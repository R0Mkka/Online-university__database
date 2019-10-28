USE online_university;

CREATE TABLE IF NOT EXISTS chats_images (
	chatImageId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    label NVARCHAR(50) NOT NULL,
    path VARCHAR(100) NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS chats (
	chatId INT NOT NULL AUTO_INCREMENT,
    chatOwnerId INT NOT NULL,
    chatImageId INT,
    chatName NVARCHAR(150) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY(chatId),
    
    CONSTRAINT fk_CHATS_chatOwnerId
    FOREIGN KEY (chatOwnerId)
    REFERENCES users(userId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_CHATS_chatImageId
    FOREIGN KEY (chatImageId)
    REFERENCES chats_images(chatImageId)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS users_chats (
	userId INT NOT NULL,
    chatId INT NOT NULL,
    joinedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leftAt TIMESTAMP,
    
    PRIMARY KEY(userId, chatId),
    
	CONSTRAINT fk_USERS_CHATS_userId
    FOREIGN KEY (userId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_USERS_CHATS_chatId
    FOREIGN KEY (chatId)
    REFERENCES chats(chatId)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS messages_statuses (
	messageStatusId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    isRead BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS messages (
	messageId BIGINT NOT NULL AUTO_INCREMENT,
    messageStatusId BIGINT NOT NULL,
    chatId INT NOT NULL,
    userId INT NOT NULL,
    userEntryId BIGINT NOT NULL,
    messageText TEXT NOT NULL,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY(messageId, messageStatusId),
    
    CONSTRAINT fk_MESSAGES_messageStatusId
    FOREIGN KEY (messageStatusId)
    REFERENCES messages_statuses(messageStatusId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_MESSAGES_chatId
    FOREIGN KEY (chatId)
    REFERENCES chats(chatId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_MESSAGES_userId
    FOREIGN KEY (userId)
    REFERENCES users_entries(userId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_MESSAGES_userEntryId
    FOREIGN KEY (userEntryId)
    REFERENCES users_entries(userEntryId)
		ON UPDATE CASCADE
);