# Подзапросы. Часть 1

[Task №1](https://stepik.org/lesson/1035215/step/12?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных названия фильмов, продолжительность которых больше продолжительности самого короткого фильма.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE running_time > (SELECT MIN(running_time) 
                        FROM Films)
  ORDER BY title;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1035215/step/13?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии режиссеров, средняя продолжительность фильмов которых больше средней продолжительности всех фильмов.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `director`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT director
  FROM Films
  GROUP BY director
  HAVING AVG(running_time) > (SELECT AVG(running_time) 
                              FROM Films)
  ORDER BY director;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1035215/step/14?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии режиссеров, снявших хотя бы один фильм, продолжительность которого равна продолжительности самого короткого фильма.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `director`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT director
  FROM Films
  GROUP BY director
  HAVING MIN(running_time) = (SELECT MIN(running_time) 
                              FROM Films)
  ORDER BY director;
  ```

</details>
