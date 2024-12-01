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

[Task №2](https://stepik.org/lesson/1037969/step/10?unit=1046498)

Напишите запрос, извлекающий из предложенной базы данных информацию о студентах (имя, фамилия, оценка), оценка которых больше средней оценки всех предыдущих студентов.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `grade`, при совпадении — порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, grade
  FROM Math
  WHERE grade > (SELECT AVG(grade)
                 FROM Math AS InnerMath
                 WHERE id < Math.id)
  ORDER BY grade, name;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1037969/step/11?unit=1046498)

Напишите запрос, извлекающий из предложенной базы данных информацию о студентах (имя, фамилия, оценка), оценка которых совпадает с оценкой предыдущего или следующего студентов.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, grade
  FROM Math AS M
  WHERE grade = ANY (SELECT grade
                     FROM Math
                     WHERE id IN (M.id - 1, M.id + 1))
  ORDER BY name;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1037969/step/12?unit=1046498)

Напишите запрос, извлекающий из предложенной базы данных информацию о студентах (имя, фамилия, оценка), оценка которых совпадает с наиболее часто встречающейся оценкой.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, grade
  FROM Math
  WHERE grade = (SELECT grade
                        FROM Math 
                        GROUP BY grade
                        ORDER BY COUNT(*) DESC
                        LIMIT 1)
  ORDER BY name;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1037969/step/13?unit=1046498)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии студентов, фамилии которых совпадают с фамилией какого-либо другого студента.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `surname`, при совпадении — порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Math
  WHERE surname IN (SELECT surname
                    FROM Math
                    GROUP BY surname
                    HAVING COUNT(*) > 1)
  ORDER BY surname, name;
  ```

</details>
