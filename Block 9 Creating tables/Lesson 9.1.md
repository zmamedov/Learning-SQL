# Создание таблиц. Часть 1

[Task №1](https://stepik.org/lesson/1054083/step/17?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать четыре следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента;
* `name` (тип `VARCHAR(20)`) — имя студента;
* `surname` (тип `VARCHAR(20)`) — фамилия студента;
* `age` (тип `INT`) — возраст студента;

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
       id INT,
       name VARCHAR(20),
       surname VARCHAR(20),
       age INT
   );
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1054083/step/18?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать четыре следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле не должно содержать значение `NULL`;
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать значение `NULL`;
* `surname` (тип `VARCHAR(20)`) — фамилия студента; поле не должно содержать значение `NULL`;
* `age` (тип `INT`) — возраст студента

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id      INT NOT NULL,
      name    VARCHAR(20) NOT NULL,
      surname VARCHAR(20) NOT NULL,
      age     INT
  );
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1054083/step/19?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать четыре следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле не должно содержать повторяющиеся значения и значение `NULL`;
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать значение `NULL`;
* `surname` (тип `VARCHAR(20)`) — фамилия студента; поле не должно содержать значение `NULL`;
* `age` (тип `INT`) — возраст студента;

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT UNIQUE NOT NULL, 
      name VARCHAR(20) NOT NULL,
      surname VARCHAR(20) NOT NULL,
      age INT
  );
  ```

</details>

