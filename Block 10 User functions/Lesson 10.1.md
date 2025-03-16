# Переменные

[Task №1](https://stepik.org/lesson/1049035/step/11?unit=1057986)

Напишите запрос, который создает пользовательскую переменную с именем `variable` и присваивает ей в качестве значения строку `Hello, World!`.

<details>
  <summary>Решение</summary>

  ```sql
  SET @variable := 'Hello, World!';
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1049035/step/12?unit=1057986)

Напишите запрос, который создает пользовательскую переменную с именем `number` и присваивает ей в качестве значения число `2361822`, представленное в двоичной системе счисления.

<details>
  <summary>Решение</summary>

  ```sql
  SET @number := CONV(2361822, 10, 2);
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1049035/step/13?unit=1057986)

Напишите запрос, который создает пользовательские переменные с именами `name`, `birthdate` и `pets`. В качестве значения переменной `name` должно быть присвоено Ваше имя, представленное строкой, переменной `birthdate` — Ваша дата рождения в формате `YYYY-MM-DD`, переменной `pets` — количество имеющихся у Вас домашних животных.

<details>
  <summary>Решение</summary>

  ```sql
  SET @name = 'Spider-Man',
      @birthdate = '2000-01-01',
      @pets = 0;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1049035/step/14?unit=1057986)

Напишите запрос, который создает пользовательскую переменную с именем `avg_usa_rating` и присваивает ей в качестве значения средний рейтинг режиссеров из `USA`, округленный до `2` знаков после запятой.

<details>
  <summary>Решение</summary>

  ```sql
  SET @avg_usa_rating := (SELECT ROUND(AVG(rating), 2)
                          FROM Directors
                          WHERE country = 'USA');
  
  SELECT @avg_usa_rating;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1049035/step/15?unit=1057986)

Напишите запрос, который создает пользовательскую переменную с именем `num_of_rated_directors` и присваивает ей в качестве значения количество режиссеров, рейтинг которых известен.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT COUNT(rating) INTO @num_of_rated_directors
  FROM Directors;
  
  SELECT @num_of_rated_directors;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1049035/step/16?unit=1057986)

Напишите запрос, который создает пользовательскую переменную с именем `min_usa_rating`, присваивает ей в качестве значения минимальный рейтинг режиссеров из `USA` и извлекает значение созданной переменной.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT MIN(rating) INTO @min_usa_rating
  FROM Directors
  WHERE country = 'USA';
  
  SELECT @min_usa_rating AS min_usa_rating;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1049035/step/17?unit=1057986)

Напишите запрос, который создает пользовательские переменные с именами `name`, `surname` и `rating`. В качестве значения переменной `name` должно быть присвоено имя режиссера из `USA` с наименьшим рейтингом, переменным `surname` и `rating` — фамилия и рейтинг соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT name, surname, rating INTO @name, @surname, @rating
  FROM Directors
  WHERE country = 'USA'
  ORDER BY rating
  LIMIT 1;
  
  SELECT @name, @surname, @rating;
  ```

</details>
