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

