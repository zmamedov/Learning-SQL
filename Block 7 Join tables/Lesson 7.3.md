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

[Task №5](https://stepik.org/lesson/1038191/step/20?unit=1046721)

Напишите запрос, который определяет все возможные пары сотрудников мужчина-женщина, разница в возрасте между которыми меньше `5` лет, и отображает полученный результат в виде таблицы из двух полей:

* `male_staffer` — имя и фамилия сотрудника мужского пола;
* `female_staffer` — имя и фамилия сотрудника женского пола.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `male_staffer`, при совпадении — в порядке возрастания значения поля `female_staffer`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT MaleStaff.staffer AS male_staffer,
         FemaleStaff.staffer AS female_staffer
  FROM MaleStaff CROSS JOIN FemaleStaff
  WHERE ABS(MaleStaff.age - FemaleStaff.age) < 5
  ORDER BY male_staffer, female_staffer;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1038191/step/21?unit=1046721)

Напишите запрос, который определяет все возможные пары блюдо-напиток, вычисляет стоимость каждой пары и отображает полученный результат в виде таблицы из двух полей:

* `combo` — названия блюда и напитка в следующем формате:
> <название блюда>, <название напитка>
* `price` — общая стоимость блюда и напитка в следующем формате:
> <общая стоимость блюда и напитка>€

Записи в результирующей таблице должны быть расположены в порядке возрастания общей стоимости блюда и напитка, при совпадении — в лексикографическом порядке названия блюда, при совпадении — в лексикографическом порядке названия напитка.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT CONCAT(Meals.name, ', ', Drinks.name) AS combo,
         CONCAT(Meals.price + Drinks.price, '€') AS price
  FROM Meals CROSS JOIN Drinks
  ORDER BY Meals.price + Drinks.price, 
           Meals.name, 
           Drinks.name;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1038191/step/22?unit=1046721)

Напишите запрос, который создает стандартную карточную колоду из `52` карт и отображает полученный результат в виде таблицы из двух полей:

* `suit` — масть карты;
* `rankvalue` — ранг карты.

Записи в результирующей таблице должны быть расположены в порядке возрастания старшинства карточной масти, при совпадении — в порядке возрастания старшинства карточного ранга.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT suit,
         rankvalue
  FROM Ranks CROSS JOIN Suits
  ORDER BY CASE suit
               WHEN 'Spades' THEN 1
               WHEN 'Clubs' THEN 2
               WHEN 'Diamonds' THEN 3
               WHEN 'Hearts' THEN 4
           END,
           CASE rankvalue
               WHEN 'Jack' THEN 11
               WHEN 'Queen' THEN 12
               WHEN 'King' THEN 13
               WHEN 'Ace' THEN 14
               ELSE CAST(rankvalue AS SIGNED INT)
           END;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1038191/step/23?unit=1046721)

Напишите запрос, который определяет все возможные пары точек, расстояние между которыми больше `5`, и отображает полученный результат в виде таблицы из трех полей:

* `p1` — координаты первой точки в следующем формате:
> (<координата x>; <координата y>)
* `p2` — координаты второй точки в следующем формате:
> (<координата x>; <координата y>)
* `distance` — расстояние между точками, округленное до одного знака после запятой.

При этом в результирующую таблицу должны быть добавлены только уникальные пары точек. Например, пара точек с идентификаторами `1` и `2`, а также пара точек с идентификаторами `2` и `1` считаются одинаковыми. Из них должна быть выбрана только та пара, в которой идентификатор первой точки меньше второй.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT CONCAT('(', P1.x, '; ', P1.y, ')') AS p1,
         CONCAT('(', P2.x, '; ', P2.y, ')') AS p2,
         ROUND(SQRT(POW((P1.x - P2.x), 2) + POW((P1.y - P2.y), 2)), 1) AS distance
  FROM Points AS P1 CROSS JOIN Points AS P2
  WHERE P1.id < P2.id 
        AND SQRT(POW((P1.x - P2.x), 2) + POW((P1.y - P2.y), 2)) > 5;
  ```

</details>
