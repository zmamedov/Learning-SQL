# Триггеры

[Task №1](https://stepik.org/lesson/1054680/step/12?unit=1063883)

Напишите запрос, создающий триггер, который перед добавлением нового поста устанавливает ему в качестве даты и времени публикации текущие дату и время в любом часовом поясе.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER test_trigger
  BEFORE INSERT
  ON Posts
  FOR EACH ROW
  BEGIN
      SET NEW.post_date = NOW();
  END //
  DELIMITER ;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1054680/step/13?unit=1063883)

Прожиточный минимум — минимальная сумма доходов, необходимая для обеспечения жизнедеятельности гражданина. Будем считать, что прожиточный минимум составляет 1000 долларов.

Напишите запрос, создающий триггер, который перед добавлением нового сотрудника нормализует его заработную плату. Если заработная плата меньше прожиточного минимума, триггер должен установить ей значение, равное прожиточному минимуму. Если заработная плата больше либо равна прожиточному минимуму, триггер должен оставить ее без изменений.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER min_salary
  BEFORE INSERT
  ON Employees
  FOR EACH ROW
  BEGIN
      SET New.salary = IF(New.salary < 1000, 1000, New.salary);
  END //
  DELIMITER ;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1054680/step/14?unit=1063883)

Напишите запрос, создающий триггер, который после изменения пользователем адреса электронной почты фиксирует данное изменение и добавляет соответствующую информацию в таблицу `UsersEmailHistory`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER user_email
  AFTER UPDATE
  ON Users
  FOR EACH ROW
  BEGIN
      INSERT INTO UsersEmailHistory (user_id, old_email, new_email, updated_on)
      VALUES (OLD.id, OLD.email, NEW.email, NOW());
  END //
  DELIMITER ;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1054680/step/15?unit=1063883)

Напишите запрос, создающий триггер, который после добавления нового заказа уменьшает количество соответствующего товара на складе.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE TRIGGER decrease_quantity
  AFTER INSERT ON Orders
  FOR EACH ROW
  UPDATE Products
  SET stock = stock - NEW.quantity
  WHERE id = NEW.product_id;
  ```

</details>
