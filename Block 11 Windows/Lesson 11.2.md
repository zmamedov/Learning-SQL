# Ранжирующие функции. Часть 2

[Task №1](https://stepik.org/lesson/1264337/step/9?unit=1278467)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех режиссерах (имя и фамилия, страна рождения, рейтинг), а также пронумеровывает их, начиная с `1`, в рамках страны рождения в порядке убывания рейтинга. При этом если два режиссера из одной страны имеют равные рейтинги, то их номера также должны совпадать.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DENSE_RANK() OVER(PARTITION BY country ORDER BY rating DESC) AS rank_in_country,
         full_name, country, rating
  FROM Directors
  ORDER BY country, rank_in_country DESC, id DESC;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264337/step/10?unit=1278467)

Напишите запрос, который извлекает из предложенной базы данных информацию о режиссерах (имя и фамилия, рейтинг) со вторым по величине наибольшим рейтингом.

<details>
  <summary>Решение</summary>

  ```sql
  WITH DirectorsRating AS (
      SELECT DENSE_RANK() OVER(ORDER BY rating DESC) AS total_rank,
             full_name, rating
      FROM Directors
  )
  
  SELECT full_name, rating
  FROM DirectorsRating
  WHERE total_rank = 2
  ORDER BY full_name;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264337/step/11?unit=1278467)

Напишите запрос, который извлекает из предложенной таблицы `Directors` всю информацию обо всех режиссерах, сначала указывая режиссеров из второй половины таблицы (идентификаторы с `6` по `10`), а затем — из первой (идентификаторы с `1` по `5`). В рамках каждой половины режиссеры должны быть расположены в порядке убывания рейтинга, при совпадении — в порядке возрастания идентификатора.

<details>
  <summary>Решение</summary>

  ```sql
  WITH DirectorsGroups AS (
      SELECT id, full_name, country, rating,
             NTILE(2) OVER (ORDER BY id DESC) AS group_number
      FROM Directors
  )
  
  SELECT id, full_name, country, rating
  FROM DirectorsGroups
  ORDER BY group_number, rating DESC, id;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264337/step/12?unit=1278467)

Напишите запрос, который извлекает из предложенной базы данных информацию о режиссерах (имя и фамилия, страна рождения, рейтинг), которые в рамках своей страны имеют самый высокий рейтинг. Если в стране несколько режиссеров с самым высоким рейтингом, то в результирующую таблицу должны быть добавлены они все.

<details>
  <summary>Решение</summary>

  ```sql
  WITH DirectorsRank AS (
      SELECT DENSE_RANK() OVER (PARTITION BY country ORDER BY rating DESC) AS rank_in_country,
             full_name, country, rating
      FROM Directors
  )
  
  SELECT full_name, country, rating
  FROM DirectorsRank
  WHERE rank_in_country = 1
  ORDER BY country, full_name;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264337/step/13?unit=1278467)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех режиссеров, а также указывает для каждого режиссера количество снятых им фильмов. Помимо этого, режиссеры должны быть пронумерованы, начиная с 1, в порядке убывания количества снятых фильмов. При этом если два режиссера имеют равное количество снятых фильмов, то их номера также должны совпадать.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DENSE_RANK() OVER director_rank AS place,
         director, COUNT(*) AS number_of_films
  FROM Films
  GROUP BY director
  WINDOW director_rank AS (ORDER BY COUNT(*) DESC)
  ORDER BY place, director;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1264337/step/14?unit=1278467)

Напишите запрос, который разбивает режиссеров на группы по три человека (первый-второй-третий, четвертый-пятый-шестой, и так далее), определяет средний рейтинг режиссеров каждой группы и отображает полученный результат в виде таблицы из двух полей:

* `group_number` — номер группы;
* `avg_rating` — средний рейтинг режиссеров группы.

Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `group_number`.

<details>
  <summary>Решение</summary>

  ```sql
  SET @group_count := (SELECT COUNT(*) div 3
                       FROM Directors);
  
  WITH DirectorGroup AS (
      SELECT Directors.*,
             NTILE(@group_count) OVER (ORDER BY id) AS group_number
      FROM Directors
  )
  
  SELECT group_number, AVG(rating) AS avg_rating
  FROM DirectorGroup
  GROUP BY group_number
  ORDER BY group_number DESC;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264337/step/15?unit=1278467)

Напишите запрос, который разбивает режиссеров на пары (первый-второй, третий-четвертый, и так далее) и определяет, родились ли режиссеры каждой пары в одной и той же стране. Запрос должен отобразить полученный результат в виде таблицы из двух полей:

* `pair` — имя и фамилия обоих режиссеров пары в следующем формате:
`<имя и фамилия первого режиссера>, <имя и фамилия второго режиссера>`

* `from_same_country` — значение `yes`, если режиссеры родились в одной и той же стране, или `no` в противном случае.

<details>
  <summary>Решение</summary>

  ```sql
  SET @pair_count := (SELECT COUNT(*) div 2
                       FROM Directors);
  
  WITH DirectorPair AS (
      SELECT Directors.*,
             NTILE(@pair_count) OVER (ORDER BY id) AS pair_number
      FROM Directors
  )
  
  SELECT CONCAT(D1.full_name, ', ', D2.full_name) AS pair,
         CASE
             WHEN D1.country = D2.country THEN 'yes'
             ELSE 'no'
         END AS from_same_country
  FROM DirectorPair D1
  INNER JOIN DirectorPair D2 ON D1.pair_number = D2.pair_number AND D1.id < D2.id;
  ```

</details>
