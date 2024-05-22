--1. Посчитать количество заказов за все время
SELECT COUNT(*)
FROM public.orders o;

--2. Посчитать сумму по всем заказам за все время (учитывая скидки)
SELECT CAST(SUM(unit_price * quantity * (1 - discount)) AS numeric(9, 2)) AS "Сумма всех заказов"
FROM order_details od;

--3. Показать сколько сотрудников работает в каждом городе.quantity
SELECT city AS "Город",
       COUNT(*) AS "Колличество сотрудников"
FROM employees e
GROUP BY city ;

--4. Выявить самый продаваемый товар в штуках. Вывести имя продукта и его количество.
SELECT p.product_name AS "Имя продукта",
       SUM(od.quantity) AS "Количество товара шт."
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY "Количество товара шт." DESC
LIMIT 1;

--5. Выявить фио сотрудника, у которого сумма всех заказов самая маленькая
SELECT e.last_name,
       e.first_name
FROM employees e
WHERE e.employee_id =
    (SELECT employee_id
     FROM
       (SELECT employee_id,
               sum(od.unit_price * od.quantity * (1 - od.discount)) AS profit
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY employee_id
        ORDER BY profit ASC
        LIMIT 1) AS t1);
		
