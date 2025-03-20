# Пользовательские функции. Часть 2

[Task №1](https://stepik.org/lesson/1050404/step/7?unit=1059446)

Реализуйте функцию `POSITIVE_SUM()`, которая принимает три аргумента в следующем порядке:

* `a` — целое число;
* `b` — целое число;
* `c` — целое число.

Функция должна выбирать из чисел `a, b` и `c` положительные и возвращать их сумму. Если ни одно из переданных в функцию чисел не является положительным, функция должна вернуть число `0`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION POSITIVE_SUM(a INT, b INT, c INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE result INT DEFAULT 0;
      IF a > 0 THEN
          SET result := result + a;
      END IF;
      IF b > 0 THEN
          SET result := result + b;
      END IF;
      IF c > 0 THEN
          SET result := result + c;
      END IF;
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1050404/step/8?unit=1059446)

Реализуйте функцию `IS_DIGIT()`, которая принимает один аргумент:

* `string` — строка.

Функция должна возвращать число `1`, если строка `string` состоит исключительно из цифровых символов, или `0` в противном случае.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION IS_DIGIT(string TEXT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE symbol TEXT DEFAULT '';
      WHILE string != '' DO
          SET symbol := RIGHT(string, 1);
          IF symbol NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN
              RETURN 0;
          ELSE 
              SET string := LEFT(string, CHAR_LENGTH(string) - 1);
          END IF;
      END WHILE;
      
      RETURN 1;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1050404/step/9?unit=1059446)

Реализуйте функцию `SUM_OF_FIRST_DIGITS()`, которая принимает один аргумент:

* `string` — строка.

Функция должна суммировать все цифровые символы в строке `string` слева направо до тех пор, пока не встретится хотя бы один нецифровой символ, и возвращать полученный результат. Если переданная в функцию строка начинается с нецифрового символа, функция должна вернуть число `0`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION SUM_OF_FIRST_DIGITS(string TEXT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE result INT DEFAULT 0;
      DECLARE digit TEXT;
      SET digit := LEFT(string, 1);
      
      WHILE digit IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') DO
          SET result := result + digit;
          SET string := SUBSTRING(string, 2);
          SET digit := LEFT(string, 1);
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1050404/step/10?unit=1059446)

Реализуйте функцию `SWAPCASE()`, которая принимает один аргумент:

* `string` — строка.

Функция должна заменять в строке `string` регистр всех буквенных символов на противоположный и возвращать полученный результат.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION SWAPCASE(string TEXT)
  RETURNS TEXT
  DETERMINISTIC
  BEGIN
      DECLARE symbol TEXT DEFAULT '';
      DECLARE result TEXT DEFAULT '';
      
      WHILE string != '' DO
          SET symbol := LEFT(string, 1);
          IF symbol IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN
              SET result := CONCAT(result, symbol);
          ELSEIF ASCII(symbol) > 91 THEN
              SET result := CONCAT(result, CONVERT(CHAR(ORD(symbol) - 32), CHAR));
          ELSE
              SET result := CONCAT(result, CONVERT(CHAR(ORD(symbol) + 32), CHAR));
          END IF;
          
          SET string := SUBSTRING(string, 2);
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1050404/step/11?unit=1059446)

Реализуйте функцию `MIN_DIGIT()`, которая принимает один аргумент:

* `number` — положительное целое число.

Функция должна возвращать минимальную цифру числа `number`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION MIN_DIGIT(number INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE min_digit INT DEFAULT 9;
      WHILE number != 0 DO
          IF number MOD 10 < min_digit THEN
              SET min_digit := number MOD 10;
          END IF;
          
          SET number := number DIV 10;
      END WHILE;
      
      RETURN min_digit;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1050404/step/12?unit=1059446)

Реализуйте функцию `FACTORIAL()`, которая принимает один аргумент:

* `n` — положительное целое число.

Функция должна возвращать произведение всех целых чисел от `1` до `n` включительно.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION FACTORIAL(n INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE ind INT DEFAULT 1;
      DECLARE result INT DEFAULT 1;
      
      WHILE ind <= n DO
          SET result := result * ind;
          SET ind := ind + 1;
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1050404/step/13?unit=1059446)

Реализуйте функцию `SUM_OF_MID_DIGITS()`, которая принимает один аргумент:

* `number` — положительное целое число.

Функция должна возвращать сумму цифр числа `number`, не учитывая первую и последнюю цифры. Если переданное в функцию число является однозначным или двузначным, функция должна вернуть число `0`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION SUM_OF_MID_DIGITS(number INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE result INT DEFAULT 0;
      
      IF number < 100 THEN
          RETURN 0;
      END IF;
  
      SET number := number DIV 10;
      WHILE number > 9 DO
          SET result := result + number MOD 10;
          SET number := number DIV 10;
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №8](https://stepik.org/lesson/1050404/step/14?unit=1059446)

Реализуйте функцию `COMPARE_TWO_NUMBERS()`, которая принимает два аргумента в следующем порядке:

* `a` — целое число;
* `b` — целое число.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION COMPARE_TWO_NUMBERS(a INT, b INT)
  RETURNS TEXT
  DETERMINISTIC
  BEGIN
      IF a < b THEN
          RETURN CONCAT(a, ' < ', b);
      ELSEIF b < a THEN
          RETURN CONCAT(a, ' > ', b);
      ELSE
          RETURN CONCAT(a, ' = ', b);
      END IF;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №9](https://stepik.org/lesson/1050404/step/15?unit=1059446)

Реализуйте функцию `DIGITAL_ROOT()`, которая принимает один аргумент:

* `number` — положительное целое число.

Функция должна возвращать цифровой корень числа `number`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION DIGITAL_ROOT(number INT)
  RETURNS INT
  DETERMINISTIC
  BEGIN
      DECLARE result INT DEFAULT 0;
  
      WHILE number != 0 DO
          SET result := result + number MOD 10;
          SET number := number DIV 10;
          IF number = 0 AND result > 9 THEN
              SET number := result;
              SET result := 0;
          END IF;
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>

---

[Task №10](https://stepik.org/lesson/1050404/step/16?unit=1059446)

Реализуйте функцию `REPEAT_AFTER_ME()`, которая принимает два аргумента в следующем порядке:

* `delimiter` — строка;
* `n` — положительное целое число.

Функция должна возвращать строку, сформированную следующим образом:

`0 <delimiter> 1 <delimiter> 2 <delimiter> 3 <delimiter> ... <delimiter> n`

Строка должна содержать последовательные целые числа от `0` до `n`, между которыми заключена строка `delimiter`.

<details>
  <summary>Решение</summary>

  ```sql
  DELIMITER //
  CREATE FUNCTION REPEAT_AFTER_ME(delimiter TEXT, n INT)
  RETURNS TEXT
  DETERMINISTIC
  BEGIN
      DECLARE ind INT DEFAULT 1;
      DECLARE result TEXT DEFAULT '0';
      
      WHILE ind <= n DO
          SET result := CONCAT(result, ' ', delimiter, ' ', ind);
          SET ind := ind + 1;
      END WHILE;
      
      RETURN result;
  END //
  DELIMITER ;
  ```

</details>
