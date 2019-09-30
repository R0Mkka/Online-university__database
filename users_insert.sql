USE ou_main;

INSERT INTO users (
    roleId,
    userName,
    firstName,
    lastName,
    educationalInstitution,
    email,
    password
)
VALUES (
    2,
    'R0Mkka',
    'Roman',
    'Alexanov',
    'Polotsk State University',
    'alexanov.roman@gmail.com',
    '123' 
),
(
    2,
    'hekor',
    'Stas',
    'Balan',
    'Polotsk State University',
    'balan.stas@gmail.com',
    '321' 
);

SELECT
	*
FROM
	users;
    
SELECT
	*
FROM
	users
LEFT JOIN
	roles 
USING(roleId);
    
DELETE 
FROM users
WHERE userId > 0;
