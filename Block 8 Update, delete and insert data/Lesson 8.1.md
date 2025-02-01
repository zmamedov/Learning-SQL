# Обновление данных

[Task №1](https://stepik.org/lesson/1045355/step/12?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1045355/step/13?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки, равные `4`, на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5
  WHERE grade = 4;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1045355/step/14?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки на их текстовые эквиваленты:

|Оценка|Описание|
|`A`|`Great`|
|`B`|`Great`|
|`C`|`Well`|
|`D`|`Bad`|
|`E`|`Bad`|

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = CASE
                  WHEN grade in ('A', 'B') THEN 'Great'
                  WHEN grade = 'C' THEN 'Well'
                  ELSE 'Bad'
              END;
  ```

</details>

---

[Task №]()



<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

[Task №]()



<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

[Task №]()



<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

[Task №]()



<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

[Task №]()



<details>
  <summary>Решение</summary>

  ```sql

  ```

</details>

---

