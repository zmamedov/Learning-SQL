# Дополнительные функции

[Task №1](https://stepik.org/lesson/1022209/step/14?unit=1030235)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех режиссерах: имя, фамилия, страна рождения. При этом если страной рождения режиссера является `England`, то в результирующей таблице она должна остаться без изменений, если какая-либо другая страна — заменена на строку `Other country`.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, 
         IF(country = 'England', 'England', 'Other country') AS country
  FROM Directors
  ORDER BY name;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1022209/step/15?unit=1030235)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех режиссерах: имя, фамилия, рейтинг. При этом если рейтинг режиссера не определен, в результирующей таблице он должен быть заменен на значение `0`. 
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `rating`, при совпадении — в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, 
         COALESCE(rating, 0) AS rating
  FROM Directors
  ORDER BY rating, name;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1022209/step/16?unit=1030235)

Напишите запрос, который извлекает из предложенной базы данных имена и рейтинги всех режиссеров. При этом если имя режиссера не определено, то в результирующей таблице оно должно быть заменено на его фамилию. Однако если фамилия режиссера также не определена, то в качестве его имени должна быть использована строка `Unknown`.
Поле с именем режиссера (или другим значением) должно иметь псевдоним `director`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `rating`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COALESCE(name, surname, 'Unknown') AS director,
         rating 
  FROM Directors
  ORDER BY rating DESC;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1022209/step/17?unit=1030235)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех режиссерах: имя, фамилия, страна рождения, рейтинг.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, country,
         IF(country = 'USA', IF(rating > 90, 100, rating + 10), rating) AS rating
  FROM Directors
  ORDER BY rating DESC, name;
  ```

</details>
