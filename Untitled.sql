-- 1. Write a query to find what is the total business done by each store.

select s.store_id, sum(p.amount) as total_sales
from sakila.store s 
join sakila.customer c using (store_id)
join sakila.payment p using(customer_id)
group by s.store_id;


-- 2. Convert the previous query into a stored procedure.

delimiter //
create procedure TotalSalesPerStore()
begin
     select s.store_id, sum(p.amount) as total_sales
     from sakila.store s 
     join sakila.customer c using (store_id)
     join sakila.payment p using(customer_id)
     group by s.store_id;
end
// delimiter ;


-- 3.Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

delimiter //
create procedure TotalSalesPerStore(in x integer)
begin
     select s.store_id, sum(p.amount) as total_sales
     from sakila.store s 
     join sakila.customer c using (store_id)
     join sakila.payment p using(customer_id)
     where s.store_id = x
     group by s.store_id;
     
     
     
end// 
delimiter ;



-- 4. Update the previous query. Declare a variable total_sales_value of float type, 
-- that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.

delimiter //
create procedure TotalSalesPerStore(in x integer)
begin

     declare total_sales_value float;
     
     select s.store_id, sum(p.amount) as total_sales
     from sakila.store s 
     join sakila.customer c using (store_id)
     join sakila.payment p using(customer_id)
     where s.store_id = x
     group by s.store_id;
     
     
     select total_sales_value;
end// 
delimiter ;

call TotalSalesPerStore(1);



-- 4. In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, 
-- otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.


delimiter //
create procedure TotalSalesPerStore(in x integer)
begin

     declare total_sales_value float;
     declare flag varchar(20);
     
     select s.store_id, sum(p.amount) as total_sales
     from sakila.store s 
     join sakila.customer c using (store_id)
     join sakila.payment p using(customer_id)
     where s.store_id = x
     group by s.store_id;
     
     
     if total_sales_value > 30.000 then
		set flag = 'green_flag';
	else 
        set flag = 'red_flag';
	end if;
     
     
     select total_sales_value, flag;
end// 
delimiter ;

call TotalSalesPerStore(1);







