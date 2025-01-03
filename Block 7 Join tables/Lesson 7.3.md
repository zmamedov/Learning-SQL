# Внешнее и перекрестное соединения

[Task №1](https://stepik.org/lesson/1038191/step/11?unit=1046721)

Напишите запрос, извлекающий из предложенной базы данных названия товаров, которые не были проданы ни разу.
Поле с названием товара должно иметь псевдоним `product`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Products.name AS product
  FROM Products
  LEFT JOIN Sales ON Products.id = Sales.product_id
  GROUP BY Products.name
  HAVING COUNT(Sales.product_id) = 0;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1038191/step/12?unit=1046721)

Напишите запрос, который извлекает из предложенной базы данных названия всех товаров, а также определяет, в какую дату впервые был продан каждый товар. 
Если товар не был продан ни разу, вместо даты первой продажи должна быть указана строка `Not sold`.
Поле с названием товара должно иметь псевдоним product, поле с датой первой продажи — `first_sale`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Products.name AS product,
         IFNULL(MIN(Sales.sale_date), 'Not sold') AS first_sale
  FROM Products
  LEFT JOIN Sales ON Products.id = Sales.product_id
  GROUP BY product;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1038191/step/13?unit=1046721)

Напишите запрос, который извлекает из предложенной базы данных названия всех товаров, а также определяет, на какую общую сумму был продан каждый товар.
В результирующей таблице общая сумма, на которую был продан каждый товар, должна быть указана в поле с псевдонимом amount в следующем формате:

> <общая сумма>€

Поле с названием товара должно иметь псевдоним `product`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Products.name AS product,
         CONCAT(COUNT(product_id) * Products.price, '€') AS amount
  FROM Products
  LEFT JOIN Sales ON Products.id = Sales.product_id
  GROUP BY product, price;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1038191/step/14?unit=1046721)

Напишите запрос, который извлекает из предложенной базы данных названия всех категорий, а также определяет, на какую среднюю сумму были проданы товары каждой категории.
В результирующей таблице средняя сумма, на которую были проданы товары каждой категории, должна быть округлена до целого числа и указана в поле с псевдонимом `avg_amount` в следующем формате:

> <средняя сумма>€

Поле с названием категории должно иметь псевдоним `category`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Categories.name AS category,
         CONCAT(ROUND(IFNULL(AVG(Products.price), 0)), '€') AS avg_amount
  FROM Products
  INNER JOIN Sales ON Products.id = Sales.product_id
  RIGHT JOIN Categories ON Categories.id = Products.category_id
  GROUP BY category;
  ```

</details>

---

