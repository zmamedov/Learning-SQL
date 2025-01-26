# Решение задач. Часть 2

[Task №1](https://stepik.org/lesson/1095764/step/1?unit=1106528)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех пользователей площадки, а также определяет, сколько покупок совершил каждый пользователь в `2023` году.
Поле с количеством покупок, совершенных пользователем, должно иметь псевдоним `purchases_in_2023`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Users.id,
         COUNT(buyer_id) AS purchases_in_2023
  FROM Users
  LEFT JOIN Orders ON Users.id = buyer_id AND YEAR(order_date) = 2023
  GROUP BY Users.id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1095764/step/2?unit=1106528)

Напишите запрос, который определяет общее количество яблок и количество апельсинов во всех больших коробках. При этом если внутри большой коробки находится маленькая коробка, количество фруктов в маленькой коробке также должно быть учтено.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT SUM(BigBoxes.apple_count + IFNULL(SmallBoxes.apple_count, 0)) AS apple_count,
         SUM(BigBoxes.orange_count + IFNULL(SmallBoxes.orange_count, 0)) AS orange_count
  FROM BigBoxes
  LEFT JOIN SmallBoxes ON small_box_id = SmallBoxes.id;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1095764/step/3?unit=1106528)

Напишите запрос, который определяет все пары точек, образующих прямоугольник с ненулевой площадью, вычисляет площади прямоугольников, образуемых каждой парой, и отображает полученный результат в виде таблицы из трех полей:

* `p1` — идентификатор первой точки;
* `p2` — идентификатор второй точки;
* `area` — площадь прямоугольника, образуемого этими точками;

При этом в результирующую таблицу должны быть добавлены только уникальные пары точек. Например, пара точек с идентификаторами `1` и `2`, а также пара точек с идентификаторами `2` и `1` считаются одинаковыми. Из них должна быть выбрана только та пара, в которой идентификатор первой точки меньше второй.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `area`, при совпадении — в порядке возрастания значения поля `p1`, при совпадении — в порядке возрастания значения поля `p2`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT P1.id AS p1, P2.id AS p2,
         ABS((P2.x - P1.x) * (P2.y - P1.y)) AS area
  FROM Points P1
  CROSS JOIN Points P2
  WHERE P1.id < P2.id AND ABS((P2.x - P1.x) * (P2.y - P1.y)) != 0
  ORDER BY area DESC, p1, p2;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1095764/step/4?unit=1106528)

Напишите запрос, определяющий количество пользователей сервиса, которые имели активную подписку в `2023` году, но при этом не провели ни одной трансляции в `2023` году.
Поле с искомым количеством пользователей должно иметь псевдоним `users_count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(Subscriptions.user_id) AS users_count
  FROM Subscriptions
  LEFT JOIN Streams ON Streams.user_id = Subscriptions.user_id AND YEAR(stream_date) = 2023
  WHERE (2023 BETWEEN YEAR(start_date) AND YEAR(end_date)) AND Streams.user_id IS NULL;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1095764/step/5?unit=1106528)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы покупателей, которые в течение любых `7` дней совершили как минимум `2` заказа.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `customer_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT O1.customer_id AS customer_id
  FROM Orders O1
  INNER JOIN Orders O2 ON O1.customer_id = O2.customer_id AND ABS(DAYOFYEAR(O1.order_date) - DAYOFYEAR(O2.order_date)) < 7
  WHERE O1.id != O2.id
  ORDER BY customer_id;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1095764/step/6?unit=1106528)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех водителей, а также определяет, сколько раз каждый водитель был в качестве пассажира.
Поле с количеством поездок водителя в качестве пассажира должно иметь псевдоним `count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT R1.driver_id,
         COUNT(DISTINCT R2.id) AS count
  FROM Rides R1
  LEFT JOIN Rides R2 ON R1.driver_id = R2.passenger_id
  GROUP BY R1.driver_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1095764/step/7?unit=1106528)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех продавцов, а также определяет общую сумму, заработанную каждым продавцом.
Поле с заработанной продавцом суммой должно иметь псевдоним `total`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Salespersons.id AS id, IFNULL(SUM(price), 0) AS total
  FROM Customers
  INNER JOIN Orders ON Customers.id = customer_id
  RIGHT JOIN Salespersons ON salesperson_id = Salespersons.id
  GROUP BY Salespersons.id;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1095764/step/8?unit=1106528)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы и имена всех посетителей магазина, а также определяет статус каждого посетителя.
Поле со статусом посетителя должно иметь псевдоним `status`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Members.id,
         name,
         CASE 
             WHEN COUNT(Visits.id) = 0 THEN 'Bronze'
             WHEN 100 * COUNT(visit_id) / COUNT(Visits.id) >= 80 THEN 'Diamond'
             WHEN 100 * COUNT(visit_id) / COUNT(Visits.id) BETWEEN 50 AND 79 THEN 'Gold'
             ELSE 'Silver'
         END AS status  
  FROM Members
  LEFT JOIN Visits ON Members.id = member_id
  LEFT JOIN Purchases ON Visits.id = visit_id
  GROUP BY Members.id;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1095764/step/9?unit=1106528)

Напишите запрос, который для дней `2023-10-01`, `2023-10-02` и `2023-10-03` определяет коэффициент отмененных поездок и отображает полученный результат в виде таблицы из двух полей:

* `day` — день;
* `cancellation_rate` — коэффициент поездок, отмененных в этот день.

Значения в поле `cancellation_rate` должны быть округлены до `2` знаков после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT request_at AS day,
         ROUND(SUM(CASE
                      WHEN status = 'completed' THEN 0
                      ELSE 1
                   END) / COUNT(*), 2) AS cancellation_rate
  FROM Trips
  LEFT JOIN Users U1 ON client_id = U1.id
  LEFT JOIN Users U2 ON driver_id = U2.id
  WHERE request_at in ('2023-10-01', '2023-10-02', '2023-10-03')
        AND U1.banned = 'no'
        AND U2.banned = 'no'
  GROUP BY request_at;
  ```

</details>
