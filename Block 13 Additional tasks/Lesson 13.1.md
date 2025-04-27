# Выборка и фильтрация

[Task №1](https://stepik.org/lesson/1072296/step/1?unit=1082120)

Напишите запрос, который извлекает из предложенной базы данных уникальные адреса электронных почт студентов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT email
  FROM Emails;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072296/step/2?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных названия товаров, которые принадлежат категории `Electronics` и цена которых не превышает `999` долларов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name
  FROM Products
  WHERE category = 'Electronics' AND price <= 999;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072296/step/3?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных информацию о пациентах (имя, фамилия, диагноз), которые болеют диабетом первого типа.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, conditions
  FROM Patients
  WHERE conditions LIKE '%DIAB1%';
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1072296/step/4?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии пользователей, которых пригласил не пользователь с идентификатором `2` или которые не были приглашены кем-либо.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Users
  WHERE referee_id != 2 OR referee_id IS NULL;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072296/step/5?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных информацию о странах (название, континент), площадь которых больше `2000000` квадратных километров или население которых больше `15000000` человек.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, continent
  FROM Countries
  WHERE area > 2000000 OR population > 15000000;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072296/step/6?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных уникальные идентификаторы пользователей, которые просмотрели хотя бы одну из своих статей.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT author_id
  FROM Views
  WHERE author_id = viewer_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1072296/step/7?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы твитов, содержание которых состоит из `20` и менее символов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id
  FROM Tweets
  WHERE CHAR_LENGTH(content) <= 20;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1072296/step/8?unit=1082120)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы и названия всех товаров, при этом меняет местами идентификаторы двух последовательных товаров.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT IF(id MOD 2 = 0, id - 1, id + 1) AS id, name
  FROM Products
  ORDER BY id;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1072296/step/9?unit=1082120)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех сотрудников компании, а также определяет премию каждого сотрудника.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         IF(id % 2 = 0 AND LEFT(name, 1) = 'A', salary, salary / 2) AS bonus
  FROM Employees
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1072296/step/10?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных названия фильмов, которые имеют нечетный идентификатор и краткое описание которых отлично от `boring`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE id % 2 != 0 AND description != 'boring'
  ORDER BY id DESC;
  ```

</details>

---

[Task №11](https://stepik.org/lesson/1072296/step/11?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных всю информацию о каждом студенте. При этом имена и фамилии студентов в результирующей таблице должны быть отформатированы так, чтобы первая буква была заглавная, а остальные — строчные.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id, 
         CONCAT(UPPER(LEFT(name, 1)), LOWER(RIGHT(name, CHAR_LENGTH(name) - 1))) AS name,
         CONCAT(UPPER(LEFT(surname, 1)), LOWER(RIGHT(surname, CHAR_LENGTH(surname) - 1))) AS surname
  FROM Students
  ORDER BY id;
  ```

</details>

---

[Task №12](https://stepik.org/lesson/1072296/step/12?unit=1082120)

Напишите запрос, который извлекает из предложенной базы данных стороны всех потенциальных треугольников и для каждой тройки сторон указывает, существует ли треугольник с такими сторонами: `yes`, если существует, или `no` в противном случае.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT x, y, z,
         IF(x+y>z AND x+z>y AND y+z>x, 'yes', 'no') AS triangle
  FROM Triangles;
  ```

</details>

---

[Task №13](https://stepik.org/lesson/1072296/step/13?unit=1082120)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии пользователей, которые не совершили ни одного заказа.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Customers
  LEFT JOIN Orders ON Customers.id = customer_id
  WHERE customer_id is NULL
  ```

</details>

---

[Task №14](https://stepik.org/lesson/1072296/step/14?unit=1082120)

Напишите запрос, определяющий цену каждого товара в каждом магазине, в котором он продается. Запись с информацией о цене товара должна включать название товара, название магазина и цену товара в этом магазине.

Поле с названием товара должно иметь псевдоним `product`, поле с названием магазина — `store`, поле с информацией о цене товара — `price`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT product, 'aliexpress' AS store, aliexpress AS price
  FROM Prices
  WHERE aliexpress IS NOT NULL
  UNION ALL
  SELECT product, 'amazon' AS store, amazon AS price
  FROM Prices
  WHERE amazon IS NOT NULL
  UNION ALL
  SELECT product, 'ebay' AS store, ebay AS price
  FROM Prices
  WHERE ebay IS NOT NULL;
  ```

</details>
