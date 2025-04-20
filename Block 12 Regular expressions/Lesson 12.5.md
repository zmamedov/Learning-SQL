# Решение задач

[Task №1](https://stepik.org/lesson/1481756/step/1?unit=1501469)

Напишите запрос, который определяет, в скольких постах содержится строка `beegeek` (без учета регистра) и указывает полученное значение в поле с псевдонимом `count_of_posts`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(*) AS count_of_posts
  FROM Posts
  WHERE REGEXP_LIKE(content, 'beegeek') = 1;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1481756/step/2?unit=1501469)

Напишите запрос, который извлекает из предложенной базы данных слова, которые состоят из двух одинаковых частей (с учетом регистра).

<details>
  <summary>Решение</summary>

  ```sql
  SELECT *
  FROM Words
  WHERE REGEXP_LIKE(word, '^(\\w+)\\1$', 'c');
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1481756/step/3?unit=1501469)

Напишите запрос, извлекающий из предложенной базы данных все тексты. При этом в результирующей таблице все множественные пробелы должны быть заменены единственным пробелом.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT REGEXP_REPLACE(Text, '[ ]+', ' ') AS text
  FROM Texts;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1481756/step/4?unit=1501469)

Напишите запрос, извлекающий из предложенной базы данных названия всех файлов. При этом в результирующей таблице все файлы должны быть указаны с нормализованным расширением без опечаток — `json`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT REGEXP_REPLACE(file_name, '\\.[jJ][sS]?[oO]?[nN]', '\\.json') AS file_name
  FROM Files;
  ```

</details>

---

