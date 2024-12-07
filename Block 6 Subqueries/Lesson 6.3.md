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

