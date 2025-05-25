# Продвинутые соединения

[Task №1](https://stepik.org/lesson/1072302/step/1?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных числа, которые встречаются хотя бы `3` раза подряд.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT N1.num
  FROM Numbers N1
  INNER JOIN Numbers N2 ON N1.id + 1 = N2.id
  INNER JOIN Numbers N3 ON N1.id + 2 = N3.id
  WHERE N1.num = N2.num AND N2.num = N3.num;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072302/step/2?unit=1082126)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы мест, которые свободны подряд.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `seat_id`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT C1.seat_id
  FROM Cinema C1
  INNER JOIN Cinema C2 ON C1.seat_id + 1 = C2.seat_id OR C1.seat_id = C2.seat_id + 1
  WHERE C1.free = 0 AND C2.free = 0
  ORDER BY C1.seat_id;
  ```

</details>

