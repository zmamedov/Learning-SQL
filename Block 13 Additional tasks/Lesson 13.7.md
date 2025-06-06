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

[Task №3](https://stepik.org/lesson/1264342/step/3?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех заказах (имя покупателя, фамилия покупателя, сумма заказа, дата и время заказа), а также указывает для каждого заказа суммарную стоимость всех заказов, учитывая лишь текущий заказ, а также те заказы, что были совершены раньше по времени.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, amount, purchased_on,
         SUM(amount) OVER sum_amount AS increasing_amount
  FROM Customers JOIN Orders ON Customers.id = customer_id
  WINDOW sum_amount AS (ORDER BY purchased_on ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264342/step/4?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных все дни с `10` февраля по `25` февраля включительно, а также указывает для каждого дня среднюю дневную температуру в этот день и среднюю дневную температуру `3` дня назад.

<details>
  <summary>Решение</summary>

  ```sql
  WITH AvgTemp3Day AS (
      SELECT day, avg_temperature,
             LAG(avg_temperature, 3) OVER (ORDER BY day) AS avg_temperature_3_days_ago
      FROM DailyTemperature
  )
  
  SELECT *
  FROM AvgTemp3Day
  WHERE day BETWEEN '2024-02-10' AND '2024-02-25';
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264342/step/5?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных все дни с `1` февраля по `14` февраля включительно, а также указывает для каждого дня среднюю дневную температуру в этот день и среднюю дневную температуру через `7` дней.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PreResult AS (
      SELECT day, avg_temperature,
             LEAD(avg_temperature, 7) OVER (ORDER BY day) AS avg_temperature_after_7_days
      FROM DailyTemperature
  )
  
  SELECT *
  FROM PreResult
  WHERE day BETWEEN '2024-02-01' AND '2024-02-14';
  ```

</details>

---

