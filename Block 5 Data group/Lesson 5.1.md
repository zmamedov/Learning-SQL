# Агрегатные функции

[Task №1](https://stepik.org/lesson/1025977/step/15?unit=1034237)

Напишите запрос, который определяет средний рейтинг режиссеров из `USA` и указывает полученное значение в поле с псевдонимом `avg_usa_rating`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT AVG(rating) AS avg_usa_rating
  FROM Directors
  WHERE country = 'USA';
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1025977/step/16?unit=1034237)

Напишите запрос, который определяет количество режиссеров с известным рейтингом и указывает полученное значение в поле с псевдонимом `num_of_rated_directors`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(rating) AS num_of_rated_directors
  FROM Directors;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1025977/step/17?unit=1034237)

Напишите запрос, который определяет количество режиссеров из `USA` с рейтингом больше `50` и указывает полученное значение в поле с псевдонимом `num_of_rated_usa_directors`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(rating) AS num_of_rated_usa_directors
  FROM Directors
  WHERE country = 'USA' AND rating > 50;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1025977/step/18?unit=1034237)

Напишите запрос, определяющий количество уникальных стран, в которых родились режиссеры, и указывающий полученное значение в поле с псевдонимом `num_of_countries`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(DISTINCT country) AS num_of_countries
  FROM Directors;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1025977/step/19?unit=1034237)

Напишите запрос, который определяет минимальный и максимальный рейтинги среди режиссеров из `USA` и указывает полученные значения в полях с псевдонимами `min_rating` и `max_rating` соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT MIN(rating) AS min_rating,
         MAX(rating) AS max_rating
  FROM Directors
  WHERE country = 'USA';
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1025977/step/20?unit=1034237)

Напишите запрос, извлекающий из предложенной базы данных названия всех уникальных стран, в которых родились режиссеры.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT GROUP_CONCAT(DISTINCT country ORDER BY country SEPARATOR ', ') AS countries
  FROM Directors;
  ```

</details>
