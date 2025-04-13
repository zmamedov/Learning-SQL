# Решение задач

[Task №1](https://stepik.org/lesson/1264341/step/1?unit=1278471)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о третьей по счету поездке каждого пассажира.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RideNumber AS (
      SELECT Rides.*,
             ROW_NUMBER() OVER (PARTITION BY passenger_id) AS num
      FROM Rides
  )
  
  SELECT passenger_id, amount, requested_on
  FROM RideNumber
  WHERE num = 3;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264341/step/2?unit=1278471)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о количестве постов, опубликованных каждым пользователем в каждый из дней, а также указывает для каждого дня среднее количество опубликованных пользователем постов, учитывая лишь текущий день и два предыдущих.

Поле со средним количеством постов, опубликованных пользователем, должно иметь псевдоним `three_day_moving_avg_quantity`. 

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Posts.*,
         AVG(quantity) OVER three_day_posts AS three_day_moving_avg_quantity
  FROM Posts
  WINDOW three_day_posts AS (PARTITION BY user_id ORDER BY day RANGE BETWEEN INTERVAL 2 DAY PRECEDING AND CURRENT ROW);
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264341/step/3?unit=1278471)

Напишите запрос, который определяет кассовые сборы каждого фильма в первый месяц показа и отображает полученный результат в виде таблицы из двух полей:

* `movie` — название фильма;
* `first_month_box_office` — кассовые сборы фильма в первый месяц показа.

<details>
  <summary>Решение</summary>

  ```sql
  WITH NumberedMonthForMovie AS (
      SELECT BoxOffice.*,
             ROW_NUMBER() OVER (PARTITION BY movie ORDER BY month) AS movie_number
      FROM BoxOffice
  )
  
  SELECT movie, amount AS first_month_box_office
  FROM NumberedMonthForMovie
  WHERE movie_number = 1;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264341/step/4?unit=1278471)

Напишите запрос, который определяет, в какой день каждый из покупателей совершил свой последний заказ, вычисляет количество совершенных заказов в этот день и отображает полученный результат в виде таблицы из трех полей:

* `customer_id` — идентификатор покупателя;
* `last_order_day` — день совершения последнего заказа;
* `orders_count` — количество совершенных заказов в этот день.

<details>
  <summary>Решение</summary>

  ```sql
  WITH LastOrderDay AS (
      SELECT Orders.*,
             DATE(LAST_VALUE(purchased_on) OVER last_orders) AS last_order_day
      FROM Orders
      WINDOW last_orders AS (PARTITION BY customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  )
  
  SELECT customer_id, last_order_day, COUNT(*) AS orders_count
  FROM LastOrderDay
  WHERE DATE(purchased_on) = last_order_day
  GROUP BY customer_id, last_order_day;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264341/step/5?unit=1278471)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы платежей, по ошибке совершенных повторно.

Поле с идентификатором случайно совершенного повторно платежа должно иметь псевдоним `repeat_payment_id`.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `repeat_payment_id`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PrecedingDateTime AS (
      SELECT Payments.*,
             LAG(completed_on, 1) OVER user_payments AS prev_datetime
      FROM Payments 
      WINDOW user_payments AS (PARTITION BY user_id, card_id, amount ORDER BY id)
  )
  
  SELECT id AS repeat_payment_id
  FROM PrecedingDateTime
  WHERE TIMESTAMPDIFF(SECOND, prev_datetime, completed_on) <= 600
  ORDER BY repeat_payment_id;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1264341/step/6?unit=1278471)

Напишите запрос, который разбивает результаты измерений на группы в зависимости от дня, в который они были выполнены, вычисляет в рамках каждой группы сумму результатов нечетных и четных по счету измерений и отображает полученный результат в виде таблицы из трех полей:

1. `measurement_day` — день, в который были выполнены измерения;
2. `odd_measurements_results_sum` — сумма результатов нечетных измерений в этот день (результат первого измерения, результат третьего измерения, и так далее);
3. `even_measurements_results_sum` — сумма результатов четных измерений в этот день (результат второго измерения, результат четвертого измерения, и так далее).

<details>
  <summary>Решение</summary>

  ```sql
  WITH NumberedMeasurement AS (
      SELECT Measurements.*,
             ROW_NUMBER() OVER (PARTITION BY DATE(received_on) ORDER BY received_on) AS number_measurement
      FROM Measurements
  )
  
  SELECT DATE(received_on) AS measurement_day,
         SUM(IF(number_measurement mod 2 != 0, result, 0)) AS odd_measurements_results_sum,
         SUM(IF(number_measurement mod 2 = 0, result, 0)) AS even_measurements_results_sum
  FROM NumberedMeasurement
  GROUP BY measurement_day;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264341/step/7?unit=1278471)

Напишите запрос, который извлекает из предложенной базы данных имена исполнителей, чьи песни чаще всего занимают первое или второе место в ежедневных чартах.

<details>
  <summary>Решение</summary>

  ```sql
  WITH CountTopSongs AS (
      SELECT DISTINCT artist,
             COUNT(*) OVER artist_window AS top_songs
      FROM SongCharts
      INNER JOIN Songs ON song_id = Songs.id
      WHERE place IN (1, 2)
      WINDOW artist_window AS (PARTITION BY artist)
  )
  
  SELECT artist
  FROM CountTopSongs
  WHERE top_songs = (SELECT MAX(top_songs)
                     FROM CountTopSongs);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1264341/step/8?unit=1278471)

Напишите запрос, определяющий в каждой категории два товара, продажи которых принесли наибольшую суммарную прибыль, и отображающий полученный результат в виде таблицы из трех полей:

* `category` — категория товара;
* `product` — название товара;
* `total_amount` — суммарная прибыль, которую принесли продажи товара.

Если в категории находится более двух товаров, принесших наибольшую суммарную прибыль, в результирующую таблицу должны быть добавлены те, чье название меньше в лексикографическом сравнении.

<details>
  <summary>Решение</summary>

  ```sql
  WITH ProductTotalAmount AS (
      SELECT Orders.*,
             SUM(amount) OVER (PARTITION BY product) AS total_amount
      FROM Orders
  ),
  TopOrders AS (
      SELECT product, category, total_amount,
             ROW_NUMBER() OVER wdw AS number_product_sales
      FROM ProductTotalAmount
      GROUP BY product, category, total_amount
      WINDOW wdw AS (PARTITION BY category ORDER BY total_amount DESC, product)
  )
  
  SELECT category, product, total_amount
  FROM TopOrders
  WHERE number_product_sales IN (1, 2);
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1264341/step/9?unit=1278471)

Напишите запрос, определяющий количество дней, которое проработал каждый сервер, и отображающий полученный результат в виде таблицы из двух полей:

* `server_id` — идентификатор сервера;
* `total_uptime_days` — количество проработанных дней.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PrecedingStatusTime AS (
      SELECT *,
             LAG(status_time, 1) OVER (PARTITION BY server_id ORDER BY status_time) AS prev_datetime
      FROM ServerUtilization
  )
  
  SELECT server_id,
         TRUNCATE(SUM(TIMESTAMPDIFF(SECOND, prev_datetime, status_time)) / 3600 / 24, 0) AS total_uptime_days
  FROM PrecedingStatusTime
  WHERE session_status = 'stop'
  GROUP BY server_id;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1264341/step/10?unit=1278471)

Напишите запрос, который группирует одинаковые товары в зависимости от месяца, в который они были проданы, вычисляет в рамках каждой группы суммарную прибыль, которую принесли продажи товара, и отображает полученный результат в виде таблицы из четырех полей:

* `month` — полное название месяца на английском;
* `product` — название товара;
* `total_amount` — суммарная прибыль, которую принесли продажи товара в этом месяце;
* `nearest_prev_month_total_amount` — суммарная прибыль, которую принесли продажи товара в ближайшем предыдущем месяце (например, в предпредыдущем, если в предыдущем месяце товар не был продан ни разу). Если товар не был продан ни разу ни в одном из предыдущих месяцев, поле должно содержать значение `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT MONTHNAME(purchased_on) AS month,product, SUM(amount) AS total_amount,
         LAG(SUM(amount)) OVER (PARTITION BY product ORDER BY product) AS nearest_prev_month_total_amount
  FROM Orders
  GROUP BY product, MONTHNAME(purchased_on)
  ```

</details>
