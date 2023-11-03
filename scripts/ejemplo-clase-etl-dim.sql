## ETL de carga de la dimensión Customer

-- 3. cargar
INSERT INTO sakila_datawh.dim_customer (
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_active,
    customer_address,
    customer_district,
    customer_city,
    customer_country,
    customer_valid_from,
    customer_valid_through
)
-- 1. extraer datos
with datos as (
    SELECT 
        customer_id,
        first_name,
        last_name,
        active,
        a.address,
        a.district,
        city.city,
        country.country
    FROM sakila.customer c
        LEFT JOIN sakila.address a
            ON c.address_id = a.address_id
        LEFT JOIN sakila.city city
            ON a.city_id = city.city_id
        LEFT JOIN sakila.country country
            ON city.country_id = country.country_id
),
-- 2. transformar
datos_transformados as (
    SELECT 
        customer_id,
        first_name,
        last_name,
        active,
        address,
        district,
        city,
        country,
        CURRENT_DATE as customer_valid_from,
        CURRENT_DATE as customer_valid_through
    from 
        datos
)
select *
  from datos_transformados
;