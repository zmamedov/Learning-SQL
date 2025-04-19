# Функции для работы с регулярными выражениями

[Task №1](https://stepik.org/lesson/1481755/step/15?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных уникальные имена и фамилии режиссеров, имена которых начинаются на букву `B` или `P`, а фамилии на букву `B` или `D`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT director
  FROM Films
  WHERE REGEXP_LIKE(director, '[BP]\\w* [BD]\\w*', 'c') = 1;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1481755/step/16?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных уникальные имена и фамилии режиссеров, имя и фамилия которых начинается на одну и ту же букву.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT director
  FROM Films
  WHERE REGEXP_LIKE(director, '([A-Z])\\w*[ ]\\1', 'c') = 1;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1481755/step/17?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера), в названиях которых есть цифры.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `title`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director
  FROM Films
  WHERE REGEXP_LIKE(title, '\\d', 'c') = 1
  ORDER BY title;
  ```

</details>

---

