# Индексы

[Task №1](https://stepik.org/lesson/1494631/step/13?unit=1514605)

Напишите запрос, который создает для таблицы `Films` некластеризованный индекс с именем `idx_director` на основе поля `director`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE INDEX idx_director
  ON Films(director);
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1494631/step/14?unit=1514605)

Напишите запрос, который переименовывает существующий некластеризованный индекс с именем `idx` в индекс с именем `idx_director`.

<details>
  <summary>Решение</summary>

  ```sql
  ALTER TABLE Films
  RENAME INDEX idx TO idx_director;
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1494631/step/15?unit=1514605)

Напишите запрос, который создает для таблицы `Films` некластеризованный индекс с именем `idx_director_release_year` на основе полей `director` и `release_year`.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE INDEX idx_director_release_year
  ON Films(director, release_year);
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1494631/step/16?unit=1514605)

Напишите запрос, который удаляет существующий некластеризованный индекс с именем `idx_full_film_info` из таблицы `Films`, а затем создает некластеризованный индекс с тем же именем на основе полей `title`, `director` и `release_year`.

<details>
  <summary>Решение</summary>

  ```sql
  DROP INDEX idx_full_film_info ON Films;

  CREATE INDEX idx_full_film_info
  ON Films(title, director, release_year);
  ```

</details>
