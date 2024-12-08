# Подзапросы. Часть 3

[Task №1](https://stepik.org/lesson/1042414/step/7?unit=1050887)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии пользователей, которые не приобрели ни одного фильма.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Users
  WHERE NOT EXISTS (SELECT *
                    FROM Purchases
                    WHERE Users.id = user_id);
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1042414/step/8?unit=1050887)

Напишите запрос, извлекающий из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера), которые были куплены хотя бы раз.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director
  FROM Films
  WHERE EXISTS (SELECT *
                FROM Purchases
                WHERE film_id = Films.id)
  ORDER BY title;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1042414/step/9?unit=1050887)

Напишите запрос, определяющий количество пользователей, которые приобрели фильм под названием `Toy Story 2`, и указывающий полученное значение в поле с псевдонимом `num_of_users`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(user_id) AS num_of_users 
  FROM Purchases 
  WHERE film_id in (SELECT id 
                    FROM Films 
                    WHERE title = 'Toy Story 2');
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1042414/step/10?unit=1050887)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии пользователей, которые приобрели фильм под названием `Toy Story 2`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Users
  WHERE id IN (SELECT user_id
               FROM Purchases
               WHERE film_id IN (SELECT id
                                 FROM Films
                                 WHERE title = 'Toy Story 2'))
  ORDER BY name;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1042414/step/11?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех пользователей, а также определяет количество фильмов, купленное каждым пользователем.
Поле с количеством купленных пользователем фильмов должно иметь псевдоним `num_of_films`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `num_of_films`, при совпадении — в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         (SELECT COUNT(*)
          FROM Purchases
          WHERE user_id = Users.id) AS num_of_films 
  FROM Users
  ORDER BY num_of_films DESC, name; 
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1042414/step/12?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии пользователей, которые приобрели ровно два фильма.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Users
  WHERE (SELECT COUNT(*)
         FROM Purchases
         WHERE user_id = Users.id) = 2
  ORDER BY name;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1042414/step/13?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имя и фамилию пользователя, который приобрел наибольшее количество фильмов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Users
  WHERE id = (SELECT user_id
              FROM Purchases
              GROUP BY user_id
              ORDER BY COUNT(*) DESC
              LIMIT 1);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1042414/step/14?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии пользователей, а также определяет название первого купленного каждым пользователем фильма. При этом в результирующую таблицу должны быть добавлены только те пользователи, которые приобрели хотя бы один фильм.
Поле с названием первого купленного пользователем фильма должно иметь псевдоним `first_film`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         (SELECT title
          FROM Films
          WHERE id = (SELECT film_id
                      FROM Purchases
                      WHERE user_id = Users.id
                      ORDER BY id
                      LIMIT 1)
         ) AS first_film
  FROM Users
  WHERE EXISTS (SELECT *
                FROM Purchases
                WHERE user_id = Users.id)
  ORDER BY name;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1042414/step/15?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех пользователей, а также определяет количество денег, потраченное каждым пользователем на покупку фильмов.
Поле с количеством денег, потраченных пользователем на покупку фильмов, должно иметь псевдоним `total_spending`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `total_spending`, при совпадении — в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         IFNULL((SELECT SUM(price)
          FROM Films
          WHERE id IN (SELECT film_id
                       FROM Purchases
                       WHERE user_id = Users.id)
          ), 0) AS total_spending
  FROM Users
  ORDER BY total_spending DESC, name;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1042414/step/16?unit=1050887)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии пользователей, а также определяет название самого дорогого купленного каждым пользователем фильма. При этом в результирующую таблицу должны быть добавлены только те пользователи, которые приобрели хотя бы один фильм. Если пользователем куплено несколько самых дорогих фильмов, в результирующую таблицу должен быть добавлен тот фильм, чье название меньше в лексикографическом сравнении.
Поле с названием самого дорогого купленного пользователем фильма должно иметь псевдоним `most_expensive_film`.
Записи в результирующей таблице должны быть расположены в порядке убывания цен самых дорогих купленных пользователями фильмов, при совпадении — в лексикографическом порядке названий этих фильмов, при совпадении — в лексикографическом порядке имен пользователей.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         (SELECT title
          FROM Films
          WHERE id IN (SELECT film_id
                       FROM Purchases
                       WHERE user_id = Users.id)
          ORDER BY price DESC, title
          LIMIT 1) AS most_expensive_film
  FROM Users
  WHERE EXISTS (SELECT *
                FROM Purchases
                WHERE user_id = Users.id)
  ORDER BY (SELECT price
            FROM Films
            WHERE title = most_expensive_film) DESC, 
            most_expensive_film, 
            name;
  ```

</details>
