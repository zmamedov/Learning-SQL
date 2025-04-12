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

