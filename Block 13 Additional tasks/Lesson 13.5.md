# Агрегатные функции

[Task №1](https://stepik.org/lesson/1072299/step/1?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех проектов, а также определяет средний опыт работы (в годах) сотрудников, работающих над каждым проектом.

Поле со средним опытом сотрудников, работающих над проектом, должно иметь псевдоним `average_years`. Значения в поле `average_years` должны быть округлены до `2` знаков после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT project_id, ROUND(AVG(experience_years), 2) AS average_years
  FROM Teams
  INNER JOIN Employees ON employee_id = Employees.id
  GROUP BY project_id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072299/step/2?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех игроков, а также определяет, когда каждый игрок впервые вошел в игру.

Поле с датой первого входа в игру должно иметь псевдоним `first_login`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072299/step/3?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы пользователей, а также определяет, когда каждый пользователь последний раз вошел в аккаунт в `2023` году. При этом в результирующую таблицу должны быть добавлены только те пользователи, которые в `2023` году входили в аккаунт хотя бы раз.

Поле с датой последнего входа в аккаунт должно иметь псевдоним `last_stamp`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT user_id, MAX(time_stamp) AS last_stamp
  FROM Logins
  WHERE YEAR(time_stamp) = 2023
  GROUP BY user_id;
  ```

</details>

---

