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

[Task №4](https://stepik.org/lesson/1072300/step/4?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных всю информацию о продажах каждого товара. При этом в результирующую таблицу должна быть добавлена информация только за первый год продаж.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT product_id, year AS first_year, quantity, price 
  FROM Sales
  WHERE year = (SELECT MIN(year) FROM Sales S WHERE Sales.product_id = product_id)
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1072300/step/5?unit=1082124)

Напишите запрос, извлекающий из предложенной базы данных имена и фамилии сотрудников, зарплата которых меньше `25000` и руководитель которых покинул компанию.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname
  FROM Employees
  WHERE salary < 25000 
        AND manager_id IS NOT NULL
        AND manager_id NOT IN (SELECT id FROM Employees);
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1072300/step/6?unit=1082124)

Напишите запрос, который извлекает из предложенной базы данных идентификаторы всех сотрудников, а также определяет размер команды каждого сотрудника.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT id AS employee_id,
         (SELECT COUNT(id)
          FROM Employees InnerEmp
          WHERE team_id = Employees.team_id) AS team_size
  FROM Employees;
  ```

</details>

---

