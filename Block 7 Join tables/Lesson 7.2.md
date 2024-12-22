# Внутреннее соединение

[Task №1](https://stepik.org/lesson/1036436/step/11?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных названия товаров, которые были проданы хотя бы раз.
Поле с названием товара должно иметь псевдоним `product`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT name AS product
  FROM Products JOIN Sales ON Products.id = Sales.product_id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1036436/step/12?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных уникальные названия товаров, которые были проданы `12` сентября `2023` года.
Поле с названием товара должно иметь псевдоним `product`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT name AS product
  FROM Products JOIN Sales ON Products.id = Sales.product_id
  WHERE sale_date = '2023-09-12';
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1036436/step/13?unit=1044889)

Напишите запрос, который извлекает из предложенной базы данных названия товаров, а также определяет, на какую общую сумму был продан каждый товар. При этом в результирующую таблицу должны быть добавлены только те товары, которые были проданы хотя бы один раз.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name AS product,
         CONCAT(SUM(price), '€') AS amount
  FROM Products JOIN Sales ON Products.id = Sales.product_id
  GROUP BY name;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1036436/step/14?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных название товара, который `12` сентября `2023` года был продан наибольшее количество раз.
Поле с названием товара должно иметь псевдоним `bestseller`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name AS bestseller
  FROM Products JOIN Sales ON Products.id = Sales.product_id
  WHERE Sales.sale_date = '2023-09-12'
  GROUP BY name
  ORDER BY COUNT(*) DESC
  LIMIT 1;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1036436/step/15?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных информацию о названиях товаров, которые `12` сентября `2023` года были куплены ровно один раз.
Поле с названием товара должно иметь псевдоним `product`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `product`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name AS product
  FROM Products JOIN Sales ON Products.id = Sales.product_id
  WHERE Sales.sale_date = '2023-09-12'
  GROUP BY name
  HAVING COUNT(*) = 1
  ORDER BY product;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1036436/step/16?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных следующую информацию обо всех продажах магазина: идентификатор продажи, дату продажи, название проданного товара и название категории, которой принадлежит проданный товар.
Поле с идентификатором продажи должно иметь псевдоним `sale_id`, поле с названием товара — `product`, поле с названием категории — `category`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Sales.id AS sale_id,
         sale_date,
         Products.name AS product,
         Categories.name AS category
  FROM Sales
  INNER JOIN Products ON product_id = Products.id
  INNER JOIN Categories ON category_id = Categories.id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1036436/step/17?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных название категории, товары которой были проданы на наибольшую общую сумму.
Поле с названием категории должно иметь псевдоним `category`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Categories.name AS category
  FROM Products 
  JOIN Sales ON Products.id = Sales.product_id
  JOIN Categories ON Categories.id = Products.category_id
  GROUP BY category
  ORDER BY SUM(price) DESC
  LIMIT 1;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1036436/step/18?unit=1044889)

Напишите запрос, извлекающий из предложенной базы данных имена сотрудников, которые зарабатывают больше, чем их руководители.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT E2.name
  FROM Employees E1 
  JOIN Employees E2 ON E1.id = E2.manager_id
  WHERE E1.salary < E2.salary;
  ```

</details>
