# Условные конструкции

[Task №1](https://stepik.org/lesson/1033686/step/8?unit=1042053)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех учениках: имя, фамилия, оценка за экзамен.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         CASE grade
             WHEN 'A' THEN 5
             WHEN 'B' THEN 4
             WHEN 'C' THEN 3
             WHEN 'D' THEN 2
             WHEN 'E' THEN 1
         END AS grade
  FROM Math
  ORDER BY grade DESC, name;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1033686/step/9?unit=1042053)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех учениках: имя, фамилия, оценка за экзамен.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         CASE 
             WHEN grade IN ('A', 'B') THEN 'Great'
             WHEN grade = 'C' THEN 'Well'
             ELSE 'Bad'
         END AS result
  FROM Math
  ORDER BY grade, name;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1033686/step/10?unit=1042053)

Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех учениках: имя, фамилия, оценка за экзамен.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `grade`, при совпадении — в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         CASE 
             WHEN grade BETWEEN 80 AND 100 THEN 5
             WHEN grade BETWEEN 60 AND 79 THEN 4
             WHEN grade BETWEEN 30 AND 59 THEN 3
             WHEN grade BETWEEN 10 AND 29 THEN 2
             ELSE 1
         END AS grade
  FROM Math
  ORDER BY grade DESC, name;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1033686/step/11?unit=1042053)

Напишите запрос, который извлекает из этой предложенной базы данных имена и фамилии всех учеников школы, а также проверяет на корректность адреса их электронных почт.
Поле с информацией о корректности адреса электронной почты должно иметь псевдоним `email_status` и содержать строку `Correct`, если адрес электронной почты ученика является корректным, или `Incorrect` в противном случае.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля `name`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         CASE 
             WHEN SUBSTRING_INDEX(email, '@', -1) = 'midtown.com' 
                  AND LOCATE('@', email) >= 3 
                  AND LEFT(email, 1) NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
             THEN 'Correct' 
             ELSE 'Incorrect'
         END AS email_status
  FROM Students
  ORDER BY name;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1033686/step/12?unit=1042053)

Каждый клиент авиакомпании `Utair` участвует в программе лояльности и имеет определенный статус. Самым высоким статусом считается `Gold`, затем идут `Silver`, `Bronze` и `Basic`.
Напишите запрос, который извлекает из предложенной базы данных следующую информацию обо всех клиентах авиакомпании: имя, фамилия, статус в программе лояльности.
Записи в результирующей таблице должны быть расположены в порядке убывания статуса клиента, при совпадении — в лексикографическом порядке имени клиента.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, 
         surname, 
		 status
  FROM Clients
  ORDER BY CASE status
               WHEN 'Gold' THEN 1
               WHEN 'Silver' THEN 2
               WHEN 'Bronze' THEN 3
               ELSE 4
           END, 
		   name;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1033686/step/13?unit=1042053)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии участников олимпиады, а также определяет количество баллов, набранное каждым из участников.
Поле с количеством баллов, набранным участником олимпиады, должно иметь псевдоним `score`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `score`, при совпадении — в порядке возрастания значения поля `name`, при совпадении — в порядке возрастания значения поля `surname`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname,
         CASE 
             WHEN MINUTE(time) + HOUR(time)*60 < 30 THEN 100
             WHEN MINUTE(time) + HOUR(time)*60 > 60 THEN 0
             ELSE 100 - (MINUTE(time) + HOUR(time)*60 - 30)
         END AS score    
  FROM Results
  ORDER BY score DESC, 
           name, 
		   surname;
  ```

</details>
