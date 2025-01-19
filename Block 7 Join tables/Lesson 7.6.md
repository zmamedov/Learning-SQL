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

