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
