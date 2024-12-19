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

[Task №3](https://stepik.org/lesson/1095761/step/3?unit=1106525)

Напишите запрос, извлекающий из предложенной базы данных все причины жалоб на посты, а также определяющий количество постов, на которые пожаловались по каждой из этих причин. При этом учитываться должны только те посты, жалоба на которые была подана `2023-07-05`.
Поле с причиной жалобы должно иметь псевдоним `report_reason`, поле с количеством постов — `report_count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT extra AS report_reason,
         COUNT(*) AS report_count
  FROM Actions
  WHERE action_date = '2023-07-05' AND action = 'report'
  GROUP BY report_reason;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1095761/step/4?unit=1106525)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех сотрудниках компании: идентификатор, имя, фамилия, актуальная годовая зарплата.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id, name, surname, MAX(salary) AS salary
  FROM Salary
  GROUP BY id, name, surname;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1095761/step/5?unit=1106525)

Напишите запрос, определяющий количество задач, которые были решены в выходные дни, а также количество задач, которые были решены в будние дни. Полученные значения должны быть указаны в полях с псевдонимами `weekend_count` и `working_count` соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT SUM(CASE WEEKDAY(submit_date)
                  WHEN 5 THEN 1
                  WHEN 6 THEN 1
                  ELSE 0
             END
            ) AS weekend_count,
         SUM(CASE WEEKDAY(submit_date)
                  WHEN 5 THEN 0
                  WHEN 6 THEN 0
                  ELSE 1
             END
            ) AS working_count          
  FROM Actions;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1095761/step/6?unit=1106525)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех рекламных интеграций, а также определяет рейтинг эффективности каждой рекламной интеграции.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT ad_id,
         ROUND(IFNULL(
                SUM(IF(action = 'clicked', 1, 0)) / SUM(IF(action in ('clicked', 'viewed'), 1, 0)), 0
               ) * 100, 2) AS rating
  FROM Actions
  GROUP BY ad_id
  ORDER BY rating DESC;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1095761/step/7?unit=1106525)

Напишите запрос, который группирует заказы в зависимости от того, в каком месяце они были сделаны, а также в каждой группе определяет количество заказов на сумму больше `20` долларов и количество уникальных покупателей, совершивших хотя бы один заказ на сумму больше `20` долларов. Полученный результат должен быть отображен в виде таблицы из трех полей:

* `month` — полное название месяца
* `order_count` — количество заказов на сумму больше 20 долларов в этом месяце
* `customer_count` — количество уникальных покупателей, совершивших хотя бы один заказ на сумму больше `20` долларов в этом месяце.  


<details>
  <summary>Решение</summary>

  ```sql
  SELECT MONTHNAME(order_date) AS month,
         COUNT(*) AS order_count,
  	   COUNT(DISTINCT customer_id) AS customer_count
  FROM Orders	
  WHERE invoice > 20  
  GROUP BY month;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1095761/step/8?unit=1106525)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы пользователей, которые за день просмотрели больше одной статьи.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `viewer_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT viewer_id
  FROM Views
  GROUP BY viewer_id, view_date 
  HAVING COUNT(DISTINCT article_id) > 1
  ORDER BY viewer_id;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1095761/step/9?unit=1106525)

Напишите запрос, который извлекает из предложенной базы данных названия всех товаров, а также определяет, в какие месяцы и в каком количестве был продан каждый из этих товаров.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT TRIM(' ' FROM LOWER(product_name)) AS product_name,
         DATE_FORMAT(sale_date, '%Y-%m') AS sale_date,
         COUNT(*) AS total
  FROM Sales
  GROUP BY TRIM(' ' FROM LOWER(product_name)), DATE_FORMAT(sale_date, '%Y-%m')
  ORDER BY product_name, sale_date;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1095761/step/10?unit=1106525)

Напишите запрос, который определяет идентификатор задачи с наибольшим коэффициентом решения и указывает полученное значение в поле с псевдонимом `question_id`. Если таких задач несколько, в результирующую таблицу должна быть добавлена та задача, чей идентификатор меньше.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT question_id
  FROM Activity
  GROUP BY question_id
  ORDER BY SUM(IF(action = 'answer', 1, 0)) / SUM(IF(action = 'show', 1, 0)) DESC, 
           question_id
  LIMIT 1;
  ```

</details>
