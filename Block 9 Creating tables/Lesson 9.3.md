# Удаление, переименование и обновление таблиц

[Task №1](https://stepik.org/lesson/1054084/step/11?unit=1063286)

Напишите запрос, который удаляет из предложенной базы данных все существующие таблицы.

<details>
  <summary>Решение</summary>

  ```sql
  DROP TABLE IF EXISTS Students, Classes, Grades;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1054084/step/12?unit=1063286)

Напишите запрос, который изменяет имя таблицы `Students` на `Pupils`.

<details>
  <summary>Решение</summary>

  ```sql
  RENAME TABLE Students TO Pupils;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1054084/step/13?unit=1063286)

Напишите запрос, который выполняет с таблицей `Students` следующие преобразования:

* меняет имя поля `name` на `firstname`;
* меняет имя поля `surname` на `lastname`;
* удаляет поле `age`;

<details>
  <summary>Решение</summary>

  ```sql
  ALTER TABLE Students
  RENAME COLUMN name TO firstname,
  RENAME COLUMN surname TO lastname,
  DROP COLUMN age;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1054084/step/14?unit=1063286)

Напишите запрос, который добавляет в таблицу `Students` новое поле с именем `hometown` и располагает его между полями `surname` и `age`. Поле `hometown` должно иметь тип `VARCHAR(20)`, не должно хранить значение `NULL`, а также должно иметь значение по умолчанию в виде строки `New York City`.

<details>
  <summary>Решение</summary>

  ```sql
  ALTER TABLE Students
  ADD COLUMN hometown VARCHAR(20) NOT NULL DEFAULT 'New York City' AFTER surname;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1054084/step/15?unit=1063286)

Напишите запрос, который добавляет полям `name` и `surname` таблицы `Students` значение по умолчанию в виде пустой строки (`''`). При этом типы полей `name` и `surname`, а также имеющиеся у них ограничения должны остаться неизменными.

<details>
  <summary>Решение</summary>

  ```sql
  ALTER TABLE Students
  ALTER COLUMN name SET DEFAULT '',
  ALTER COLUMN surname SET DEFAULT '';
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1054084/step/16?unit=1063286)

Напишите запрос, который выполняет с таблицей `Students` следующие преобразования:

* удаляет поле `id`;
* определяет в качестве первичного ключа сочетание полей `name` и `surname`;

<details>
  <summary>Решение</summary>

  ```sql
  ALTER TABLE Students
  DROP COLUMN id,
  ADD PRIMARY KEY (name, surname);

  ```

</details>
