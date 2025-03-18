# Пользовательские функции. Часть 1

[Task №1](https://stepik.org/lesson/1162023/step/12?unit=1174328)

Реализуйте функцию `NON_SPACE_CHARACTERS()`, которая принимает один аргумент:

* `string` — строка.

Функция должна возвращать количество символов в строке `string`, не являющихся пробелом.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION NON_SPACE_CHARACTERS(string TEXT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      RETURN CHAR_LENGTH(REPLACE(string, ' ', ''));
  END //
  DELIMITER ;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1162023/step/13?unit=1174328)

Реализуйте функцию `SAME_DIGITS()`, которая принимает один аргумент:

* `number` — положительное целое число.

Функция должна возвращать число `1`, если число `number` состоит из одинаковых цифр, или `0` в противном случае.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION SAME_DIGITS(number INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      RETURN IF(REPLACE(number, RIGHT(number, 1), '') = 0, 1, 0);
  END //
  DELIMITER ;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1162023/step/14?unit=1174328)

Реализуйте функцию `CALCULATE()`, которая принимает три аргумента в следующем порядке:

* `a` — число с плавающей точкой;
* `b` — число с плавающей точкой;
* `operation` — один из четырех символов, определяющих математическую операцию: `+, -, *` или `/`

Функция должна возвращать значение выражения `a operation b`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION CALCULATE(a FLOAT, b FLOAT, operation TEXT)
  RETURNS FLOAT
  DETERMINISTIC
  BEGIN
      RETURN CASE
                 WHEN operation = '+' THEN a + b
                 WHEN operation = '-' THEN a - b
                 WHEN operation = '*' THEN a * b
                 ELSE a / b
             END;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1162023/step/15?unit=1174328)

Реализуйте функцию `MIDDLE_POINT()`, которая принимает четыре аргумента в следующем порядке:

* `x1` — целое число;
* `y1` — целое число;
* `x2` — целое число;
* `y2` — целое число.

Функция должна определять координаты точки, являющейся серединой отрезка, и возвращать полученный результат в виде строки в следующем формате:

`(<координата точки по оси x>; <координата точки по оси y>)`

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION MIDDLE_POINT(x1 INT, y1 INT, x2 INT, y2 INT)
  RETURNS TEXT
  DETERMINISTIC
  BEGIN
      DECLARE x FLOAT;
      DECLARE y FLOAT;
      SET x := (x1 + x2) / 2;
      SET y := (y1 + y2) / 2;
      RETURN CONCAT('(', x, '; ', y, ')');
  END //
  DELIMITER ;
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

