# Создание таблиц. Часть 2

[Task №1](https://stepik.org/lesson/1055465/step/19?unit=1064726)

Напишите запрос, который создает таблицу `Students`, предназначенную для хранения информации о студентах. Она должна включать три следующих поля с учетом порядка:

* `id` (тип `INT`) — идентификатор студента; поле должно являться первичным ключом; поле должно поддерживать автоматическое заполнение;
* `name` (тип `VARCHAR(20)`) — имя студента; поле не должно содержать пустые строки;
* `surname` (тип `VARCHAR(20)`) — фамилия студента; поле не должно содержать пустые строки;

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(20) CHECK (name != ''),
      surname VARCHAR(20) CHECK (surname != '')
  );
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1055465/step/20?unit=1064726)

Напишите запрос, который создает две таблицы: `Students` и `Classes`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(20) CHECK (name != ''),
      surname VARCHAR(20) CHECK (surname != '')
  );
  
  CREATE TABLE Classes
  (
      id INT PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(20) CHECK (name != '')
  );
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1055465/step/21?unit=1064726)

Напишите запрос, который создает три таблицы: `Students`, `Classes` и `Grades`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TABLE Students
  (
      id INT PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(20) CHECK (name != ''),
      surname VARCHAR(20) CHECK (surname != '')
  );
  
  CREATE TABLE Classes
  (
      id INT PRIMARY KEY AUTO_INCREMENT,
      name VARCHAR(20) CHECK (name != '')
  );
  
  CREATE TABLE Grades
  (
      student_id INT,
      class_id INT,
      grade INT CHECK (grade BETWEEN 1 and 5),
      PRIMARY KEY (student_id, class_id),
      FOREIGN KEY (student_id) REFERENCES Students (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE,
      FOREIGN KEY (class_id) REFERENCES Classes (id)
          ON UPDATE CASCADE
          ON DELETE CASCADE
  );
  ```

</details>
