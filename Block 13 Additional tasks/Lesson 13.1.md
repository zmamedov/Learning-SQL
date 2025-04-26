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

