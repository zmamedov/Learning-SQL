# Решение задач

[Task №1](https://stepik.org/lesson/1095762/step/1?unit=1106526)

Напишите запрос, который определяет коэффициент принятия заявок в друзья и указывает полученное значение в поле с псевдонимом `accept_rate`. Значение в поле `accept_rate` должно быть округлено до 2 знаков после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT ROUND(IFNULL(
      (SELECT COUNT(DISTINCT requester_id, accepter_id)
       FROM RequestsAccepted)
       /
      (SELECT COUNT(DISTINCT sender_id, send_to_id)
       FROM FriendRequests), 0), 2) AS accept_rate
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1095762/step/2?unit=1106526)

Напишите запрос, который оценивает игровые сессии в зависимости от количества набранных очков. Сессия, в которой набрано наибольшее количество очков, должна иметь оценку 1, следующая по количеству очков сессия — оценку 2, и так далее. Если какие-либо две сессии имеют равное количество очков, они должны иметь равную оценку.
Поле с оценкой игровой сессии должно иметь псевдоним `gamer_rank`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `gamer_rank`.
<details>
  <summary>Решение</summary>

  ```sql
  SELECT score, 
         (SELECT COUNT(DISTINCT score) 
          FROM Scores 
          WHERE score >= S.score) AS gamer_rank
  FROM Scores AS S
  ORDER BY gamer_rank DESC
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1095762/step/3?unit=1106526)

Напишите запрос, который извлекает из предложенной базы данных имена пользователей второго уровня, а также определяет количество подписчиков у каждого пользователя.
Поле с именем пользователя второго уровня должно иметь псевдоним user, поле с количеством его подписчиков — `followers`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля user.
<details>
  <summary>Решение</summary>

  ```sql
  SELECT followee AS user,
         COUNT(*) AS followers
  FROM Follow
  WHERE EXISTS (SELECT follower
                FROM Follow AS InnerFollow
                WHERE  follower = Follow.followee)
  GROUP BY user
  ORDER BY user;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1095762/step/4?unit=1106526)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы несбалансированных заказов.
<details>
  <summary>Решение</summary>

  ```sql
  SELECT id
  FROM Orders
  WHERE quantity > ALL(SELECT SUM(quantity) / COUNT(product_id)
                       FROM Orders
                       GROUP BY id);
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1095762/step/5?unit=1106526)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы кандидатов, которые:

* имеют опыт работы не меньше 2 лет
* во время собеседования суммарно набрали больше 15 баллов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id
  FROM Candidates
  WHERE years_of_exp >= 2 
        AND (SELECT SUM(score)
             FROM Rounds
             WHERE interview_id = Candidates.interview_id) > 15;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1095762/step/6?unit=1106526)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о заказах покупателей по следующему правилу:

* если у покупателя есть хотя бы один заказ типа 0, в результирующую таблицу должны быть добавлены только заказы типа 0 этого покупателя
* если у покупателя нет ни одного заказа типа 0, в результирующую таблицу должны быть добавлены все заказы этого покупателя

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id, customer_id, order_type
  FROM Orders
  WHERE order_type = (SELECT MIN(order_type)
                      FROM Orders AS InnerOrders
                      WHERE customer_id = Orders.customer_id
                      GROUP BY customer_id);
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1095762/step/7?unit=1106526)

Напишите запрос, который определяет результат олимпиады путем извлечения одного из следующих значений:

* `Moscow University`, если победителем является Московский университет
* `Saint Petersburg University`, если победителем является Санкт-Петербургский университет
* `No winner`, если олимпиада завершилась ничьей

Поле с результатом олимпиады должно иметь псевдоним `winner`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT CASE WHEN (SELECT COUNT(*)
                   FROM Moscow
                   WHERE Score >= 90) > (SELECT COUNT(*) 
                                         FROM SaintPetersburg 
                                         WHERE Score >= 90) THEN 'Moscow University'
              WHEN (SELECT COUNT(*)
                   FROM Moscow
                   WHERE Score >= 90) < (SELECT COUNT(*) 
                                         FROM SaintPetersburg 
                                         WHERE Score >= 90) THEN 'Saint Petersburg University'
              ELSE 'No winner'
         END AS winner;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1095762/step/8?unit=1106526)

Напишите запрос, который определяет общее количество очков, набранное каждой командой на момент участия каждого ее участника.
<details>
  <summary>Решение</summary>

  ```sql
  SELECT team, day,
         (SELECT SUM(score_points)
          FROM Scores
          WHERE team = S.team AND day <= S.day) AS total
  FROM Scores AS S
  ORDER BY team, day;
  ```

</details>
