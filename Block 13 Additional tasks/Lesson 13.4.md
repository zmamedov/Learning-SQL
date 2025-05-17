# Группировка

[Task №1](https://stepik.org/lesson/1072297/step/1?unit=1082121)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех педагогов, а также определяет количество уникальных предметов, преподаваемых каждым педагогом.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id AS teacher_id, COUNT(DISTINCT subject_id) AS subjects_num
  FROM Teachers
  GROUP BY id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072297/step/2?unit=1082121)

Напишите запрос, который разбивает совершенные на сайте действия на группы в зависимости от их даты, определяет количество уникальных пользователей в каждой группе и отображает полученный результат в виде таблицы из двух полей:

* `activity_date` — дата;
* `active_users` — количество уникальных пользователей, совершивших какие-либо действия в эту дату.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT activity_date, COUNT(DISTINCT user_id) AS active_users
  FROM Activity
  GROUP BY activity_date;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072297/step/3?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных названия предметов, которые любимы как минимум тремя студентами.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT class
  FROM Classes
  GROUP BY class
  HAVING COUNT(student_id) >= 3;
  ```

</details>

---

