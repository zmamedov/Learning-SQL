# Подзапросы

[Task №1](https://stepik.org/lesson/1072300/step/1?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех узлов дерева, а также определяет тип каждого узла:

* `Root`, если узел является корнем дерева;
* `Leaf`, если узел является листом дерева;
* `Inner`, если узел не является ни корнем, ни листом.

Поле с названием типа узла должно иметь псевдоним `type`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id,
         CASE 
            WHEN p_id IS NULL THEN 'Root'
            WHEN id NOT IN (SELECT t.p_id
                            FROM Tree t
                            WHERE p_id IS NOT NULL) THEN 'Leaf' 
            ELSE 'Inner'
         END AS type   
  FROM Tree;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072300/step/2?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии студентов, у которых в качестве факультета указан несуществующий факультет.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Students
  WHERE department_id NOT IN (SELECT id FROM Departments)
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072300/step/3?unit=1082124)



<details>
  <summary>Решение</summary>

  ```sql
  SELECT salary AS second_highest_salary
  FROM Salaries
  WHERE salary = (SELECT salary
                  FROM Salaries
                  GROUP BY salary
                  ORDER BY salary DESC 
                  LIMIT 1
                  OFFSET 1);
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1072300/step/4?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах каждого товара. При этом в результирующую таблицу должна быть добавлена информация только за первый год продаж.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT product_id, year AS first_year, quantity, price 
  FROM Sales
  WHERE year = (SELECT MIN(year) FROM Sales S WHERE Sales.product_id = product_id)
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072300/step/5?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии сотрудников, зарплата которых меньше `25000` и руководитель которых покинул компанию.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Employees
  WHERE salary < 25000 
        AND manager_id IS NOT NULL
        AND manager_id NOT IN (SELECT id FROM Employees);
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072300/step/6?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех сотрудников, а также определяет размер команды каждого сотрудника.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id AS employee_id,
         (SELECT COUNT(id)
          FROM Employees InnerEmp
          WHERE team_id = Employees.team_id) AS team_size
  FROM Employees;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1072300/step/7?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех игроков, а также для каждого пользователя определяет идентификатор устройства, с которого был выполнен первый вход.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT player_id, device_id AS first_device_id
  FROM Activity
  WHERE event_date = (SELECT MIN(event_date)
                      FROM Activity InnerAc
                      WHERE player_id = Activity.player_id);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072300/step/8?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных названия товаров, которые были куплены хотя бы раз, и указывающий для каждого товара дату, когда этот товар был куплен в последний раз.

Поле с названием товара должно иметь псевдоним `product_name`, поле с датой последней покупки — `last_purchase_date`.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `product_name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT (SELECT name
          FROM Products
          WHERE Products.id = product_id) AS product_name, 
          order_date AS last_purchase_date
  FROM Orders 
  WHERE order_date = (SELECT MAX(order_date)
                      FROM Orders InnerOrd
                      WHERE product_id = Orders.product_id)
  ORDER BY product_name;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072300/step/9?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы переводов, которые имеют наибольшую сумму среди всех остальных переводов, выполненных в тот же день. Если в рамках одного дня несколько переводов имеют наибольшую сумму, в результирующую таблицу должен добавлен идентификатор каждого такого перевода.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id
  FROM Transactions
  WHERE amount = (SELECT MAX(amount)
                  FROM Transactions Tr
                  WHERE DATE(Transactions.day) = DATE(day))
  ORDER BY id DESC;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1072300/step/10?unit=1082124)

Напишите запрос, который разбивает товары магазина на категории, согласно их продажам, и определяет количество товаров в каждой категории.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT 'Low Sales' AS category,
         (SELECT COUNT(*) FROM Sales WHERE income < 20000) AS products_count
  FROM Sales
  UNION ALL
  SELECT DISTINCT 'Average Sales' AS category,
         (SELECT COUNT(*) FROM Sales WHERE income BETWEEN 20000 AND 50000) AS products_count
  FROM Sales
  UNION ALL
  SELECT DISTINCT 'High Sales' AS category,
         (SELECT COUNT(*) FROM Sales WHERE income > 50000) AS products_count
  FROM Sales;
  ```

</details>

---

[Task №11](https://stepik.org/lesson/1072300/step/11?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных идентификатор пользователя, который имеет наибольшее количество друзей. Помимо идентификатора пользователя, должно быть извлечено и само количество этих друзей.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id, SUM(friends) AS friends
  FROM (SELECT requester_id AS id, COUNT(*) AS friends
        FROM RequestsAccepted 
        GROUP BY requester_id
        UNION ALL 
        SELECT accepter_id, COUNT(*)
        FROM RequestsAccepted 
        GROUP BY accepter_id) t
  GROUP BY id
  ORDER BY friends DESC
  LIMIT 1;
  ```

</details>

---

[Task №12](https://stepik.org/lesson/1072300/step/12?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных имя последнего пассажира, который сможет сесть в автобус и не превысить ограничение по весу.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT person_name
  FROM Queue
  WHERE (SELECT SUM(weight)
          FROM Queue Q
          WHERE turn <= Queue.turn) <= 1000
  ORDER BY turn DESC
  LIMIT 1;
  ```

</details>

---

[Task №13](https://stepik.org/lesson/1072300/step/13?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных информацию о трех последних заказах каждого покупателя. Запись с информацией о заказе должна включать имя покупателя, идентификатор заказа и дату заказа. Если у покупателя менее трех заказов, в результирующую таблицу должна быть добавлена информация о каждом заказе покупателя.

<details>
  <summary>Решение</summary>

  ```sql
  WITH CTE AS (
      SELECT name, Orders.id AS order_id, order_date,
             ROW_NUMBER() OVER lim_customer AS row_num
      FROM Orders
      INNER JOIN Customers ON Customers.id = customer_id
      WINDOW lim_customer AS (PARTITION BY name ORDER BY Orders.id DESC)
  )
  
  SELECT name, order_id, order_date
  FROM CTE
  WHERE row_num IN (1, 2, 3);
  ```

</details>

---

[Task №14](https://stepik.org/lesson/1072300/step/14?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных информацию о сотрудниках (название отдела, имя, фамилия, заработная плата), которые имеют самую высокую зарплату внутри своего отдела. Если внутри отдела несколько сотрудников имеют самую высокую зарплату, в результирующую таблицу должна быть добавлена информация о каждом таком сотруднике.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Departments.name AS department, Employees.name AS name, surname, salary
  FROM Employees
  INNER JOIN Departments ON Departments.id = department_id
  WHERE salary = (SELECT salary
                  FROM Employees InnerEmp
                  WHERE department_id = Employees.department_id
                  ORDER BY salary DESC
                  LIMIT 1);
  ```

</details>

---

[Task №15](https://stepik.org/lesson/1072300/step/15?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных информацию о сотрудниках (название отдела, имя, фамилия, зарплата), которые являются высокооплачиваемыми.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Departments.name AS department, Employees.name AS name, surname, salary
  FROM Employees
  INNER JOIN Departments ON Departments.id = department_id
  WHERE salary IN (SELECT salary
                   FROM (SELECT DISTINCT salary
                         FROM Employees InnerEmp
                         WHERE department_id = Employees.department_id
                         ORDER BY salary DESC
                         LIMIT 3) t
                  );
  ```

</details>

---

