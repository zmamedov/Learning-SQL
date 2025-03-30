# Границы окон

[Task №1](https://stepik.org/lesson/1264339/step/14?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных номера всех месяцев, а также указывает для каждого месяца среднее количество проданных товаров, учитывая лишь предыдущий, текущий и следующий месяцы.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month,
         AVG(quantity) OVER(ORDER BY month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_quantity
  FROM Sales;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264339/step/15?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца количество проданных товаров за предыдущий месяц.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month, quantity,
         COALESCE(SUM(quantity) OVER(ORDER BY month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) AS prev_month_quantity
  FROM Sales;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264339/step/16?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца суммарное количество проданных товаров за текущий и все предыдущие месяцы.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month, quantity,
         SUM(quantity) OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_quantity
  FROM Sales;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264339/step/17?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, начиная с третьего, а также указывает для каждого месяца среднее количество проданных товаров за два предыдущих месяца.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month, quantity,
         AVG(quantity) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS two_prev_months_avg_quantity
  FROM Sales
  LIMIT 10
  OFFSET 2;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264339/step/18?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца суммарное количество проданных товаров за текущий и все предыдущие месяцы в рамках квартала.

<details>
  <summary>Решение</summary>

  ```sql
  WITH QuarterSales AS (
      SELECT month, quantity,
             NTILE(4) OVER (ORDER BY month) AS quarter
      FROM Sales
  )
  
  SELECT month, quantity,
         SUM(quantity) OVER (PARTITION BY quarter ORDER BY month
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_quantity_within_quarter
  FROM QuarterSales;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1264339/step/28?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию обо всех заказах, а также указывает для каждого заказа среднюю сумму заказа, учитывая лишь все предыдущие дни, а также тот день, в который был совершен заказ.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id, date, amount,
         AVG(amount) OVER (ORDER BY date) AS avg_amount
  FROM Orders;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264339/step/29?unit=1278469)

Напишите запрос, который извлекает из предложенной базы данных всю информацию, а также указывает для каждого дня (даты), было ли продано в этот день товаров больше, чем в предыдущий день:

* `yes`, если товаров было продано больше;
* `no`, если товаров было продано столько же или меньше;
* `unknown`, если информация о продажах за предыдущий день отсутствует.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PrecedingDaySales AS (
      SELECT Sales.*,
             SUM(quantity) OVER (ORDER BY day 
                                 RANGE BETWEEN INTERVAL 1 DAY PRECEDING 
                                               AND INTERVAL 1 DAY PRECEDING) AS sales_yesterday
      FROM Sales
  )
  
  SELECT day, quantity,
         CASE 
             WHEN sales_yesterday < quantity THEN 'yes'
             WHEN sales_yesterday >= quantity THEN 'no'
             ELSE 'unknown'
         END AS sales_better_than_yesterday
  FROM PrecedingDaySales;
  ```

</details>
