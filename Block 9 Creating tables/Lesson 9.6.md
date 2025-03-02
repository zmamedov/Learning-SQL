# Представления

[Task №1](https://stepik.org/lesson/1057059/step/13?unit=1066390)

Напишите запрос, создающий представление с именем `LowStockProducts`. Представление должно включать информацию (название, количество) о товарах, количество которых на складе меньше десяти штук.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW LowStockProducts AS
  SELECT name, stock
  FROM Products
  WHERE stock < 10;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1057059/step/14?unit=1066390)

Напишите запрос, создающий представление с именем `UsersWithEmail`. Представление должно включать информацию (идентификатор, имя, фамилия, адрес электронной почты) о тех пользователях, адрес электронной почты которых известен.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW UsersWithEmail AS
  SELECT id, name, surname, email
  FROM Users
  WHERE email IS NOT NULL;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1057059/step/15?unit=1066390)

Напишите запрос, создающий представление с именем `ActivePlayers`. Представление должно включать информацию (идентификатор, дата последнего входа в игру) об игроках, которые на `2024-09-01` заходили в игру в течение последних тридцати дней.

Поле с информацией о дате последнего входу в игру должно иметь псевдоним `last_login`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW ActivePlayers AS
  SELECT player_id, 
         MAX(event_date) AS last_login
  FROM Activity
  WHERE DATEDIFF('2024-09-01', event_date) BETWEEN 0 AND 29
  GROUP BY player_id;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1057059/step/16?unit=1066390)

Напишите запрос, создающий представление с именем `AboveAverageSalaries`. Представление должно включать информацию (имя, фамилия, заработная плата) о сотрудниках, зарплата которых выше средней зарплаты всех сотрудников.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW AboveAverageSalaries AS
  SELECT name, surname, salary
  FROM Employees
  WHERE salary > (SELECT AVG(salary)
                  FROM Employees);
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1057059/step/17?unit=1066390)

Напишите запрос, создающий представление с именем `CategorySalesSummary`. Представление должно включать информацию о названии категории и общей сумме продаж в каждой категории.

Поле с общей суммой продаж должно иметь псевдоним `total`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW CategorySalesSummary AS
  SELECT category,
         SUM(quantity * price) AS total
  FROM Products pr
  INNER JOIN Orders od ON pr.id = product_id
  GROUP BY category;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1057059/step/18?unit=1066390)

Напишите запрос, создающий представление с именем `PopularMovies`. Представление должно включать информацию (название, количество покупок) о фильмах, которые были куплены не менее трех раз.

Поле с общим количеством покупок должно иметь псевдоним `total_purchases`.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `total_purchases`, при совпадении в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW PopularMovies AS
  SELECT title,
         COUNT(film_id) AS total_purchases
  FROM Purchases
  LEFT JOIN Films ON film_id = Films.id
  GROUP BY film_id
  HAVING total_purchases >= 3
  ORDER BY total_purchases, title;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1057059/step/19?unit=1066390)

Напишите запрос, создающий представление с именем `NoMinMaxStudents`. Представление должно включать информацию об идентификаторах групп, в которых нет ни максимального, ни минимального количества учеников.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW CountStudents AS
  SELECT group_id, 
         COUNT(group_id) AS count_students
  FROM Students
  GROUP BY group_id;
  
  CREATE VIEW NoMinMaxStudents AS
  SELECT group_id
  FROM CountStudents
  WHERE count_students != (SELECT MIN(count_students) FROM CountStudents)
        AND count_students != (SELECT MAX(count_students) FROM CountStudents);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1057059/step/20?unit=1066390)

Напишите запрос, создающий представление с именем `MostCommonFollowers`. Представление должно определять все пары пользователей с максимальным количеством общих подписчиков. Другими словами, если максимальное количество общих подписчиков между любыми двумя пользователями равно max, то запрос должен определить все пары пользователей, у которых есть max общих подписчиков.

Поле с идентификатором первого пользователя должно иметь псевдоним `user1_id`, поле с идентификатором второго пользователя — `user2_id`. Также для каждой записи результирующей таблицы должно выполняться неравенство `user1_id` < `user2_id`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW CountFollowersOfUsers AS
  SELECT R1.user_id user1_id, 
         R2.user_id user2_id, 
         COUNT(*) AS count_followers
  FROM Relations R1
  INNER JOIN Relations R2 ON R1.follower_id = R2.follower_id
  WHERE R1.user_id < R2.user_id
  GROUP BY R1.user_id, R2.user_id;
  
  CREATE VIEW MostCommonFollowers AS
  SELECT user1_id, user2_id
  FROM CountFollowersOfUsers
  WHERE count_followers = (SELECT MAX(count_followers)
                           FROM CountFollowersOfUsers);
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1057059/step/21?unit=1066390)

Напишите запрос, создающий представление с именем `PopularProducts`. Представление должно определять уникальные идентификаторы товаров, которые были заказаны три или более раз в течение двух лет подряд.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW AllPopularProducts AS
  SELECT product_id, YEAR(purchase_date) AS y
  FROM Orders
  GROUP BY product_id, YEAR(purchase_date)
  HAVING COUNT(y) >= 3;
  
  CREATE VIEW PopularProducts AS
  SELECT DISTINCT(product_id)
  FROM AllPopularProducts
  WHERE (product_id, y + 1) IN (SELECT product_id, y
                                FROM AllPopularProducts);
  ```

</details>
