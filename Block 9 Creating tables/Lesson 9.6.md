# Представления

[Task №1](https://stepik.org/lesson/1057059/step/13?unit=1066390)

Напишите запрос, создающий представление с именем `LowStockProducts`. Представление должно включать информацию (название, количество) о товарах, количество которых на складе меньше десяти штук.

<details>
  <summary>Решение</summary>

  ```sql
  CREATE VIEW LowStockProducts AS
  SELECT name, stock
  FROM Products
  WHERE stock < 10;
  ```

</details>

---

