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

