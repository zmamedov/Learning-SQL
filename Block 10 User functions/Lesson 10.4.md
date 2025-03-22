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

[Task №4](https://stepik.org/lesson/1053556/step/15?unit=1062721)

Реализуйте процедуру `ORDERS_FROM_TO()`, которая принимает два аргумента в следующем порядке:

* `start_date` — начальная дата;
* `end_date` — конечная дата.

Процедура должна извлекать из предложенной базы данных всю информацию о заказах, которые были сделаны со `start_date` по `end_date` включительно.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE ORDERS_FROM_TO(IN start_date DATE, IN end_date DATE)
  BEGIN
      SELECT *
      FROM Orders
      WHERE order_date BETWEEN start_date AND end_date;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1053556/step/16?unit=1062721)

Реализуйте процедуру `STORE_STATISTICS()`, которая принимает четыре аргумента в следующем порядке:

* `store_name` — строка, название магазина;
* `avg_order_amount` — пользовательская переменная;
* `min_order_amount` — пользовательская переменная;
* `max_order_amount` — пользовательская переменная.

<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

[Task №6](https://stepik.org/lesson/1053556/step/17?unit=1062721)

Реализуйте процедуру `UPDATE_ORDER_STATUS()`, которая принимает два аргумента в следующем порядке:

* `order_id` — целое число, идентификатор заказа;
* `updated_status` — пользовательская переменная.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE UPDATE_ORDER_STATUS(IN order_id INT, OUT updated_status TEXT)
  BEGIN
      UPDATE Orders
      SET status = CASE
                       WHEN status = 'Created' THEN 'Shipped'
                       WHEN status = 'Shipped' THEN 'Delivered'
                       WHEN status = 'Delivered' THEN 'Completed'
                   END
      WHERE id = order_id;
        
      SET updated_status := (SELECT status
                             FROM Orders
                             WHERE id = order_id);
  END //
  DELIMITER ;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1053556/step/18?unit=1062721)

Реализуйте процедуру `ORDERS_COUNT()`, которая принимает один аргумент:

* `store_name` — строка, название магазина, или значение `NULL`.

Если значение `store_name` является строкой, процедура должна определить общее количество совершенных заказов в магазине `store_name`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE ORDERS_COUNT(IN store_name TEXT)
  BEGIN
      IF store_name IS NULL THEN
          SELECT store, COUNT(*) AS orders_count
          FROM Orders
          GROUP BY store;
      ELSE
          SELECT COUNT(*) AS orders_count
          FROM Orders
          WHERE store = store_name
          GROUP BY store;
      END IF;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1053556/step/19?unit=1062721)

Реализуйте процедуру `ADD_ORDER()`, которая принимает два аргумента в следующем порядке:

* `store_name` — строка, название магазина, или значение `NULL`;
* `order_amount` — целое число, сумма заказа, или значение `NULL`.


<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE PROCEDURE ADD_ORDER(IN store_name TEXT, IN order_amount INT)
  BEGIN
      IF store_name IS NULL OR order_amount IS NULL THEN
          SELECT 'Недостаточно данных о заказе' AS Error;
      ELSEIF store_name IS NOT NULL AND order_amount <= 0 THEN
          SELECT 'Некорректная сумма заказа' AS Error;
      ELSE
          INSERT INTO Orders (store, amount)
          VALUES (store_name, order_amount);
          SELECT 'Заказ успешно добавлен' AS Success;
      END IF;
  END //
  DELIMITER ;
  ```

</details>
