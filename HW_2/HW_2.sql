--1. Посчитать количество заказов за все время
select
	COUNT(*)
from
	public.orders o;

--2. Посчитать сумму по всем заказам за все время (учитывая скидки)
select
	CAST(SUM(unit_price * quantity * (1 - discount)) as numeric(9, 2)) as "Сумма всех заказов"
from
	order_details od;

--3. Показать сколько сотрудников работает в каждом городе.quantity
select
	city as "Город",
	COUNT(*) as "Колличество сотрудников"
from
	employees e
group by
	city ;

--4. Выявить самый продаваемый товар в штуках. Вывести имя продукта и его количество.
select
	p.product_name as "Имя продукта",
	SUM(od.quantity) as "Количество товара шт."
from
	products p
join order_details od on
	p.product_id = od.product_id
group by
	p.product_name
order by
	"Количество товара шт." desc
limit 1;

--5. Выявить фио сотрудника, у которого сумма всех заказов самая маленькая
select
	e.last_name,
	e.first_name
from
	employees e
where
	e.employee_id = (
	select
		employee_id
	from (
		select
			employee_id,
			sum(od.unit_price * od.quantity * (1 - od.discount)) as profit
		from
			orders o
		join order_details od on
			o.order_id = od.order_id
		group by
			employee_id
		order by
			profit asc
		limit 1) as t1)