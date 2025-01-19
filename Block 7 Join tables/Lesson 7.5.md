# Решение задач. Часть 1

[Task №1](https://stepik.org/lesson/1095763/step/1?unit=1106527)

Напишите запрос, определяющий все возможные матчи, которые могут сыграть между собой предложенные футбольные команды, и отображающий полученный результат в виде таблицы из двух полей:

* `home_team` — название домашней команды
* `away_team` — название гостевой команды

<details>
  <summary>Решение</summary>

  ```sql
  SELECT T1.name AS home_team, 
         T2.name AS away_team
  FROM Teams T1 CROSS JOIN Teams T2
  WHERE T1.name != T2.name;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1095763/step/2?unit=1106527)

Напишите запрос, определяющий все пары элементов, которые могут образовывать связь, и отображающий полученный результат в виде таблицы из двух полей:

* `metal` — название элемента, являющегося металлом
* `nonmetal` — название элемента, являющегося неметаллом

<details>
  <summary>Решение</summary>

  ```sql
  SELECT E1.symbol AS metal,
         E2.symbol AS nonmetal
  FROM Elements E1 CROSS JOIN Elements E2
  WHERE E1.type = 'metal' 
        AND E2.type = 'nonmetal';
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1095763/step/3?unit=1106527)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех покупателей, а также определяет суммарное количество денег, потраченное каждым покупателем.
Поле с количеством потраченных покупателем денег должно иметь псевдоним `spending`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `spending`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT user_id,
         SUM(quantity * pr.price) AS spending
  FROM Orders o
  LEFT JOIN Products pr ON o.product_id = pr.id
  GROUP BY user_id
  ORDER BY spending DESC;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1095763/step/4?unit=1106527)

Напишите запрос, который извлекает из предложенной базы данных названия всех товаров, а также для каждого товара определяет общую сумму к оплате, общую оплаченную сумму, общую аннулированную сумму и общую возвращенную сумму по всем счет-фактурам.
Поле с названием товара должно иметь псевдоним `product`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `product`. 

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name AS product,
         IFNULL(SUM(rest), 0) AS rest,
         IFNULL(SUM(paid), 0) AS paid,
         IFNULL(SUM(cancelled), 0) AS cancelled,
         IFNULL(SUM(refunded), 0) AS refunded
  FROM Products pr
  LEFT JOIN Invoices i ON pr.id = product_id 
  GROUP BY pr.id
  ORDER BY product;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1095763/step/5?unit=1106527)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы пользователей, которые как минимум дважды запросили сообщение с подтверждением регистрации в течение `24` часов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT c1.user_id
  FROM Confirmations c1
  INNER JOIN Confirmations c2 ON c1.user_id = c2.user_id 
                              AND c1.time_stamp != c2.time_stamp
                              AND ABS(TIMESTAMPDIFF(SECOND, c1.time_stamp, c2.time_stamp)) <= 86400;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1095763/step/6?unit=1106527)

В зависимости от средней температуры в месяце, метеоресурс характеризует ее определенным типом погоды:

* `Cold`, если средняя температура меньше или равна `15`
* `Hot`, если средняя температура больше или равна `25`
* `Warm` в остальных случаях

Напишите запрос, который извлекает из предложенной базы данных названия стран, а также определяет тип погоды в каждой стране в сентябре `2023` года. При этом в результирующую таблицу должны быть добавлены названия только тех стран, информация о температуре в которых известна.
Поле с названием страны должно иметь псевдоним country, поле с типом погоды в стране — `weather_type`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Countries.name AS country,
         CASE 
             WHEN AVG(weather_state) <= 15 THEN 'Cold'
             WHEN AVG(weather_state) >= 25 THEN 'Hot'
             ELSE 'Warm'
         END AS weather_type
  FROM Weather
  LEFT JOIN Countries ON country_id = Countries.id
  WHERE YEAR(day) = 2023 AND MONTH(day) = 9
  GROUP BY country_id;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1095763/step/7?unit=1106527)

Напишите запрос, который составляет все возможные тройки учеников, выбирая из школ `A, B` и `C` по одному ученику, и отображает полученный результат в виде таблицы из трех полей:

* `student_A` — имя ученика из школы `A`
* `student_B` — имя ученика из школы `B`
* `student_C` — имя ученика из школы `C`

При этом в каждой тройке имена и идентификаторы выбранных учеников должны быть попарно различны, то есть не должно быть двух учащихся с одинаковыми именами или одинаковыми идентификаторами.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT a.student_name AS student_A, b.student_name AS student_B, c.student_name AS student_C
  FROM SchoolA a CROSS JOIN SchoolB b CROSS JOIN SchoolC c
  WHERE a.student_id NOT IN (b.student_id, c.student_id) 
        AND b.student_id NOT IN (a.student_id, c.student_id)
        AND c.student_id NOT IN (b.student_id, a.student_id)
        AND a.student_name NOT IN (b.student_name, c.student_name) 
        AND b.student_name NOT IN (a.student_name, c.student_name)
        AND c.student_name NOT IN (b.student_name, a.student_name)
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1095763/step/8?unit=1106527)

Напишите запрос, который извлекает из предложенной базы данных названия всех факультетов, а также определяет, сколько студентов обучается на каждом факультете.

Поле с названием факультета должно иметь псевдоним `department`, поле с количеством обучающихся на факультете студентов — `students_count`.

Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `students_count`, при совпадении — в порядке возрастания значения поля `department`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT d.name AS department,
         COUNT(Students.id) AS students_count
  FROM Departments d
  LEFT JOIN Students ON d.id = dept_id 
  GROUP BY d.id
  ORDER BY students_count DESC, 
           department
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1095763/step/9?unit=1106527)

Напишите запрос, извлекающий из предложенной базы данных имя и фамилию кандидата, который набрал наибольшее количество голосов, а также определяющий набранное им количество голосов.
Поле с количеством набранных кандидатом голосов должно иметь псевдоним `votes_count`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Candidates.name, Candidates.surname,
         COUNT(Votes.id) AS votes_count
  FROM Candidates
  LEFT JOIN Votes ON Candidates.id = candidate_id
  GROUP BY Candidates.id
  ORDER BY votes_count DESC
  LIMIT 1;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1095763/step/10?unit=1106527)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы сессий, во время которых не была показана рекламная интеграция.
Поле с идентификатором сессии должно иметь псевдоним `session_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT Playback.id AS session_id
  FROM Playback
  LEFT JOIN Ads ON Ads.user_id = Playback.user_id
        AND time_stamp BETWEEN start_time AND end_time
  WHERE Ads.id IS NULL
  ```

</details>

---

[Task №11](https://stepik.org/lesson/1095763/step/11?unit=1106527)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы постов, а также определяет количество комментариев, оставленных под каждым постом.
Поле с идентификатором поста должно иметь псевдоним `post_id`, поле с количеством оставленных под постом комментариев — `number_of_comments`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `post_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT S1.sub_id AS post_id, 
         COUNT(S2.parent_id) AS number_of_comments
  FROM Submissions S1
  LEFT JOIN Submissions S2 ON S1.sub_id = S2.parent_id 
  WHERE S1.parent_id IS NULL
  GROUP BY S1.sub_id
  ORDER BY post_id DESC;
  ```

</details>

---

[Task №12](https://stepik.org/lesson/1095763/step/12?unit=1106527)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы покупателей, которые приобрели товар `Canon EOS R6 Camera`, но не приобрели товар `Lenovo ThinkPad X1 Carbon`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT buyer_id
  FROM Products
  INNER JOIN Sales ON Products.id = product_id
  WHERE name = 'Canon EOS R6 Camera' 
        AND buyer_id NOT IN (SELECT DISTINCT buyer_id 
                             FROM Products
                             INNER JOIN Sales ON Products.id = product_id
                             WHERE name = 'Lenovo ThinkPad X1 Carbon');
  ```

</details>
