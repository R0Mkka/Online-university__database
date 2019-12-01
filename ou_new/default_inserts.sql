USE online_university;

INSERT INTO roles(roleName)
VALUES('Teacher'),
	  ('Student'),
	  ('Admin');
      
ALTER TABLE users_statuses AUTO_INCREMENT = 1;
      
INSERT INTO users_statuses(statusName)
VALUES('Online'),
	  ('Offline'),
	  ('Away');
	
