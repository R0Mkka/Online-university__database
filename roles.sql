USE ou_main;

CREATE TABLE roles (
    roleId TINYINT AUTO_INCREMENT PRIMARY KEY,
    roleName NVARCHAR(20) NOT NULL
);
      
SELECT 
    *
FROM
    roles;
