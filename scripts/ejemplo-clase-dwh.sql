## Bodega de datos

CREATE DATABASE IF NOT EXISTS sakila_dwh;
USE sakila_dwh;

## Dimension de Tiempo
# date_key
# date_value
# day_number
# day_of_week
# month_name
# month_number
# year4

CREATE TABLE IF NOT EXISTS dim_date 
(
    date_key        INT(8) NOT NULL,  -- no es autoincrement
    date_value      DATE NOT NULL,
    day_number      INT(2) NOT NULL,
    day_of_week     CHAR(20) NOT NULL,
    month_name      CHAR(20) NOT NULL,
    month_number    INT(2) NOT NULL,
    year4           INT(4) NOT NULL,

    primary key (date_key),
    unique index date_value (date_value)
)
;

## Dim customer
# customer_key
# customer_id
# customer_name
# city
# country

CREATE TABLE IF NOT EXISTS dim_customer
(
    customer_key  INT AUTO_INCREMENT,
    customer_id     SMALLINT,
    customer_name   VARCHAR(90),
    

)

