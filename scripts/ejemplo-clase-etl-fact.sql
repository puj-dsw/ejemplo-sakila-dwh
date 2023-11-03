## ETL de carga de la tabla de hechos

-- 3. cargar
INSERT INTO fact_rental (
    customer_key,
    staff_key,
    film_key,
    store_key,
    date_key,
    count_returns,
    count_rentals
)
-- 1. extraer los datos de la fuente (OLTP)
with datos as (
    SELECT 
        rental_id,
        rental_date,
        customer_id,
        staff_id,
        inventory_id,
        inventory.film_id,
        inventory.store_id,
        return_date
    FROM sakila.rental AS rental
    join sakila.inventory using(inventory_id)
),
-- 2. transformar obteniendo los keys
datos_transformados as (
    select
        -- rental_id,
        dim_customer.customer_key as customer_key,
        dim_staff.staff_key as staff_key,
        dim_film.film_key as film_key,
        dim_store.store_key as store_key,
        TO_DAYS(rental_date) as date_key,
        case when return_date is null then 0 else 1 end as count_returns,
        1 as count_rentals
    from
        datos
        join sakila_datawh.dim_customer on datos.customer_id = dim_customer.customer_id
        join sakila_datawh.dim_staff on datos.staff_id = dim_staff.staff_id
        join sakila_datawh.dim_film on datos.film_id = dim_film.film_id
        join sakila_datawh.dim_store on datos.store_id = dim_store.store_id
)
select *
from datos_transformados
;
