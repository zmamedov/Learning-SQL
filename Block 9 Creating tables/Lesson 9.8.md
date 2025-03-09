# Обобщенные табличные выражения. Часть 2

[Task №1](https://stepik.org/lesson/1153769/step/11?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую квадраты всех целых чисел от `1` до `10` включительно.
Поле с квадратом целого числа должно иметь псевдоним `number`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE SquareNumbers AS (
      SELECT 1 AS number,
             1 AS square
      UNION ALL
      SELECT number + 1,
             POWER(number + 1, 2) 
      FROM SquareNumbers
      LIMIT 10
  )
  
  SELECT square AS number
  FROM SquareNumbers;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1153769/step/12?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую все даты с `31` декабря `2024` года по `1` декабря `2024` включительно.

Поле с датой должно иметь псевдоним `day`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE DateInDecember AS (
      SELECT '2024-12-31' AS day
      UNION ALL
      SELECT SUBDATE(day, INTERVAL 1 DAY)
      FROM DateInDecember
      LIMIT 31
  )
  
  SELECT *
  FROM DateInDecember;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1153769/step/13?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую все заглавные латинские буквы от `A` до `Z` включительно.

Поле с латинской буквой должно иметь псевдоним `letter`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE LetterCode AS (
      SELECT 65 AS code_ascii
      UNION ALL 
      SELECT code_ascii + 1
      FROM LetterCode
      LIMIT 26
  )
  
  SELECT CONVERT(CHAR(code_ascii), CHAR) AS letter
  FROM LetterCode;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1153769/step/14?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую названия всех `12` месяцев на английском языке.

Поле с названием месяца должно иметь псевдоним `month`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE MonthDate AS (
      SELECT '2024-01-01' AS date
      UNION ALL
      SELECT date + INTERVAL 1 MONTH
      FROM MonthDate
      LIMIT 12
  )
  
  SELECT MONTHNAME(date) AS month
  FROM MonthDate;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1153769/step/15?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую все целые числа от `1` до `20` включительно, а также их факториалы.

Поле с целым числом должно иметь псевдоним `number`, поле с факториалом числа — `factorial`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE FactorialNumber AS (
      SELECT 1 AS number,
             1 AS factorial
      UNION ALL
      SELECT number + 1,
             factorial * (number + 1)
      FROM FactorialNumber
      LIMIT 20
  )
  
  SELECT *
  FROM FactorialNumber;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1153769/step/16?unit=1165884)

Напишите запрос, который извлекает таблицу, содержащую `20` случайных целых чисел в диапазоне `[10; 50]`.

Поле со случайным числом должно иметь псевдоним `number`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE RandomNumber AS ( 
      SELECT 10 AS number
      UNION ALL
      SELECT number + 1
      FROM RandomNumber
      LIMIT 41
  )
  
  SELECT *
  FROM RandomNumber
  ORDER BY RAND()
  LIMIT 20;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1153769/step/17?unit=1165884)

Напишите запрос, который извлекает из предложенной базы данных все целые числа, располагая их в порядке возрастания и добавляя между ними отсутствующие значения (например, число `4` между числами `3` и `5`).

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE AllNumbers AS (
      SELECT MIN(num) AS num
      FROM Numbers
      UNION ALL
      SELECT num + 1
      FROM AllNumbers
      WHERE num < (SELECT MAX(num)
                   FROM Numbers)
  )
  
  SELECT *
  FROM AllNumbers;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1153769/step/18?unit=1165884)

Напишите запрос, который извлекает из предложенной базы данных все даты, располагая их в порядке возрастания и добавляя между ними отсутствующие даты (например, дату `2023-12-30` между датами `2023-12-29` и `2023-12-31`). Помимо этого, для каждой даты должно быть указано количество заказов, совершенных в эту дату.

Поле с количеством заказов, совершенных в определенную дату, должно иметь псевдоним `orders_count`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE AllDates AS (
      SELECT MIN(order_date) AS order_date
      FROM Orders
      UNION ALL
      SELECT order_date + INTERVAL 1 DAY
      FROM AllDates
      WHERE order_date < (SELECT MAX(order_date) FROM Orders)
  )
  
  SELECT AllDates.order_date AS order_date, 
         COUNT(Orders.id) AS orders_count
  FROM AllDates
  LEFT JOIN Orders ON AllDates.order_date = Orders.order_date
  GROUP BY AllDates.order_date;
  ```

</details>
