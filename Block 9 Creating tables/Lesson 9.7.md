# Обобщенные табличные выражения. Часть 1

[Task №1](https://stepik.org/lesson/1096402/step/9?unit=1107184)

Напишите запрос, который разбивает студентов на группы в зависимости от текстового эквивалента их оценки, определяет количество студентов в каждой группе и отображает полученный результат в виде таблицы из двух полей:

* `result` — текстовый эквивалент оценки (`Great`, `Well` или `Bad`);
* `students` — количество студентов, получивших оценку, соответствующую этому текстовому эквиваленту.

<details>
  <summary>Решение</summary>

  ```sql
  WITH StudentsResult AS (
      SELECT name, surname, 
             CASE
                WHEN grade IN ('A', 'B') THEN 'Great'
                WHEN grade = 'C' THEN 'Well'
                ELSE 'Bad'
             END AS result
      FROM Math
  )
  
  SELECT result,
         COUNT(*) AS students
  FROM StudentsResult
  GROUP BY result;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1096402/step/10?unit=1107184)

Напишите запрос, который определяет имя покупателя с наибольшей средней суммой заказа и указывает полученный результат в поле с псевдонимом `customer`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MaxAvgAmount AS (
      SELECT customer_id
      FROM Orders
      GROUP BY customer_id
      ORDER BY AVG(amount) DESC
      LIMIT 1
  )
  
  SELECT name AS customer
  FROM Customers
  WHERE id = (SELECT *
              FROM MaxAvgAmount);
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1096402/step/11?unit=1107184)

Напишите запрос, определяющий название магазина, который заработал наибольшее количество денег в июне, а также название магазина, который заработал наибольшее количество денег в июле. Полученные значения должны быть указаны в полях с псевдонимами `best_in_june` и `best_in_july` соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  WITH SumAmountOfStoreMonth AS (
  	  SELECT store, MONTH(order_date) AS order_month, SUM(amount) AS sum_amount
      FROM Orders
      GROUP BY MONTH(order_date), store
  )
  
  SELECT (SELECT store 
          FROM SumAmountOfStoreMonth
          WHERE order_month = 6
          ORDER BY sum_amount DESC LIMIT 1) AS best_in_june,
         (SELECT store 
          FROM SumAmountOfStoreMonth
          WHERE order_month = 7
          ORDER BY sum_amount DESC LIMIT 1) AS best_in_july;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1096402/step/12?unit=1107184)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о каждом заказе. Также рядом с данными о каждом заказе должна быть указана средняя сумма заказа в том магазине, в котором был совершен заказ.

Поле со средней суммой заказа в магазине должно иметь псевдоним `avg_for_store`. Значения в поле `avg_for_store` должны быть округлены до `1` знака после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  WITH AvgAmountStore AS (
      SELECT store, ROUND(AVG(amount), 1) AS avg_for_store
      FROM Orders
      GROUP BY store
  )
  
  SELECT id, Orders.store, amount, avg_for_store
  FROM Orders
  LEFT JOIN AvgAmountStore ON Orders.store = AvgAmountStore.store;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1096402/step/13?unit=1107184)

Напишите запрос, который определяет идентификаторы аэропортов с наибольшим трафиком.
Поле с идентификатором аэропорта должно иметь псевдоним `airport_id`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH CountFlights AS (
      SELECT F1.departure_airport,
             F1.flights_count + IFNULL(SUM(F2.flights_count), 0) AS count_flights
      FROM Flights F1
      LEFT JOIN Flights F2 ON F1.departure_airport = F2.arrival_airport
      GROUP BY F1.departure_airport
  )
  
  SELECT departure_airport AS airport_id
  FROM CountFlights
  WHERE count_flights = (SELECT MAX(count_flights)
                         FROM CountFlights);
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1096402/step/14?unit=1107184)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы и имена сотрудников организаций, а также зарплату каждого сотрудника после уплаты налогов.

Поле с идентификатором сотрудника должно иметь псевдоним `id`, поле с именем — `name`. Значения в поле `salary` должны быть округлены до ближайшего целого числа.

<details>
  <summary>Решение</summary>

  ```sql
  WITH MaxCompanySalary AS (
      SELECT company_id, MAX(salary) AS max_salary
      FROM Salaries
      GROUP BY company_id
  )
  
  SELECT employee_id AS id,
         employee_name AS name,
         ROUND(CASE 
                  WHEN max_salary < 1000 THEN salary
                  WHEN max_salary BETWEEN 1000 AND 10000 THEN (1- 0.24) * salary
                  ELSE (1- 0.49) * salary
               END) AS salary
  FROM Salaries
  INNER JOIN MaxCompanySalary ON Salaries.company_id = MaxCompanySalary.company_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1096402/step/15?unit=1107184)

Каждый избиратель имеет `1` голос, который он может отдать одному или нескольким кандидатам. Если избиратель голосует за нескольких кандидатов, его голос распределяются между ними поровну. Например, если избиратель голосует за 2 кандидатов, каждый из них получит по `0.5` голосов.

Напишите запрос, который определяет имя кандидата, набравшего наибольшее количество голосов.

<details>
  <summary>Решение</summary>

  ```sql
  WITH PartVote AS (
      SELECT voter, IFNULL(1/COUNT(candidate), 0) AS vote_part
      FROM Votes
      GROUP BY voter
  )
  
  SELECT candidate
  FROM Votes
  INNER JOIN PartVote ON Votes.voter = PartVote.voter
  GROUP BY candidate
  ORDER BY SUM(vote_part) DESC
  LIMIT 1;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1096402/step/16?unit=1107184)

Напишите запрос, который определяет, со скольким количеством пассажиров выедет из автовокзала каждый автобус, и отображает полученный результат в виде таблицы из двух полей:

* `bus_id` — идентификатор автобуса;
* `passenger_count` — количество пассажиров в этом автобусе.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `bus_id`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH AllPossibleBuses AS (
      SELECT Passengers.id AS passenger_id, arrival_time, Buses.id as bus_id, departure_time, 
             (departure_time - arrival_time) AS diff_time
      FROM Passengers
      CROSS JOIN Buses
      WHERE (departure_time - arrival_time) >= 0
  ),
  MinDiffTime AS (
      SELECT passenger_id, MIN(diff_time) AS min_time
      FROM AllPossibleBuses
      GROUP BY passenger_id 
  )
                 
  SELECT bus_id, 
         COUNT(ab.passenger_id) AS passenger_count
  FROM AllPossibleBuses ab
  INNER JOIN MinDiffTime md ON ab.passenger_id = md.passenger_id
  WHERE diff_time = min_time
  GROUP BY bus_id
  ORDER BY bus_id;
  ```

</details>
