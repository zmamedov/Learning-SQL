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

