# Объединение результатов запросов

[Task №1](https://stepik.org/lesson/1043826/step/18?unit=1052295)

Напишите запрос, который определяет общее количество математиков, физиков и программистов и отображает полученный результат в виде таблицы из двух полей:

* `profession` — название профессии (`Mathematician` — математик, `Physicist` — физик, `Programmer` — программист);
* `total` — количество людей этой профессии.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT 'Mathematician' AS profession, COUNT(*) AS total
  FROM Mathematicians
  UNION
  SELECT 'Physicist' AS profession, COUNT(*) AS total
  FROM Physicists
  UNION
  SELECT 'Programmer' AS profession, COUNT(*) AS total
  FROM Programmers;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1043826/step/19?unit=1052295)

Напишите запрос, который определяет количество сессий продолжительностью:

* `[0-5)` — от `0` (включительно) до `5` минут (не включительно)
* `[5-10)` — от `5` (включительно) до `10` минут (не включительно)
* `[10-15)` — от `10` (включительно) до `15` минут (не включительно)
* `15 or more` — от `15` минут (включительно) и более

Поле с продолжительностью сессии должно иметь псевдоним `session_duration`, поле с количеством сессий — `total`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT '[0-5)' AS session_duration, COUNT(*) AS total
  FROM Sessions
  WHERE duration BETWEEN 0 AND 5 * 60 - 1
  UNION
  SELECT '[5-10)' AS session_duration, COUNT(*) AS total
  FROM Sessions
  WHERE duration BETWEEN 5 * 60 AND 10 * 60 - 1
  UNION
  SELECT '[10-15)' AS session_duration, COUNT(*) AS total
  FROM Sessions
  WHERE duration BETWEEN 10 * 60 AND 15 * 60 - 1
  UNION
  SELECT '15 or more' AS session_duration, COUNT(*) AS total
  FROM Sessions
  WHERE duration >= 15 * 60;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1043826/step/20?unit=1052295)

Напишите запрос, определяющий количество текстовых файлов, в которых встречается:

* слово `bee` без учета регистра
* слово `geek` без учета регистра

Поле со словом должно иметь псевдоним `word`, поле с количеством файлов, содержащих слово, — `count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT 'bee' AS word, COUNT(*) AS count
  FROM Files
  WHERE content LIKE 'bee %' OR content LIKE '% bee %' OR content LIKE '% bee' OR content = 'bee'
  UNION
  SELECT 'geek', COUNT(*)
  FROM Files
  WHERE content LIKE 'geek %' OR content LIKE '% geek %' OR content LIKE '% geek' OR content = 'geek';
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1043826/step/21?unit=1052295)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех математиков, физиков и программистов.
При этом в результирующей таблице сначала должны быть расположены все математики, затем все физики, а после все программисты. Математики относительно друг друга должны быть расположены в обратном лексикографическом порядке имени, при совпадении — в обратном лексикографическом порядке фамилии. Аналогичным образом относительно друг друга должны быть расположены физики и программисты.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname 
  FROM (SELECT name, surname, 1 AS sortvalue
        FROM Mathematicians
        UNION
        SELECT name, surname, 2
        FROM Physicists
        UNION
        SELECT name, surname, 3
        FROM Programmers
        ORDER BY sortvalue, 
                 name DESC, 
                 surname DESC) AS Scientists;
  ```

</details>
