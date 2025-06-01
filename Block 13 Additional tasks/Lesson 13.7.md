# Оконные функции

[Task №1](https://stepik.org/lesson/1264342/step/1?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех заказах (название магазина, имя покупателя, фамилия покупателя, сумма заказа), а также пронумеровывает их, начиная с `1`, в рамках магазина в порядке убывания суммы. При этом если два заказа из одного магазина имеют равные суммы, то их номера также должны совпадать.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DENSE_RANK() OVER order_rank AS rank_within_store_by_price,
         store, name, surname, amount
  FROM Customers JOIN Orders ON Customers.id = customer_id
  WINDOW order_rank AS (PARTITION BY store ORDER BY amount DESC);
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264342/step/2?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию о втором по времени заказе, совершенном в магазине `POP SHOP`: идентификатор заказа, имя покупателя, фамилия покупателя, сумма заказа, дата и время заказа.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PopShopOrders AS (
      SELECT Orders.id, name, surname, amount, purchased_on,
             ROW_NUMBER() OVER order_num AS row_num
      FROM Customers JOIN Orders ON Customers.id = customer_id
      WHERE store = 'POP SHOP'
      WINDOW order_num AS (ORDER BY purchased_on)
  )
  
  SELECT id, name, surname, amount, purchased_on
  FROM PopShopOrders
  WHERE row_num = 2;
  ```

</details>

---

