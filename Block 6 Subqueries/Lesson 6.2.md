# Подзапросы. Часть 2

[Task №1](https://stepik.org/lesson/1037969/step/9?unit=1046498)

Напишите запрос, который извлекает из предложенной базы данных названия фильмов, продолжительность которых больше, чем продолжительность фильма, показанного в предыдущий день.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE running_time > (SELECT running_time FROM Films AS InnerFilms 
                        WHERE DAYOFYEAR(show_date) = DAYOFYEAR(Films.show_date) - 1)
  ORDER BY title;
  ```

</details>

---
