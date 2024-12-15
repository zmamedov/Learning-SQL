# Решение задач

[Task №1](https://stepik.org/lesson/1095761/step/1?unit=1106525)

Напишите запрос, определяющий количество клиентов банка, у которых хотя бы на одном счете находится больше `500` долларов, и указывающий полученное значение в поле с псевдонимом `customers_count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(DISTINCT customer_id) AS customers_count
  FROM Bills
  WHERE amount > 500;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1095761/step/2?unit=1106525)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы велосипедов, а также определяет дату и время окончания самой последней поездки, совершенной на каждом велосипеде.
Поле с датой и временем окончания самой последней совершенной на велосипеде поездки должно иметь псевдоним `last_ride_end`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `last_ride_end`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT bike_number, 
         MAX(end_time) AS last_ride_end
  FROM Rides
  GROUP BY bike_number
  ORDER BY last_ride_end DESC;
  ```

</details>

---

