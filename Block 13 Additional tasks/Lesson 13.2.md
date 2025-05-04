# Базовые соединения

[Task №1](https://stepik.org/lesson/1072301/step/1?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех сотрудниках компании: имя, фамилия, зарплата. Если зарплата сотрудника неизвестна, она считается равной `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, salary
  FROM Employees
  LEFT JOIN Salary ON Employees.id = employee_id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072301/step/2?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы пользователей, посетивших сайт магазина без единой покупки, а также для каждого пользователя указывает количество таких посещений.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT customer_id, COUNT(*) AS count_no_trans
  FROM Visits
  LEFT JOIN Sales ON Visits.id = visit_id
  WHERE visit_id IS NULL
  GROUP BY customer_id;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072301/step/3?unit=1082125)

Напишите запрос, извлекающий из предложенной базы данных даты, в которые ожидаемая температура превышает ожидаемую температуру в предыдущий день.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT W1.record_date
  FROM Weather W1
  INNER JOIN Weather W2 ON W1.record_date = ADDDATE(W2.record_date, INTERVAL 1 DAY)
  WHERE W1.temperature > W2.temperature;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1072301/step/4?unit=1082125)

Напишите запрос, извлекающий из предложенной базы данных информацию о сотрудниках организации (имя, фамилия, зарплата), зарплата которых меньше `2000` долларов. Если зарплата сотрудника неизвестна, она считается равной `NULL` и меньше `2000`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, salary
  FROM Employees
  LEFT JOIN Salary ON Employees.id = employee_id
  WHERE salary < 2000 OR salary IS NULL;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072301/step/5?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных названия фильмов для детей, транслируемых в августе `2023` года.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Content
  INNER JOIN TVProgram ON Content.id = content_id
  WHERE kids_content = 'yes' 
        AND YEAR(program_date) = 2023 
        AND MONTH(program_date) = 8
        AND content_type = 'movie';
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072301/step/6?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех сотрудниках компании: имя, фамилия, город проживания, штат проживания.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, city, state
  FROM Persons
  LEFT JOIN Addresses ON Persons.id = person_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1072301/step/7?unit=1082125)

Напишите запрос, извлекающий из предложенной базы данных имена продавцов, которые в `2023` году не продали ни одного товара.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name
  FROM Sellers
  LEFT JOIN Orders ON Sellers.id = seller_id AND YEAR(sale_date) = 2023
  WHERE seller_id IS NULL
  ORDER BY name;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072301/step/8?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных псевдонимы всех пользователей, а также определяет суммарное расстояние, пройденное каждым пользователем.

Поле с суммарным расстоянием, пройденным пользователем, должно иметь псевдоним `travelled_distance`.

Данные в результирующей таблице должны быть расположены в порядке убывания значения поля `travelled_distance`, при совпадении — порядке возрастания значения поля `username`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT username, IFNULL(SUM(distance), 0) AS travelled_distance
  FROM Users
  LEFT JOIN Rides ON Users.id = user_id
  GROUP BY username
  ORDER BY travelled_distance DESC, username;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072301/step/9?unit=1082125)

Напишите запрос, извлекающий из предложенной базы данных имена покупателей, которые не приобрели ни одного товара у продавца с именем `Bonnie`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name
  FROM Customers
  WHERE id NOT IN (SELECT Customers.id
                   FROM Orders
                   RIGHT JOIN Sellers ON seller_id = Sellers.id
                   RIGHT JOIN Customers ON customer_id = Customers.id
                   WHERE Sellers.name = 'Bonnie');
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1072301/step/10?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех покупателей, а также определяет рейтинг подтверждения каждого покупателя.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Customers.id, IFNULL(ROUND(SUM(CASE
                                           WHEN status = 'confirmed' THEN 1
                                           ELSE 0
                                        END) / COUNT(status), 2), 0) AS confirmation_rate
  FROM Customers
  LEFT JOIN Confirmations ON Customers.id = customer_id
  GROUP BY Customers.id;
  ```

</details>

---

