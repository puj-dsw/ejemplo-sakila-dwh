use sakila_datawh;

select 
  year_month_number,
  customer_country, 
  sum(rental.count_rentals) as count_rentals
from 
    fact_rental as rental
    join dim_date as fecha using (date_key)
    join dim_customer using (customer_key)
group by 
    year_month_number,
    customer_country
limit 5
;