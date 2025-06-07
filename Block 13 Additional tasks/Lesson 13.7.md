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

[Task №6](https://stepik.org/lesson/1264342/step/6?unit=1293772)

Напишите запрос, извлекающий из предложенной базы данных информацию о средней температуре в каждый из дней, а также указывающий для каждого дня количество других дней, в которые средняя температура отличалась от средней температуры в этот день не больше чем на `1` градус.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT D1.day, D1.avg_temperature, COUNT(*) AS number_of_days_with_similar_temperature
  FROM DailyTemperature D1 CROSS JOIN DailyTemperature D2 ON D1.day != D2.day
  WHERE ABS(D1.avg_temperature - D2.avg_temperature) <= 1
  GROUP BY day
  ORDER BY day;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264342/step/7?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех услугах (дата оказания, категория, оценка), а также указывает для каждой услуги среднюю оценку всех услуг, учитывая лишь текущую услугу, а также предыдущую и следующую по времени услуги в той же категории.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT provided_on, category, score,
         AVG(score) OVER (PARTITION BY category ORDER BY provided_on ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_score
  FROM Procedures;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1264342/step/8?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех услугах (дата оказания, категория, стоимость), а также указывает для каждой услуги стоимость предыдущей по времени услуги и разницу между стоимостями этих услуг.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT provided_on, category, price,
         IFNULL(LAG(price) OVER time_procedure, 0) AS prev_procedure_price,
         ABS(price - IFNULL(LAG(price) OVER time_procedure, 0)) AS prev_procedure_price_difference
  FROM Procedures
  WINDOW time_procedure AS (ORDER BY provided_on);
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1264342/step/9?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех услугах (дата оказания, категория, стоимость, оценка), а также указывает для каждой услуги стоимость услуги с самой высокой оценкой в той же категории и разницу между стоимостями этих услуг. Если услуг с наибольшей оценкой несколько, то выбрана должна быть та услуга, что была оказана раньше всех остальных.

Поле со стоимостью наиболее высоко оцененной услугой должно иметь псевдоним `best_procedure_price`, поле с разницей между стоимостями услуг — `best_procedure_price_difference`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT provided_on, category, price, score,
         FIRST_VALUE(price) OVER score_by_category AS best_procedure_price,
         ABS(price - FIRST_VALUE(price) OVER score_by_category) AS best_procedure_price_difference
  FROM Procedures
  WINDOW score_by_category AS (PARTITION BY category ORDER BY score DESC, provided_on);
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1264342/step/10?unit=1293772)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех услугах (дата оказания, категория, стоимость), а также указывает для каждой услуги максимальную стоимость услуги, оказанной в этот же день или предыдущий.

Поле с максимальной стоимостью услуги, оказанной в двухдневный период, должно иметь псевдоним `yesterday_today_max_price`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT provided_on, category, price,
         MAX(price) OVER temp AS yesterday_today_max_price
  FROM Procedures
  WINDOW temp AS (ORDER BY DATE(provided_on) RANGE BETWEEN INTERVAL 1 DAY PRECEDING AND CURRENT ROW);
  ```

</details>

---

[Task №11](https://stepik.org/lesson/1264342/step/11?unit=1293772)

Напишите запрос, который разбивает процедуры на группы в зависимости от даты, в которую они были оказаны, вычисляет в рамках каждой группы количество оказанных услуг, и отображает полученный результат в виде таблицы из трех полей:

* `procedure_date` — дата оказания услуг;
* `number_of_procedures` — количество оказанных услуг в эту дату;
* `prev_date_number_of_procedures_difference` — разница между количеством услуг, оказанных в эту дату и ближайшую предыдущую. Если относительно этой даты нет ни одной предыдущей, поле должно содержать значение `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PreResult AS (
      SELECT DATE(provided_on) AS procedure_date, COUNT(*) AS number_of_procedures,
             LAG(COUNT(*)) OVER (ORDER BY DATE(provided_on) ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS prev_date_number_of_procedures
      FROM Procedures
      GROUP BY procedure_date
  )
  
  SELECT procedure_date, number_of_procedures, ABS(number_of_procedures - prev_date_number_of_procedures) AS prev_date_number_of_procedures_difference
  FROM PreResult;
  ```

</details>

---

[Task №12](https://stepik.org/lesson/1264342/step/12?unit=1293772)

Напишите запрос, который в рамках каждой категории услуг определяет врача, оказавшего наибольшее количество услуг с оценкой `5`, и отображает полученный результат в виде таблицы из трех полей:

* `category` — категория услуг;
* `doctor` — имя и фамилия врача, оказавшего наибольшее количество услуг с оценкой `5` в этой категории;
* `number_of_high_score_procedures` — количество оказанных врачом услуг с оценкой `5` в этой категории.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PreResult AS (
      SELECT doctor_id, category, COUNT(*) AS number_of_high_score_procedures,
             ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS doctor_rank
      FROM Procedures 
      WHERE score = 5
      GROUP BY doctor_id, category
  )
  
  SELECT category, CONCAT(name, ' ', surname) AS doctor, number_of_high_score_procedures  
  FROM PreResult JOIN Doctors ON Doctors.id = doctor_id
  WHERE doctor_rank = 1;
  ```

</details>
