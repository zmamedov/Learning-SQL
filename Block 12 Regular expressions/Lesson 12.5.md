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

[Task №5](https://stepik.org/lesson/1481756/step/5?unit=1501469)

Напишите запрос, который извлекает из предложенной базы данных все номера телефонов. При этом в результирующей таблице номера телефонов должны содержать только цифры.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT REGEXP_REPLACE(phone_number, '[ -]', '') AS phone_number
  FROM Phones;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1481756/step/6?unit=1501469)

Напишите запрос, который извлекает из предложенной базы данных все номера телефонов, разбивает их на код страны, код города и номер, и отображает полученный результат в виде таблицы из трех полей:

* `country_code` — код страны;
* `area_code` — код города;
* `number` — номер.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT REGEXP_SUBSTR(phone, '^\\d+') AS country_code,
         REGEXP_SUBSTR(REGEXP_SUBSTR(phone, '\\d+[-]', 1, 2), '\\d+') AS area_code,
         REGEXP_SUBSTR(phone, '\\d+$') AS number
  FROM Phones;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1481756/step/7?unit=1501469)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии студентов, которые имеют корректный логин.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Students
  WHERE REGEXP_LIKE(login, '^[_]?[a-zA-Z]+\\d*[_]?$') = 1;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1481756/step/8?unit=1501469)

Напишите запрос, который извлекает из предложенной базы данных все сообщения, которые достойны внимания.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT message
  FROM Messages
  WHERE REGEXP_LIKE(message, '^(Здравствуйте|(Доброе утро)|(Добрый день)|(Добрый вечер))') = 1;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1481756/step/9?unit=1501469)

Напишите запрос, который определяет популярность онлайн-школы Beegeek путем суммирования баллов всех постов.

Поле с оценкой популярности должно иметь псевдоним `popularity`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT SUM(CASE
                 WHEN REGEXP_LIKE(content, '^beegeek.*beegeek$', 'c') = 1 THEN 3
                 WHEN REGEXP_LIKE(content, '^beegeek|beegeek$', 'c') = 1 THEN 2
                 WHEN REGEXP_LIKE(content, '[ _]?beegeek[ _]?', 'c') = 1 THEN 1
                 ELSE 0
              END) AS popularity 
  FROM Posts;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1481756/step/10?unit=1501469)

Напишите запрос, который разбивает режиссеров на группы в зависимости от доменной части адреса их электронной почты, определяет количество режиссеров в каждой группе, и отображает полученный результат в виде таблицы из двух полей:

* `domain` — доменная часть адреса электронной почты;
* `count` — количество режиссеров.

При этом в результирующей таблице доменная часть электронной почты должна быть указана в следующем формате:

`@<доменное имя>`

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `count`, при совпадении — в порядке возрастания значения поля `domain`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT REGEXP_SUBSTR(email, '@\\w+') AS domain,
         COUNT(*) AS count
  FROM Directors
  GROUP BY domain
  ORDER BY count, domain;
  ```

</details>
