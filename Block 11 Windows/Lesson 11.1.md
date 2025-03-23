# Ранжирующие функции. Часть 1

[Task №1](https://stepik.org/lesson/1264336/step/15?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, имя и фамилия режиссера, год выхода), а также пронумеровывает их, начиная с `1`, в порядке возрастания года выхода.
Поле с номером фильма должно располагаться на первом месте и иметь псевдоним `num`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `num`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT ROW_NUMBER() OVER all_rows AS num,
         title, director, release_year
  FROM Films
  WINDOW all_rows AS (ORDER BY release_year)
  ORDER BY num DESC;
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1264336/step/16?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных информацию обо всех фильмах (название, имя и фамилия режиссера, год выхода), а также пронумеровывает их, начиная с `0` с шагом `5` (`0, 5, 10, ...`), в порядке убывания года выхода.
Поле с номером фильма должно располагаться на первом месте и иметь псевдоним `num`.
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля `num`.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT ((ROW_NUMBER() OVER step_5 - 1) * 5) AS num,
         title, director, release_year
  FROM Films
  WINDOW step_5 AS (ORDER BY release_year DESC)
  ORDER BY num DESC;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1264336/step/17?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных информацию о фильмах (название, имя и фамилия режиссера, год выхода), а также пронумеровывает их, начиная с `1`, в рамках режиссера в порядке возрастания года выхода.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT ROW_NUMBER() OVER order_director AS num,
         title, director, release_year
  FROM Films
  WINDOW order_director AS (PARTITION BY director ORDER BY release_year)
  ORDER BY director, num DESC;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1264336/step/18?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных все простые числа, а также пронумеровывает их латинскими буквами, начиная с `A`, в порядке возрастания.

<details>
  <summary>Решение</summary>

  ```sql
  SELECT CONVERT(CHAR(ROW_NUMBER() OVER letter_number + 64), CHAR) AS letter, 
         num
  FROM PrimeNumbers
  WINDOW letter_number AS (ORDER BY num)
  ORDER BY num DESC;
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1264336/step/19?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех режиссеров, а также указывает для каждого режиссера название его самого раннего фильма.

<details>
  <summary>Решение</summary>

  ```sql
  WITH WindowCTE AS (
      SELECT ROW_NUMBER() OVER director_film AS num, director, title
      FROM Films
      WINDOW director_film AS (PARTITION BY director ORDER BY release_year)
  )
  
  SELECT director, title
  FROM WindowCTE
  WHERE num = 1;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1264336/step/20?unit=1278466)

Напишите запрос, который извлекает из предложенной базы данных информацию об уникальных фильмах (название, имя и фамилия режиссера, год выхода), а также пронумеровывает их, начиная с `1`, в порядке возрастания года выхода.

<details>
  <summary>Решение</summary>

  ```sql
  WITH UniqueFilms AS (
      SELECT DISTINCT title, director, release_year
      FROM Films 
  )
  
  SELECT ROW_NUMBER() OVER all_rows AS num,
         UniqueFilms.*
  FROM UniqueFilms
  WINDOW all_rows AS (ORDER BY release_year)
  ORDER BY num DESC;
  ```

</details>

---

[Task №7](https://stepik.org/lesson/1264336/step/21?unit=1278466)

Напишите запрос, который находит все островки, содержащиеся в последовательности чисел из таблицы `Numbers`, и отображает полученный результат в виде таблицы из двух полей:

* `start` — начало островка;
* `end` — конец островка.

<details>
  <summary>Решение</summary>

  ```sql
  WITH DiffNumberAndRow AS (
      SELECT num,
             num - ROW_NUMBER() OVER row_numbers AS diff
      FROM Numbers
      WINDOW row_numbers AS (ORDER BY num)
  )
  
  SELECT MIN(num) AS start,
         MAX(num) AS end
  FROM DiffNumberAndRow
  GROUP BY diff;
  ```

</details>
