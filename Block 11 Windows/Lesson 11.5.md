# Функции смещения

[Task №1](https://stepik.org/lesson/1264340/step/8?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца номер месяца, в который было продано наибольшее количество товаров.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month, quantity,
         FIRST_VALUE(month) OVER (ORDER BY quantity DESC) AS highest_sales_month
  FROM Sales
  ORDER BY month;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264340/step/9?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию обо всех заказах, а также указывает для каждого заказа, на сколько дней раньше или позже он был совершен чем самый дешевый заказ (заказ на наименьшую сумму).

<details>
  <summary>Решение</summary>

  ```sql
  WITH DayCheapestOrder AS (
      SELECT id, date, amount,
             FIRST_VALUE(date) OVER (ORDER BY amount) AS day_cheapest_order
      FROM Orders
  )
  
  SELECT id, date, amount,
         ABS(DATEDIFF(date, day_cheapest_order)) AS days_between_cheapest_order
  FROM DayCheapestOrder
  ORDER BY id;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264340/step/10?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца номер месяца, в который было продано наибольшее количество товаров в рамках квартала. Помимо номера месяца, должно быть указано само количество проданных товаров.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MonthQuarter AS (
      SELECT month, quantity,
             NTILE(4) OVER (ORDER BY month) AS quarter
      FROM Sales
  )
  
  SELECT month, quantity,
         FIRST_VALUE(month) OVER (PARTITION BY quarter ORDER BY quantity DESC) AS highest_sales_month_within_quarter,
         FIRST_VALUE(quantity) OVER (PARTITION BY quarter ORDER BY quantity DESC) AS highest_sales_quantity_within_quarter
  FROM MonthQuarter
  ORDER BY month;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264340/step/11?unit=1278470)

Напишите запрос, который разбивает все месяцы по кварталам, определяет для каждого квартала месяц, в который было продано наименьшее количество товаров, и отображает полученный результат в виде таблицы из трех полей:

* `quarter` — номер квартала;
* `lowest_sales_month` — номер месяца, в который было продано наименьшее количество товаров;
* `lowest_sales_quantity` — соответствующее месяцу количество проданных товаров.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MonthQuarter AS (
      SELECT month, quantity,
             NTILE(4) OVER (ORDER BY month) AS quarter
      FROM Sales
  )
  
  SELECT DISTINCT quarter,
         FIRST_VALUE(month) OVER lowest_sales AS lowest_sales_month,
         FIRST_VALUE(quantity) OVER lowest_sales AS lowest_sales_quantity
  FROM MonthQuarter
  WINDOW lowest_sales AS (PARTITION BY quarter ORDER BY quantity);
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264340/step/12?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных все дни (даты), в которые было совершено хотя бы два заказа, и указывает для каждого дня разницу в суммах между первым и вторым заказами, совершенными в этот день. 

<details>
  <summary>Решение</summary>

  ```sql
  WITH CountOrdersDay AS (
      SELECT Orders.*,
             COUNT(*) OVER same_day AS count_orders_day,
             NTH_VALUE(amount, 1) OVER same_day AS first_amount,
             NTH_VALUE(amount, 2) OVER same_day AS second_amount
      FROM Orders
      WINDOW same_day AS (PARTITION BY date ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  )
  
  SELECT DISTINCT date, ABS(second_amount - first_amount) AS two_first_orders_amount_diff
  FROM CountOrdersDay
  WHERE count_orders_day > 1;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1264340/step/20?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца количество проданных товаров за предыдущий и предпредыдущий месяцы.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT month, quantity, 
         LAG(quantity, 1, 0) OVER month_sales AS prev_month_sales,
         LAG(quantity, 2, 0) OVER month_sales AS second_prev_month_sales
  FROM Sales
  WINDOW month_sales AS (ORDER BY month);
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264340/step/21?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за каждый месяц, а также указывает для каждого месяца количество проданных товаров в соответствующем месяце предыдущего квартала: для первого месяца квартала соответствующим месяцем является первый месяц предыдущего квартала, для второго — второй, для третьего — третий.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MonthQuarter AS (
      SELECT month, quantity,
             NTILE(4) OVER (ORDER BY month) AS quarter
      FROM Sales
  ),
  RowQuarter AS (
      SELECT month, quantity,
             ROW_NUMBER() OVER (PARTITION BY quarter ORDER BY month) AS month_quarter
      FROM MonthQuarter
  )
  
  SELECT month, quantity,
         LAG(quantity, 1, 0) OVER quarter_sales AS prev_quarter_month_sales
  FROM RowQuarter
  WINDOW quarter_sales AS (PARTITION BY month_quarter ORDER BY month);
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1264340/step/22?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за те месяцы, в которые товаров было продано больше чем в предыдущем месяце.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PrevMonth AS (
      SELECT Sales.*,
             LAG(quantity, 1, 0) OVER (ORDER BY month) AS prev_month_quantity
      FROM Sales
  )
  
  SELECT month, quantity
  FROM PrevMonth
  WHERE quantity > prev_month_quantity;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1264340/step/23?unit=1278470)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах за все месяцы, кроме последнего, а также указывает для каждого месяца разницу в количестве проданных товаров между текущим месяцем и следующим.

<details>
  <summary>Решение</summary>

  ```sql
  WITH NextMonth AS (
      SELECT Sales.*,
             LEAD(quantity, 1, 0) OVER (ORDER BY month) AS next_month_sales
      FROM Sales
  )
  
  SELECT month, quantity,
         ABS(quantity - next_month_sales) AS next_month_sales_diff
  FROM NextMonth
  WHERE month != 12;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1264340/step/24?unit=1278470)

Напишите запрос, который разбивает все месяцы по кварталам, определяет среднее изменение количества проданных товаров в каждом квартале и отображает полученный результат в виде таблицы из двух полей:

* `quarter` — номер квартала;
* `sales_avg_diff` — среднее изменение количества проданных товаров.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MonthQuarter AS (
      SELECT Sales.*,
             NTILE(4) OVER (ORDER BY month) AS quarter
      FROM Sales
  ),
  NextMonthSales AS (
      SELECT MonthQuarter.*,
             COALESCE(ABS(quantity - LEAD(quantity, 1) OVER next_month_quarter), 0) AS next_month_diff
      FROM MonthQuarter
      WINDOW next_month_quarter AS (PARTITION BY quarter ORDER BY month)
  )
  
  SELECT quarter, SUM(next_month_diff) / 2 AS sales_avg_diff
  FROM NextMonthSales
  GROUP BY quarter;
  ```

</details>
