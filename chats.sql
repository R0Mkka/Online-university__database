USE ou_main;

CREATE TABLE chat (
	chatId INT NOT NULL AUTO_INCREMENT,
    imageId INT NOT NULL DEFAULT 1,
    creatorId INT NOT NULL,
    chatName NVARCHAR(110) DEFAULT 'Новый чат',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY(chatId),
    
    CONSTRAINT fk_CHAT_creatorId
    FOREIGN KEY (creatorId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

ALTER TABLE chat
ADD COLUMN chatName NVARCHAR(110) DEFAULT 'Новый чат';

ALTER TABLE chat
ADD COLUMN imageId INT NOT NULL DEFAULT 1;

CREATE TABLE chat_user (
	chatId INT NOT NULL,
	userId INT NOT NULL,
    
    PRIMARY KEY(chatId, userId),
    
    CONSTRAINT fk_CHAT_USER_chatId
    FOREIGN KEY (chatId)
		REFERENCES chat(chatId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_CHAT_USER_userId
    FOREIGN KEY (userId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TRIGGER after_chat_create
AFTER INSERT
   ON chat FOR EACH ROW
INSERT INTO chat_user(chatId, userId)
VALUES (NEW.chatId, NEW.creatorId);

CREATE TABLE message (
	messageId BIGINT NOT NULL AUTO_INCREMENT,
    messageText TEXT NOT NULL,
    chatId INT NOT NULL,
    userId INT NOT NULL,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY(messageId),
    
    CONSTRAINT fk_MESSAGE_chatId
    FOREIGN KEY (chatId)
		REFERENCES chat(chatId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_MESSAGE_userId
    FOREIGN KEY (userId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE message_status (
	messageId BIGINT NOT NULL,
    userId INT NOT NULL,
    isRead BOOLEAN DEFAULT FALSE,
    
    CONSTRAINT fk_MESSAGE_STATUS_messageId
    FOREIGN KEY (messageId)
		REFERENCES message(messageId)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_MESSAGE_STATUS_userId
    FOREIGN KEY (userId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

select * from chat;

INSERT INTO chat(creatorId)
VALUES (27);

DELETE
FROM chat
WHERE chatId = 7;
