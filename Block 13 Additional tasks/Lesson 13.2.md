# Базовые соединения

[Task №1](https://stepik.org/lesson/1072301/step/1?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех сотрудниках компании: имя, фамилия, зарплата. Если зарплата сотрудника неизвестна, она считается равной `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, salary
  FROM Employees
  LEFT JOIN Salary ON Employees.id = employee_id;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072301/step/2?unit=1082125)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы пользователей, посетивших сайт магазина без единой покупки, а также для каждого пользователя указывает количество таких посещений.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT customer_id, COUNT(*) AS count_no_trans
  FROM Visits
  LEFT JOIN Sales ON Visits.id = visit_id
  WHERE visit_id IS NULL
  GROUP BY customer_id;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072301/step/3?unit=1082125)

Напишите запрос, извлекающий из предложенной базы данных даты, в которые ожидаемая температура превышает ожидаемую температуру в предыдущий день.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT W1.record_date
  FROM Weather W1
  INNER JOIN Weather W2 ON W1.record_date = ADDDATE(W2.record_date, INTERVAL 1 DAY)
  WHERE W1.temperature > W2.temperature;
  ```

</details>

---

