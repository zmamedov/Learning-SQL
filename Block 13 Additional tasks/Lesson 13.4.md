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

[Task №7](https://stepik.org/lesson/1072297/step/7?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных информацию о пользователях банка (имя, фамилия, актуальный баланс), актуальный баланс которых больше `5000`.

Поле с актуальным балансом банковского счета пользователя должно иметь псевдоним `balance`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, SUM(amount) AS balance 
  FROM Transactions
  INNER JOIN Users ON Transactions.account = Users.account
  GROUP BY Transactions.account
  HAVING balance > 5000;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072297/step/8?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных пары (идентификатор актера, идентификатор режиссера), которые работали вместе как минимум над `3` фильмами.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT actor_id, director_id 
  FROM ActorsDirectors
  GROUP BY actor_id, director_id
  HAVING COUNT(*) >= 3;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072297/step/9?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии сотрудников, которые имеют как минимум `5` подчиненных.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT E2.name, E2.surname
  FROM Employees E1
  LEFT JOIN Employees E2 ON E1.manager_id = E2.id
  GROUP BY E1.manager_id
  HAVING COUNT(*) >= 5;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1072297/step/10?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных псевдоним пользователя, который оценил наибольшее количество фильмов. Если таких пользователей несколько, в результирующую таблицу должен быть добавлен тот, чей псевдоним в лексикографическом сравнении меньше.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT username
  FROM FilmRatings INNER JOIN Users ON user_id = Users.id
  GROUP BY user_id
  ORDER BY COUNT(*) DESC, username
  LIMIT 1;
  ```

</details>

---

[Task №11](http://stepik.org/lesson/1072297/step/11?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных название фильма, который имел самый высокий средний рейтинг среди оценок за сентябрь `2023` года. Если таких фильмов несколько, в результирующую таблицу должен быть добавлен тот, чье название в лексикографическом сравнении меньше.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM FilmRatings INNER JOIN Films ON film_id = Films.id
  WHERE YEAR(created_at) = 2023 AND MONTH(created_at) = 9
  GROUP BY film_id
  ORDER BY AVG(rating) DESC, title
  LIMIT 1;
  ```

</details>

---

[Task №12](https://stepik.org/lesson/1072297/step/12?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных названия стран, средняя продолжительность звонков в которых больше средней продолжительности звонков по всем странам.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Countries.name
  FROM (SELECT caller_id, callee_id, duration
        FROM Calls
        UNION ALL
        SELECT callee_id, caller_id, duration
        FROM Calls) t
  LEFT JOIN Persons ON t.caller_id = Persons.id
  LEFT JOIN Countries ON SUBSTRING_INDEX(Persons.phone_number, '-', 1) = country_code
  GROUP BY Countries.name
  HAVING AVG(duration) > (SELECT SUM(duration) / COUNT(*) FROM Calls);
  ```

</details>

---

[Task №13](https://stepik.org/lesson/1072297/step/13?unit=1082121)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии пользователей, которые потратили хотя бы `150` долларов в августе `2023` года и хотя бы `150` долларов в сентябре того же года.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM (SELECT Customers.name, Customers.surname, order_date
        FROM Customers
        INNER JOIN Orders ON Customers.id = customer_id
        INNER JOIN Products ON Products.id = product_id
        WHERE YEAR(order_date) = 2023 AND MONTH(order_date) IN (8, 9)
        GROUP BY customer_id, order_date
        HAVING SUM(price * quantity) >= 150) t
  GROUP BY name, surname
  HAVING COUNT(*) = 2;
  ```

</details>
