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

[Task №4](https://stepik.org/lesson/1481755/step/18?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера), названия которых состоят из одного слова.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director
  FROM Films
  WHERE REGEXP_LIKE(title, '^\\w+$') = 1
  ORDER BY title;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1481755/step/19?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера), названия которых состоят из двух и более слов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director
  FROM Films
  WHERE REGEXP_LIKE(title, '(\\b\\w+\\b ?){2,}')
  ORDER BY title;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1481755/step/20?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера), названия которых состоят ровно из трех слов.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT title, director
  FROM Films
  WHERE REGEXP_LIKE(title, '^(\\b\\w+\\b ?){3}$')
  ORDER BY title;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1481755/step/21?unit=1501468)

Напишите запрос, извлекающий из предложенной базы данных уникальные имена и фамилии режиссеров. При этом имя режиссера должно быть указано в поле с псевдонимом `name`, а фамилия в поле с псевдонимом `surname`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT DISTINCT REGEXP_SUBSTR(director, '^[A-Z]\\w+') AS name,
         REGEXP_SUBSTR(director, '[A-Z]\\w+$') AS surname
  FROM Films
  ORDER BY name;
  ```

</details>
