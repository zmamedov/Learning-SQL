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

[Task №4](https://stepik.org/lesson/1072297/step/4?unit=1082121)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех пользователей, а также определяет количество подписчиков у каждого пользователя.

Поле с количеством подписчиков пользователя должно иметь псевдоним `followers_num`.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `followers_num`, при совпадении — в порядке возрастания значения поля `user_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT user_id, COUNT(*) AS followers_num
  FROM Followers
  GROUP BY user_id
  ORDER BY followers_num, user_id;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072297/step/5?unit=1082121)

Напишите запрос, который извлекает из предложенной базы данных наибольшее одиночное число.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT num
  FROM Numbers
  GROUP BY num
  HAVING COUNT(*) = 1
  ORDER BY num DESC
  LIMIT 1;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072297/step/6?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы пользователей, которые приобрели все доступные в магазине товары.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT customer_id
  FROM Sales
  INNER JOIN Products ON Products.id = product_id 
  GROUP BY customer_id
  HAVING COUNT(DISTINCT product_id) = MAX(Products.id)
  ```

</details>

---

