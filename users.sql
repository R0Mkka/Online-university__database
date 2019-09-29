USE ou_main;

DROP TABLE users;

CREATE TABLE users (
	userId INT AUTO_INCREMENT,
    roleId TINYINT NOT NULL,
    firstName NVARCHAR(30) NOT NULL,
    lastName NVARCHAR(30) NOT NULL,
    educationalInstitution NVARCHAR(60) NOT NULL,
    email NVARCHAR(60) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL,
    registeredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accountImageId INT DEFAULT 1,
    themeId TINYINT DEFAULT 1,
    languageId TINYINT DEFAULT 1, 
    PRIMARY KEY(userId),
    
    CONSTRAINT fk_roleId
    FOREIGN KEY (roleId)
		REFERENCES roles(roleId),
        
	CONSTRAINT fk_themeId
    FOREIGN KEY (themeId)
		REFERENCES themes(themeId),
        
	CONSTRAINT fk_languageId
    FOREIGN KEY (languageId)
		REFERENCES languages(languageId)
);

ALTER TABLE users
ADD CONSTRAINT unique_constraint UNIQUE(email);

ALTER TABLE users
MODIFY registeredAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

describe users;

CREATE TABLE avatar_image (
	imageId INT AUTO_INCREMENT PRIMARY KEY,
    imageLabel NVARCHAR(60) NOT NULL,
    imagePath VARCHAR(100) NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    userId INT NOT NULL,
    
	CONSTRAINT fk_userId
    FOREIGN KEY (userId)
		REFERENCES users(userId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
