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
|:---:|:---:|
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

[Task №4](https://stepik.org/lesson/1045355/step/15?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки студента `Peter Parker` на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5
  WHERE student_id = (SELECT id
                      FROM Students
                      WHERE student = 'Peter Parker');
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1045355/step/16?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки студентки `Mary Jane` по предмету `Math` на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5
  WHERE student_id = (SELECT id
                      FROM Students
                      WHERE student = 'Mary Jane')
        AND class_id = (SELECT id
                        FROM Classes
                        WHERE name = 'Math');
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1045355/step/17?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` все оценки, полученные студентами `2023-07-26` по предмету `Biology`, на значение `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = NULL
  WHERE date_of_receipt = '2023-07-26'
        AND class_id = (SELECT id
                        FROM Classes
                        WHERE name = 'Biology');
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1045355/step/18?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` самую первую полученную студенткой `Gwen Stacy` оценку на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5
  WHERE student_id = (SELECT id
                      FROM Students
                      WHERE student = 'Gwen Stacy')
  ORDER BY date_of_receipt
  LIMIT 1;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1045355/step/19?unit=1053930)

Напишите запрос, который изменяет в таблице `Grades` самую последнюю полученную студенткой `Gwen Stacy` оценку на `5`.

<details>
  <summary>Решение</summary>

  ```sql
  UPDATE Grades
  SET grade = 5
  WHERE student_id = (SELECT id
                      FROM Students
                      WHERE student = 'Gwen Stacy')
  ORDER BY date_of_receipt DESC
  LIMIT 1;
  ```

</details>
