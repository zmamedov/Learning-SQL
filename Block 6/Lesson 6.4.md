# Решение задач

[Task №8](https://stepik.org/lesson/1095762/step/8?unit=1106526)

Напишите запрос, который определяет общее количество очков, набранное каждой командой на момент участия каждого ее участника.
<details>
  <summary>Решение</summary>

  ```sql
  SELECT team, day,
         (SELECT SUM(score_points)
          FROM Scores
	      WHERE team = S.team AND day <= S.day
         ) AS total
  FROM Scores AS S
  ORDER BY team, day;
  ```

</details>
