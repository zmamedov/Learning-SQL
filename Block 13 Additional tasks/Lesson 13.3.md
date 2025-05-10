# Подзапросы

[Task №1](https://stepik.org/lesson/1072300/step/1?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех узлов дерева, а также определяет тип каждого узла:

* `Root`, если узел является корнем дерева;
* `Leaf`, если узел является листом дерева;
* `Inner`, если узел не является ни корнем, ни листом.

Поле с названием типа узла должно иметь псевдоним `type`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id,
         CASE 
            WHEN p_id IS NULL THEN 'Root'
            WHEN id NOT IN (SELECT t.p_id
                            FROM Tree t
                            WHERE p_id IS NOT NULL) THEN 'Leaf' 
            ELSE 'Inner'
         END AS type   
  FROM Tree;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1072300/step/2?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии студентов, у которых в качестве факультета указан несуществующий факультет.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Students
  WHERE department_id NOT IN (SELECT id FROM Departments)
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1072300/step/3?unit=1082124)



<details>
  <summary>Решение</summary>

  ```sql
  SELECT salary AS second_highest_salary
  FROM Salaries
  WHERE salary = (SELECT salary
                  FROM Salaries
                  GROUP BY salary
                  ORDER BY salary DESC 
                  LIMIT 1
                  OFFSET 1);
  ```

</details>

---

