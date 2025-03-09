# Обобщенные табличные выражения. Часть 3

[Task №1](https://stepik.org/lesson/1195940/step/2?unit=1230007)

Напишите запрос, извлекающий из предложенной базы данных идентификаторы всех файлов и папок, а также указывающий для каждого файла или папки путь до него в следующем формате:

`.../<название родительской папки>/<название файла или папки>`

Поле с путем до файла или папки должно иметь псевдоним `path`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE FileHierarchy AS (
      SELECT id, 
             CONVERT(name, CHAR(100)) AS path
      FROM Files
      WHERE parent_directory_id IS NULL
      UNION ALL 
      SELECT Files.id,
             CONCAT(FileHierarchy.path , '/', Files.name)
      FROM FileHierarchy INNER JOIN Files ON FileHierarchy.id = Files.parent_directory_id
  )
      
  SELECT *
  FROM FileHierarchy;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1195940/step/3?unit=1230007)

Напишите запрос, который разделяет каждую инвестиционную сумму на равные доли в зависимости от количества инвесторов и отображает полученный результат в виде таблицы из трех полей:

* `investors_number` — количество инвесторов;
* `investment_amount` — инвестиционная сумма;
* `individual_amount` — доля каждого инвестора.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE InvestmentAmount AS (
      SELECT 1 AS investors_number,
             investment_amount,
             investment_amount AS individual_amount
      FROM Investment
      UNION ALL
      SELECT investors_number + 1,
             investment_amount,
             (individual_amount * investors_number) / (investors_number + 1)
      FROM InvestmentAmount
      WHERE investors_number < 3
  )
  
  SELECT *
  FROM InvestmentAmount;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1195940/step/4?unit=1230007)

Напишите запрос, извлекающий из предложенной базы данных названия городов, в которые можно добраться из города `New York` (напрямую или с помощью промежуточных рейсов), а также указывающий расстояние маршрута до каждого города.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE PathFromNY AS (
      SELECT destination_city, distance
      FROM Routes
      WHERE source_city = 'New York'
      UNION ALL
      SELECT Routes.destination_city,
             PathFromNY.distance + Routes.distance
      FROM PathFromNY
      INNER JOIN Routes ON PathFromNY.destination_city = Routes.source_city
  )
  
  SELECT *
  FROM PathFromNY;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1195940/step/5?unit=1230007)

Напишите запрос, извлекающий из предложенной базы данных названия всех задач, а также указывающий для каждой задачи время, необходимое для ее выполнения, с учетом времени решения всех задач, от которых она зависит.

Поле с конечным временем, необходимым для выполнения задачи, должно иметь псевдоним `total_time`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE TaskTime AS (
      SELECT id, name, time_required
      FROM Tasks
      WHERE depends_on_task_id IS NULL
      UNION ALL
      SELECT Tasks.id, Tasks.name, TaskTime.time_required + Tasks.time_required 
      FROM TaskTime INNER JOIN Tasks ON TaskTime.id = Tasks.depends_on_task_id
  )
  
  SELECT name, time_required AS total_time
  FROM TaskTime;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1195940/step/6?unit=1230007)

Напишите запрос, определяющий все возможные маршруты, которыми можно добраться из города `Groningen` в город `Haarlem`, и указывающий полученные результаты в поле с псевдонимом `route` в следующем формате:

`Groningen -> <название промежуточного города> -> ... -> <название промежуточного города> -> Haarlem`

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE RouteOptions AS (
      SELECT source_city, destination_city, 
             CONVERT(CONCAT(source_city, ' -> ', destination_city), CHAR(100)) AS route
      FROM Routes
      WHERE source_city = 'Groningen'
      UNION ALL
      SELECT Routes.source_city, Routes.destination_city,
             CONCAT(route, ' -> ', Routes.destination_city)
      FROM RouteOptions INNER JOIN Routes ON RouteOptions.destination_city = Routes.source_city
  )
  
  SELECT route
  FROM RouteOptions
  WHERE destination_city = 'Haarlem';
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1195940/step/7?unit=1230007)

Напишите запрос, извлекающий из предложенной базы данных имена всех членов семьи, а также указывающий для каждого члена его родственное отношение к члену семьи по имени `James`.

<details>
  <summary>Решение</summary>

  ```sql
  WITH RECURSIVE Relationships AS (
      SELECT id, name, father_id, mother_id, 
             1 AS level,
             CONVERT('male', CHAR(6)) AS gender
      FROM Genealogy
      WHERE name = 'James'
      UNION ALL
      SELECT Genealogy.id, Genealogy.name, Genealogy.father_id, Genealogy.mother_id, level + 1,
             CASE
                WHEN Genealogy.id = Relationships.father_id THEN 'male'
                ELSE 'female'
             END
      FROM Relationships
      INNER JOIN Genealogy ON Relationships.father_id = Genealogy.id OR Relationships.mother_id = Genealogy.id
  )
  
  SELECT name,
         CASE
            WHEN level = 1 THEN 'son'
            WHEN level = 2 AND gender = 'male' THEN 'father'
            WHEN level = 2 AND gender = 'female' THEN 'mother'
            WHEN level = 3 AND gender = 'male' THEN 'grandfather'
            WHEN level = 3 AND gender = 'female' THEN 'grandmother'
         END AS relationship
  FROM Relationships;
  ```

</details>
