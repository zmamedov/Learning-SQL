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

---

[Task №5](https://stepik.org/lesson/1054680/step/16?unit=1063883)

Напишите запрос, создающий триггер, который после добавления нового отзыва обновляет средний рейтинг соответствующего товара.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER rating
  AFTER INSERT ON Reviews
  FOR EACH ROW
  BEGIN
      UPDATE Products
      SET avg_rating = (SELECT AVG(rating)
                       FROM Reviews
                       WHERE product_id = NEW.product_id)
      WHERE Products.id = NEW.product_id;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1054680/step/17?unit=1063883)

Напишите запрос, создающий триггер, который перед изменением номера телефона пользователя переводит его в следующий формат:

`+7dddddddddd`

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER before_update
  BEFORE UPDATE ON Users
  FOR EACH ROW
  BEGIN
      SET new.phone_number = CONCAT('+7', RIGHT(REPLACE(new.phone_number, ' ', ''), 10));
  END //
  DELIMITER ;
  
  DELIMITER //
  CREATE TRIGGER after_insert
  BEFORE INSERT ON Users
  FOR EACH ROW
  BEGIN
      SET NEW.phone_number = CONCAT('+7', RIGHT(REPLACE(NEW.phone_number, ' ', ''), 10));
  END //
  DELIMITER ;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1054680/step/18?unit=1063883)

Напишите запрос, создающий триггер, который после покупки пользователем очередного фильма прибавляет к его сумме, потраченной на покупку фильмов, стоимость только что купленного фильма.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER add_price_to_total 
  AFTER INSERT ON Purchases
  FOR EACH ROW
  BEGIN
      UPDATE Users
      SET total_spending = total_spending + (SELECT price FROM Films WHERE id = NEW.film_id)
      WHERE Users.id = NEW.user_id;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1054680/step/19?unit=1063883)

Напишите запрос, создающий триггер, который после добавления нового заказа также добавляет сообщение для покупателя.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE TRIGGER add_new_notification_to_customer
  AFTER INSERT ON Orders
  FOR EACH ROW
  BEGIN
      INSERT INTO Notifications (order_id, message)
      VALUES (NEW.id, CONCAT((SELECT name 
                             FROM Customers
                             WHERE id = NEW.customer_id), 
                             ', new status of your delivery on ',
                             CURDATE(),
                             ': ',
                             NEW.status)
             );
  END //
  DELIMITER ;
  
  DELIMITER //
  CREATE TRIGGER update_notification_to_customer
  AFTER UPDATE ON Orders
  FOR EACH ROW
  BEGIN
      UPDATE Notifications
      SET message = CONCAT(SUBSTRING_INDEX(message, ' ', 7), ' ', CURDATE(), ': ', NEW.status)
      WHERE order_id = NEW.id;
  END //
  DELIMITER ;
  ```

</details>
