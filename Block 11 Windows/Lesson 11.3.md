# Агрегатные функции

[Task №1](https://stepik.org/lesson/1264338/step/10?unit=1278468)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, имя и фамилия режиссера, рейтинг), а также указывает для каждого фильма, какой средний рейтинг имеют все фильмы режиссера, снявшего этот фильм.
Поле со средним рейтингом фильмов режиссера должно иметь псевдоним `avg_rating_by_director`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director, rating,
         AVG(rating) OVER (PARTITION BY director) AS avg_rating_by_director
  FROM Films
  ORDER BY director, rating;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264338/step/11?unit=1278468)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, имя и фамилия режиссера), а также указывает для каждого фильма, сколько фильмов среди всех остальных сняты тем же самым режиссером.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director,
         COUNT(*) OVER (PARTITION BY director) - 1 AS films_with_same_director
  FROM Films;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264338/step/12?unit=1278468)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, имя и фамилия режиссера), а также указывает для каждого фильма, сколько фильмов среди всех остальных не имеют года выхода.
Поле с количеством фильмов без года выхода должно иметь псевдоним `other_films_without_release_year`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director,
         IF(release_year IS NULL, 
            (COUNT(*) OVER ()) - (COUNT(release_year)  OVER ()) - 1,
            (COUNT(*) OVER ()) - (COUNT(release_year)  OVER ())) AS other_films_without_release_year
  FROM Films;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264338/step/13?unit=1278468)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, рейтинг), а также указывает для каждого фильма средний рейтинг среди всех остальных фильмов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, rating,
         ROUND((SUM(rating) OVER () - rating) / (COUNT(*) OVER () - 1)) AS other_films_avg_rating
  FROM Films;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264338/step/14?unit=1278468)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, рейтинг), а также указывает для каждого фильма, на сколько процентов его рейтинг больше, чем рейтинг самого низко оцененного фильма.

При этом в результирующей таблице разница между рейтингами фильмов должна быть округлена до целого числа и указана в поле c псевдонимом `better_than_low_rated_film` в следующем формате:

`<разница между рейтингами фильмов>%`

Записи в результирующей таблице должны быть расположены в порядке убывания разницы между рейтингами фильмов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, rating,
         CONCAT(ROUND(((rating / MIN(rating) OVER ()) - 1) * 100) , '%') AS better_than_low_rated_film
  FROM Films
  ORDER BY ((rating / MIN(rating) OVER ()) - 1) * 100 DESC;
  ```

</details>
