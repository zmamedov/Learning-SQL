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

---

[Task №4](https://stepik.org/lesson/1035215/step/15?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии режиссеров, снявших хотя бы один фильм, продолжительность которого больше продолжительности самого короткого фильма.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `director`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT director
  FROM Films
  GROUP BY director
  HAVING MAX(running_time) > (SELECT MIN(running_time)
                              FROM Films)
  ORDER BY director;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1035215/step/16?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных названия фильмов, продолжительность которых равна продолжительности фильма `WALL-E`. При этом сам фильм `WALL-E` не должен быть включен в результирующую таблицу.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE running_time = (SELECT running_time 
                        FROM Films 
						WHERE title = 'WALL-E')
        AND title != 'WALL-E'
  ORDER BY title;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1035215/step/17?unit=1043594)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии режиссеров, а также определяет, сколько фильмов снял каждый режиссер с продолжительностью больше средней продолжительности всех фильмов. При этом в результирующую таблицу должны быть добавлены только те режиссеры, которые сняли хотя бы один фильм с требуемой продолжительностью.
Поле с количеством фильмов, снятых режиссером, должно иметь псевдоним `num_of_films`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `num_of_films`, при совпадении — в порядке возрастания значения поля `director`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT director,
         COUNT(title) AS num_of_films
  FROM Films
  WHERE running_time > (SELECT AVG(running_time)
                        FROM Films)
  GROUP BY director
  ORDER BY num_of_films DESC, director;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1035215/step/18?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных названия фильмов, продолжительность которых больше продолжительности хотя бы одного фильма, снятого режиссером `Brad Bird`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE running_time > (SELECT MIN(running_time)
                        FROM Films
                        WHERE director = 'Brad Bird')
  ORDER BY title;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1035215/step/19?unit=1043594)

Напишите запрос, извлекающий из предложенной базы данных названия фильмов, продолжительность которых меньше продолжительности каждого фильма, снятого режиссером `John Lasseter`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title
  FROM Films
  WHERE running_time < ALL (SELECT running_time
                            FROM Films
                            WHERE director = 'John Lasseter')
  ORDER BY title;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1035215/step/20?unit=1043594)

Напишите запрос, который определяет количество фильмов с минимальной и максимальной продолжительностью среди всех фильмов и указывает полученные значения в полях с псевдонимами `shortest_films` и `longest_films` соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT (SELECT COUNT(*)
          FROM Films
          WHERE running_time = (SELECT MIN(running_time)
                                FROM Films)) AS shortest_films,
         (SELECT COUNT(*)
          FROM Films
          WHERE running_time = (SELECT MAX(running_time)
                                FROM Films)) AS longest_films;
  ```

</details>
