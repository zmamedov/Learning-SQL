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

