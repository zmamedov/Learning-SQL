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

[Task №5](https://stepik.org/lesson/1162023/step/16?unit=1174328)

Реализуйте функцию `LAST_SECOND_DIGIT()`, которая принимает один аргумент:

* `number` — положительное целое число.

Функция должна возвращать вторую по счету цифру числа `number` с конца. При попытке получить вторую по счету с конца цифру однозначного числа функция `LAST_SECOND_DIGIT()` должна вернуть значение `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION LAST_SECOND_DIGIT(number INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE digit INT;
      SET digit := LEFT(RIGHT(number, 2), 1);
      RETURN IF(CHAR_LENGTH(number) = 1, NULL, digit);
  END //
  DELIMITER ;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1162023/step/17?unit=1174328)

Реализуйте функцию `SOLVE()`, которая принимает три аргумента в следующем порядке:

* `a` — целое число, коэффициент `a` квадратного трехчлена;
* `b` — целое число, коэффициент `b` квадратного трехчлена;
* `c` — целое число, коэффициент `c` квадратного трехчлена.

Функция должна возвращать корень многочлена с коэффициентами `a, b` и `c`. Если многочлен с переданными коэффициентами имеет два корня, функция `SOLVE()` должна вернуть меньший из них, если не имеет корней — значение `NULL`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION SOLVE(a INT, b INT, c INT)
  RETURNS FLOAT
  DETERMINISTIC
  BEGIN
      DECLARE dis INT;
      SET dis = b*b - 4*a*c;
      RETURN CASE
                 WHEN SQRT(dis) < 0 THEN NULL
                 WHEN SQRT(dis) = 0 THEN -b / (2*a)
                 ELSE LEAST((-b+SQRT(dis))/(2*a), (-b-SQRT(dis))/(2*a))
             END;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1162023/step/18?unit=1174328)

Реализуйте функцию `TOTAL()`, которая принимает один аргумент:

* `store_name` — строка, название магазина.

Функция должна возвращать общую сумму, которую заработал магазин с названием `store_name`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION TOTAL(store_name TEXT)
  RETURNS INT
  NOT DETERMINISTIC
  READS SQL DATA
  BEGIN
      RETURN (SELECT SUM(amount)
              FROM Orders
              WHERE store = store_name);
  END //
  DELIMITER ;
  ```

</details>
