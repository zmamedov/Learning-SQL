# Создание таблиц. Часть 1

[Task №1](https://stepik.org/lesson/1054083/step/17?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать четыре следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента;
* `name` (тип `VARCHAR(20)`) — имя студента;
* `surname` (тип `VARCHAR(20)`) — фамилия студента;
* `age` (тип `INT`) — возраст студента.

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
* `age` (тип `INT`) — возраст студента.

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
* `age` (тип `INT`) — возраст студента.

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

---

[Task №4](https://stepik.org/lesson/1054083/step/20?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать четыре следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле не должно содержать повторяющиеся значения и значение `NULL`; 
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать значение `NULL`;
* `surname` (тип VARCHAR(20)`) — фамилия студента; поле не должно содержать значение `NULL`;
* `age` (тип `INT`) — возраст студента; в качестве значения по умолчанию поле должно иметь число `18`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT UNIQUE NOT NULL, 
      name VARCHAR(20) NOT NULL,
      surname VARCHAR(20) NOT NULL,
      age INT DEFAULT 18
  );
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1054083/step/21?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать пять следующих полей с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле не должно содержать повторяющиеся значения и значение `NULL`;
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать значение `NULL`;
* `surname` (тип `VARCHAR(20)`) — фамилия студента; поле не должно содержать значение `NULL`;
* `age` (тип `INT`) — возраст студента; в качестве значения по умолчанию поле должно иметь число `18`;
* `date_of_receipt` (тип `DATE`) — дата поступления студента на учебу; в качестве значения по умолчанию поле должно иметь текущую дату.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT UNIQUE NOT NULL, 
      name VARCHAR(20) NOT NULL,
      surname VARCHAR(20) NOT NULL,
      age INT DEFAULT 18,
      date_of_receipt DATE DEFAULT (CURDATE()) 
  );
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1054083/step/22?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать пять следующих полей с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле не должно содержать повторяющиеся значения и значение `NULL`;
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать пустые строки и значение `NULL`;
* `surname` (тип `VARCHAR(20)`) — фамилия студента; поле не должно содержать пустые строки и значение `NULL`;
* `age` (тип `INT`) — возраст студента; поле не должно содержать значения меньше `18`; в качестве значения по умолчанию поле должно иметь число `18`;
* `date_of_receipt` (тип `DATE`) — дата поступления студента на учебу; поле не должно содержать значения меньше `2023-09-01`; в качестве значения по умолчанию поле должно иметь текущую дату.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT UNIQUE NOT NULL, 
      name VARCHAR(20) CHECK (name != '') NOT NULL,
      surname VARCHAR(20) CHECK (surname != '') NOT NULL,
      age INT CHECK (age >= 18) DEFAULT 18,
      date_of_receipt DATE CHECK (date_of_receipt >= '2023-09-01') DEFAULT (CURDATE())
  );
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1054083/step/23?unit=1063285)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT UNIQUE NOT NULL,
      name VARCHAR(20) CHECK (name != '') NOT NULL,
      surname VARCHAR(20) CHECK (surname != '') NOT NULL,
      age INT CHECK (age >= 18) DEFAULT 18,
      date_of_receipt DATE CHECK (date_of_receipt >= '2023-09-01') DEFAULT (CURDATE()),
      phone_number VARCHAR(20),
      CONSTRAINT phone CHECK (phone_number LIKE '7 (___) ___-__-__' OR phone_number LIKE '8 (___) ___-__-__')
  );
  ```

</details>
