USE online_university;

INSERT INTO users(
	roleId,
    login,
    firstName,
    lastName,
    educationalInstitution,
    email,
    password
)
VALUES(
	2,
    'R0Mkka',
    'Роман',
    'Алексанов',
    'ПГУ',
    'alexanov.roman@gmail.com',
    '$2y$10$.Qm56AAmF5CsJGE/20rU5u/Pwhor66qRMhASvEB5Ho57Vtk8Qp49W'
);

SELECT
	users.userId,
    users.roleId,
    users.login,
    users.firstName,
    users.lastName,
    users.educationalInstitution,
    users.email,
    users.password,
    users.registeredAt,
    users_entries.userEntryId entryId,
    users_entries.userStatusId statusId,
    users_entries.enteredAt,
    users_entries.leftAt,
    account_images.accountImageId avatarId,
    account_images.label avatarLabel,
    account_images.path avatarPath,
    account_images.addedAt avatarAddedAt,
    themes.themeName,
    languages.languageName
FROM
	users
LEFT JOIN (
	SELECT *
	FROM users_entries
	ORDER BY enteredAt DESC
	LIMIT 1
) users_entries
USING(userId)
LEFT JOIN account_images
USING(accountImageId)
LEFT JOIN themes
USING(themeId)
LEFT JOIN languages
USING(languageId);

INSERT INTO users_entries(userId)
VALUES(1);