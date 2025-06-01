# Продвинутые соединения

[Task №1](https://stepik.org/lesson/1072302/step/1?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных числа, которые встречаются хотя бы `3` раза подряд.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT N1.num
  FROM Numbers N1
  INNER JOIN Numbers N2 ON N1.id + 1 = N2.id
  INNER JOIN Numbers N3 ON N1.id + 2 = N3.id
  WHERE N1.num = N2.num AND N2.num = N3.num;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072302/step/2?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы мест, которые свободны подряд.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `seat_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT C1.seat_id
  FROM Cinema C1
  INNER JOIN Cinema C2 ON C1.seat_id + 1 = C2.seat_id OR C1.seat_id = C2.seat_id + 1
  WHERE C1.free = 0 AND C2.free = 0
  ORDER BY C1.seat_id;
  ```

</details>

[Task №3](https://stepik.org/lesson/1072302/step/3?unit=1082126)

Напишите запрос, который определяет наименьшее расстояние между двумя любыми точками и указывает полученное значение в поле с псевдонимом `shortest`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT FORMAT(MIN(ABS(P1.x - P2.x)), 0) AS shortest
  FROM Points P1 CROSS JOIN Points P2
  WHERE P1.x != P2.x;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1072302/step/4?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы аккаунтов, в которые в определенный момент времени был выполнен вход с разных IP-адресов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT L1.account_id
  FROM LogInfo L1
  INNER JOIN LogInfo L2 ON L1.account_id = L2.account_id AND L1.ip_address < L2.ip_address
  WHERE (L2.login BETWEEN L1.login AND L1.logout) OR (L1.login BETWEEN L2.login AND L2.logout);
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072302/step/5?unit=1082126)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех руководителей, а также определяет количество подчиненных у каждого руководителя и их средний возраст.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT E2.name, E2.surname, COUNT(*) AS subordinates, ROUND(AVG(E1.age)) AS average_age
  FROM Employees E1 JOIN Employees E2 ON E1.manager_id = E2.id
  GROUP BY E1.manager_id;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072302/step/6?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы сотрудников, у которых либо неизвестны имя и фамилия, либо неизвестна зарплата.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id AS employee_id
  FROM Employees LEFT JOIN Salaries ON Employees.id = employee_id
  WHERE salary is NULL
  UNION
  SELECT employee_id
  FROM Employees RIGHT JOIN Salaries ON Employees.id = employee_id
  WHERE name IS NULL
  ORDER BY employee_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1072302/step/7?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы постов, которые оценили друзья пользователя с идентификатором `1`, но не оценил сам пользователь с идентификатором `1`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT page_id AS recommended_page
  FROM Friendship INNER JOIN Likes ON user2_id = user_id
  WHERE user1_id = 1 AND 
        page_id NOT IN (SELECT page_id
                        FROM Likes
                        WHERE user_id = 1);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072302/step/8?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных информацию о пользователях (идентификатор, имя, фамилия), которые приобрели товары с кодами `A` и `B`, но не приобрели товар с кодом `C`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT Customers.*
  FROM Customers JOIN Orders ON customer_id = Customers.id
  WHERE product_code = 'A' AND 
        customer_id IN (SELECT customer_id
                            FROM Orders
                            WHERE product_code = 'B') AND
        customer_id NOT IN (SELECT customer_id
                            FROM Orders
                            WHERE product_code = 'C');
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072302/step/9?unit=1082126)

Напишите запрос, который извлекает из предложенной базы названия футбольных команд, а также определяет количество выигранных турниров каждой командой.

<details>
  <summary>Решение</summary>

  ```sql
  WITH FIFAWorldCup AS (
      SELECT team_name, COUNT(*) AS fifa_won
      FROM Championships JOIN Teams ON id = `FIFA World Cup` 
      GROUP BY team_name
  ),
  UEFAEu AS (
      SELECT team_name, COUNT(*) AS uefa_won
      FROM Championships JOIN Teams ON id = `UEFA European Championship` 
      GROUP BY team_name
  ),
  CopaAmerica AS (
      SELECT team_name, COUNT(*) AS copa_won
      FROM Championships JOIN Teams ON id = `Copa America` 
      GROUP BY team_name
  ),
  AfricanCup AS (
      SELECT team_name, COUNT(*) AS af_won
      FROM Championships JOIN Teams ON id = `African Cup of Nations` 
      GROUP BY team_name
  )
  
  SELECT Teams.team_name, 
         IFNULL(fifa_won, 0) + IFNULL(uefa_won, 0) + IFNULL(copa_won, 0) + IFNULL(af_won, 0) AS tournaments_won
  FROM Teams
  LEFT JOIN FIFAWorldCup ON Teams.team_name = FIFAWorldCup.team_name
  LEFT JOIN UEFAEu ON Teams.team_name = UEFAEu.team_name
  LEFT JOIN CopaAmerica ON Teams.team_name = CopaAmerica.team_name
  LEFT JOIN AfricanCup ON Teams.team_name = AfricanCup.team_name;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1072302/step/10?unit=1082126)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех товаров, а также определяет актуальную цену каждого товара на `2023-08-09`.

Поле с с актуальной ценой товара должно иметь псевдоним `current_price`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH DefaultPrice AS (
      SELECT product_id, '10.00' AS default_price
      FROM PriceChanges
      GROUP BY product_id
  ),
  LastChangeDate AS (
      SELECT product_id, MAX(change_date) AS last_change_date
      FROM PriceChanges
      WHERE change_date <= '2023-08-09'
      GROUP BY product_id
  )
  
  SELECT DefaultPrice.product_id, 
         IFNULL(new_price, default_price) AS current_price
  FROM DefaultPrice
  LEFT JOIN PriceChanges ON DefaultPrice.product_id = PriceChanges.product_id AND change_date <= '2023-08-09'
  LEFT JOIN LastChangeDate ON DefaultPrice.product_id = LastChangeDate.product_id
  WHERE PriceChanges.change_date = last_change_date 
        OR last_change_date IS NULL;
  ```

</details>
