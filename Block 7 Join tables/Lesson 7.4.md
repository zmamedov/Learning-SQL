# Объединение результатов запросов

[Task №1](https://stepik.org/lesson/1043826/step/18?unit=1052295)

Напишите запрос, который определяет общее количество математиков, физиков и программистов и отображает полученный результат в виде таблицы из двух полей:

* `profession` — название профессии (`Mathematician` — математик, `Physicist` — физик, `Programmer` — программист);
* `total` — количество людей этой профессии.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT 'Mathematician' AS profession, COUNT(*) AS total
  FROM Mathematicians
  UNION
  SELECT 'Physicist' AS profession, COUNT(*) AS total
  FROM Physicists
  UNION
  SELECT 'Programmer' AS profession, COUNT(*) AS total
  FROM Programmers;
  ```

</details>

---

