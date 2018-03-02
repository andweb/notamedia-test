-- создание заявки (второй не cможет создать, если уже создал первый)

INSERT INTO users_relations (user_from, user_to, status)
SELECT * FROM (SELECT 1 as user_from, 2 as user_to, 'new' as status) AS tmp
WHERE NOT EXISTS (
    SELECT * FROM users_relations ur
    WHERE
      ((ur.user_from=tmp.user_from AND ur.user_to=tmp.user_to) OR (ur.user_from=tmp.user_to AND ur.user_to=tmp.user_from))
      AND ur.status != 'rejected'
);

-- подтверждение заявки (пользователм 2)

UPDATE users_relations ur
SET ur.status = 'confirmed'
WHERE ur.user_to = 2 AND ur.user_from = 1 AND ur.status = 'new';

-- отклонение заявки (пользователм 2)

UPDATE users_relations ur
SET ur.status = 'rejected'
WHERE ur.user_to = 2 AND ur.user_from = 1 AND ur.status = 'new';


-- получение списка друзей (для user_id = 1)

SELECT u.name FROM users u WHERE user_id IN (
  SELECT
    IF (ur.user_from = 1, ur.user_to, ur.user_from) as friend_id
  FROM users_relations ur
  WHERE
    (ur.user_from = 1 OR ur.user_to = 1)
    AND ur.status = 'confirmed'
);


-- получение друзей друзей (для user_id = 1)

SELECT u.name FROM users u WHERE u.user_id IN (
  SELECT
    ur_from.user_to
  FROM users_relations ur
    JOIN users_relations ur_from ON IF (ur.user_from = 1, ur.user_to, ur.user_from) = ur_from.user_from
                                    AND ur_from.status = 'confirmed'
  WHERE
    (ur.user_from = 1 OR ur.user_to = 1)
    AND ur.status = 'confirmed'

  UNION

  SELECT
    ur_to.user_from
  FROM users_relations ur
    JOIN users_relations ur_to ON IF (ur.user_from = 1, ur.user_to, ur.user_from) = ur_to.user_to
                                  AND ur_to.status = 'confirmed'
  WHERE
    (ur.user_from = 1 OR ur.user_to = 1)
    AND ur.status = 'confirmed'
);