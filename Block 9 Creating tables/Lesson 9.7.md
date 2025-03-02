# Обобщенные табличные выражения. Часть 1

[Task №1](https://stepik.org/lesson/1096402/step/9?unit=1107184)

Напишите запрос, который разбивает студентов на группы в зависимости от текстового эквивалента их оценки, определяет количество студентов в каждой группе и отображает полученный результат в виде таблицы из двух полей:

* `result` — текстовый эквивалент оценки (`Great`, `Well` или `Bad`);
* `students` — количество студентов, получивших оценку, соответствующую этому текстовому эквиваленту.

<details>
  <summary>Решение</summary>

  ```sql
  WITH StudentsResult AS (
      SELECT name, surname, 
             CASE
                WHEN grade IN ('A', 'B') THEN 'Great'
                WHEN grade = 'C' THEN 'Well'
                ELSE 'Bad'
             END AS result
      FROM Math
  )
  
  SELECT result,
         COUNT(*) AS students
  FROM StudentsResult
  GROUP BY result;
  ```

</details>

---

