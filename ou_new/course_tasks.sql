USE online_university;

CREATE TABLE IF NOT EXISTS course_tasks_statuses (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

INSERT INTO course_tasks_statuses (id, name)
VALUES (1, 'opened'),
	   (2, 'closed');

CREATE TABLE IF NOT EXISTS course_tasks (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    courseId INT UNSIGNED NOT NULL,
    creatorId INT UNSIGNED NOT NULL,
    courseTaskStatusId TINYINT UNSIGNED NULL DEFAULT 1,
    title NVARCHAR(60) NOT NULL,
    description TEXT NOT NULL,
    deadline DATETIME NULL,
    isEdited BOOLEAN NULL DEFAULT FALSE,
    addedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_CT_courseId
    FOREIGN KEY (courseId)
    REFERENCES courses(courseId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_CT_creatorId
    FOREIGN KEY (creatorId)
    REFERENCES users(userId)
		ON UPDATE CASCADE,
        
	CONSTRAINT fk_CT_courseTaskStatusId
    FOREIGN KEY (courseTaskStatusId)
    REFERENCES course_tasks_statuses(id)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS course_task_attachments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    courseTaskId INT UNSIGNED NOT NULL,
    path VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    originalName NVARCHAR(50) NOT NULL,
    mimeType VARCHAR(100) NOT NULL,
    size INT NOT NULL,
    addedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_CTA_courseItemId
    FOREIGN KEY (courseTaskId)
    REFERENCES course_tasks(id)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS solution_statuses (
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

INSERT INTO solution_statuses (id, name)
VALUES (1, 'sent'),
	   (2, 'returned'),
	   (3, 'evaluated');

CREATE TABLE IF NOT EXISTS solutions (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    courseTaskId INT UNSIGNED NOT NULL,
    authorId INT UNSIGNED NOT NULL,
    solutionStatusId TINYINT UNSIGNED NOT NULL,
    text TEXT NULL,
    teacherComment TEXT NULL,
    grade TINYINT UNSIGNED NULL,
    isEdited BOOLEAN NULL DEFAULT FALSE,
    createdAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_S_courseTaskId
    FOREIGN KEY (courseTaskId)
    REFERENCES course_tasks(id)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_S_authorId
    FOREIGN KEY (authorId)
    REFERENCES users(userId)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
        
	CONSTRAINT fk_S_solutionStatusId
    FOREIGN KEY (solutionStatusId)
    REFERENCES solution_statuses(id)
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS solution_attachments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    solutionId INT UNSIGNED NOT NULL,
    path VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    originalName NVARCHAR(50) NOT NULL,
    mimeType VARCHAR(100) NOT NULL,
    size INT NOT NULL,
    addedAt TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_SA_solutionId
    FOREIGN KEY (solutionId)
    REFERENCES solutions(id)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);