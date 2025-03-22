# Хранимые процедуры

[Task №1](https://stepik.org/lesson/1053556/step/7?unit=1062721)

Реализуйте процедуру `SHOW_TOP_SELLERS()`, которая не принимает никаких аргументов. Процедура должна извлекать из предложенной базы данных названия трех магазинов с наибольшей общей суммой продаж.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE SHOW_TOP_SELLERS()
  BEGIN
      SELECT store
      FROM Orders
      GROUP BY store
      ORDER BY SUM(amount) DESC
      LIMIT 3;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1053556/step/8?unit=1062721)

Реализуйте процедуру `DELETE_UNKNOWN_ORDERS()`, которая не принимает никаких аргументов. Процедура должна удалять из таблицы `Orders` заказы, которые были совершены в неизвестном магазине или на неизвестную сумму.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE DELETE_UNKNOWN_ORDERS()
  BEGIN
      DELETE FROM Orders
      WHERE store IS NULL OR amount IS NULL;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1053556/step/9?unit=1062721)

Реализуйте процедуру `ORDERS_STATISTICS()`, которая не принимает никаких аргументов. Процедура должна определять количество совершенных на маркетплейсе заказов, а также среднюю сумму заказа и указывать полученные значения в полях с псевдонимами `orders_count` и `avg_order_amount` соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE ORDERS_STATISTICS()
  BEGIN
      DECLARE orders_count INT;
      DECLARE avg_order_amount INT;
      
      SELECT COUNT(*) AS orders_count, AVG(amount) AS avg_order_amount
      FROM Orders;
  END //
  DELIMITER ;
  ```

</details>

---

