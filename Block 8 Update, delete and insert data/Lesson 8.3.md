# Добавление данных

[Task №1](https://stepik.org/lesson/1045354/step/13?unit=1053929)

Напишите запрос, который добавляет в таблицу Songs информацию о песне под названием `Let Me Kiss You`, исполнителем которой является `Morrissey`. Идентификатор добавляемой песни должен быть на единицу больше идентификатора последней песни в таблице `Songs`.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO Songs
  VALUES (6, 'Let Me Kiss You', 'Morrissey');
  ```

</details>

---

[Task №2](https://stepik.org/lesson/1045354/step/14?unit=1053929)

Напишите запрос, который добавляет в таблицу `Songs` информацию о трех следующих песнях:

|Название|Исполнитель|
|:---:|:---:|
|`Running up That Hill`|`Kate Bush`|
|`Thrill`|`The Sounds`|
|`Keep Yourself Alive`|`Queen`|

Идентификатор добавляемой первой песни должен быть на единицу больше идентификатора последней песни в таблице `Songs`, идентификаторы следующих песен — на два и на три соответственно.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO Songs (id, artist, trackname)
  VALUES (6, 'Kate Bush', 'Running up That Hill'),
        (7, 'The Sounds', 'Thrill'),
        (8, 'Queen', 'Keep Yourself Alive');
  ```

</details>

---

[Task №3](https://stepik.org/lesson/1045354/step/15?unit=1053929)

Таблица `NewSongs` имеет ту же структуру, что и таблица `Songs`, но не содержит ни одной записи.

Напишите запрос, который копирует содержимое таблицы `Songs` в таблицу `NewSongs`.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO NewSongs
  SELECT id, trackname, artist
  FROM Songs;
  ```

</details>

---

[Task №4](https://stepik.org/lesson/1045354/step/16?unit=1053929)

Напишите запрос, который копирует информацию о песнях исполнителя `Morrissey` из таблицы `Songs` в таблицу `MorrisseySongs`, а затем удаляет информацию о песнях данного исполнителя из таблицы `Songs`.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO MorrisseySongs
  SELECT id, trackname, artist
  FROM Songs
  WHERE artist = 'Morrissey';
  
  DELETE FROM Songs
  WHERE artist = 'Morrissey';
  ```

</details>

---

[Task №5](https://stepik.org/lesson/1045354/step/17?unit=1053929)

Таблица `NewSongs` имеет ту же структуру, что и таблица `Songs`, но не содержит ни одной записи.

Напишите запрос, который копирует информацию о первой и последней песнях из таблицы `Songs` в таблицу `NewSongs`.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO NewSongs
  SELECT *
  FROM Songs
  ORDER BY id
  LIMIT 1;
  
  INSERT INTO NewSongs
  SELECT *
  FROM Songs
  ORDER BY id DESC
  LIMIT 1;
  ```

</details>

---

[Task №6](https://stepik.org/lesson/1045354/step/18?unit=1053929)

Напишите запрос, который добавляет в таблицу `NewSongs` информацию о песнях из таблицы `Songs`. Идентификатор первой добавляемой песни должен быть на единицу больше идентификатора последней песни в таблице `NewSongs`, идентификаторы следующих песен — на два, на три, и так далее.

<details>
  <summary>Решение</summary>

  ```sql
  INSERT INTO NewSongs
  SELECT (SELECT MAX(id)
          FROM NewSongs) + Songs.id, 
         trackname, artist
  FROM Songs;
  ```

</details>
