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

[Task №4](https://stepik.org/lesson/1072299/step/4?unit=1082123)

Напишите запрос, извлекающий из предложенной базы данных идентификатор пользователя, который совершил наибольшее количество заказов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT customer_id
  FROM Orders
  GROUP BY customer_id
  ORDER BY COUNT(*) DESC
  LIMIT 1;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072299/step/5?unit=1082123)

Напишите запрос, который определяет общее время в минутах, затраченное каждым сотрудником в каждый день работы в офисе.

Поле с общим временем, потраченным за день на работу, должно иметь псевдоним `total_time`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT emp_id, event_day, SUM(out_time) - SUM(in_time) AS total_time
  FROM Employees
  GROUP BY emp_id, event_day;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072299/step/6?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных все поисковые запросы, а также определяет качество каждого запроса и процент низкокачественных запросов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT query_name, ROUND(SUM(rating/position) / COUNT(*), 2) AS quality,
         ROUND(100 * SUM(CASE
                            WHEN rating < 3 THEN 1
                            ELSE 0
                         END) / COUNT(*), 2) AS poor_query_percentage
  FROM Queries
  GROUP BY query_name;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1072299/step/7?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех сотрудников, а также определяет идентификатор основного отдела каждого сотрудника. Если сотрудник работает лишь в одном отделе, идентификатором его основного отдела должен быть идентификатор того отдела, в котором он работает.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id AS employee_id, department_id AS primary_department_id
  FROM Employees
  WHERE primary_flag = 'yes'
  UNION
  SELECT id, department_id
  FROM Employees
  WHERE primary_flag = 'no' AND id NOT IN (SELECT id
                                           FROM Employees
                                           WHERE primary_flag = 'yes');
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072299/step/8?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных все даты продаж, а также для каждой даты определяет разницу между количеством проданных апельсинов и количеством проданных яблок.

Поле с разницей между количествами проданных фруктов должно иметь псевдоним `diff`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT sale_date, IF(COUNT(*) = 1, MAX(sold_num), MAX(sold_num) - MIN(sold_num)) AS diff
  FROM Sales
  GROUP BY sale_date;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072299/step/9?unit=1082123)

Напишите запрос, который извлекает из предложенной базы данных названия всех складов, а также определяет суммарный объем находящихся на каждом складе товаров.

Поле с названием склада должно иметь псевдоним `warehouse_name`, поле с суммарным объемом находящихся на складе товаров — `volume`. Значения в поле `volume` должны быть округлены до `2` знаков после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name AS warehouse_name, ROUND(SUM(width * length * height * units), 2) AS volume
  FROM Warehouse
  INNER JOIN Products ON product_id = Products.id
  GROUP BY name;
  ```

</details>

---

