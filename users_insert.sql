USE ou_main;

INSERT INTO users (
    roleId,
    firstName,
    lastName,
    educationalInstitution,
    email,
    password
)
VALUES (
    2,
    'Roman',
    'Alexanov',
    'Polotsk State University',
    'alexanov.roman@gmail.com',
    '123' 
),
(
    2,
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
    
DELETE 
FROM users
WHERE userId > 0;
