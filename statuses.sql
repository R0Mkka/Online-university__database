USE ou_main;

CREATE TABLE statuses (
	statusId TINYINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    statusName VARCHAR(20) NOT NULL
);

INSERT INTO statuses(statusName)
VALUES('Online'),
	  ('Away'),
      ('Offline');