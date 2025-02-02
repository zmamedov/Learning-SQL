# Удаление данных

[Task №1](https://stepik.org/lesson/1045356/step/10?unit=1053931)

Напишите запрос, который удаляет из таблицы `Purchases` всю информацию о совершенных пользователями покупках.

<details>
  <summary>Решение</summary>

  ```sql
  TRUNCATE Purchases;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1045356/step/11?unit=1053931)

Напишите запрос, который удаляет из таблицы `Users` информацию о пользователях, которые не приобрели ни одного фильма.

<details>
  <summary>Решение</summary>

  ```sql
  DELETE FROM Users
  WHERE id NOT IN (SELECT user_id
                   FROM Purchases);
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1045356/step/12?unit=1053931)

Напишите запрос, который удаляет из таблицы `Purchases` информацию о двух последних совершенных покупках пользователем `Matt Damon`.

<details>
  <summary>Решение</summary>

  ```sql
  DELETE FROM Purchases
  WHERE user_id = (SELECT id
                   FROM Users
                   WHERE user = 'Matt Damon')
  ORDER BY id DESC 
  LIMIT 2;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1045356/step/13?unit=1053931)

Напишите запрос, который удаляет из таблицы `Users` информацию о пользователе `Matt Damon` с предварительным удалением информации о покупках, совершенных этим пользователем.

<details>
  <summary>Решение</summary>

  ```sql
  DELETE FROM Purchases 
  WHERE user_id IN (SELECT id
                    FROM Users
                    WHERE user = 'Matt Damon');
                    
  DELETE FROM Users
  WHERE user = 'Matt Damon';
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1045356/step/14?unit=1053931)

Напишите запрос, который удаляет из таблицы `Films` информацию о фильмах серии `Toy Story` с предварительным удалением информации о покупках фильмов этой серии.

<details>
  <summary>Решение</summary>

  ```sql
  DELETE FROM Purchases
  WHERE film_id in (SELECT id
                    FROM Films
                    WHERE title LIKE 'Toy Story%');
  DELETE FROM Films
  WHERE title LIKE 'Toy Story%';
  ```

</details>
