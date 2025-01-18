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

