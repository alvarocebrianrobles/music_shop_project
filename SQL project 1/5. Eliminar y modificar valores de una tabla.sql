DROP TABLE albums CASCADE;
DROP TABLE artists CASCADE;
DROP TABLE cities CASCADE;
DROP TABLE composers CASCADE;
DROP TABLE customers CASCADE;
DROP TABLE employee CASCADE;
DROP TABLE genres CASCADE;
DROP TABLE invoicelines CASCADE;
DROP TABLE invoices CASCADE;
DROP TABLE mediatype CASCADE;
DROP TABLE positions CASCADE;
DROP TABLE tracks CASCADE;
DROP TABLE customer_address CASCADE;
DROP TABLE customer_contact CASCADE;
DROP TABLE employee_address CASCADE;
DROP TABLE emp_contact CASCADE;
DROP TABLE track_details CASCADE;
DROP TABLE artist_track CASCADE;


-- Para borrar todos los valores de una tabla:
TRUNCATE table_name CASCADE


-- Crear secuencia de valores para una id
CREATE SEQUENCE user_id_seq;
ALTER TABLE user ALTER user_id SET DEFAULT NEXTVAL('user_id_seq');


-- Eliminar elementos repetidos de una tabla (al importar valores iguales de dos tablas diferentes [customer_address] y [invoice_address])

DELETE FROM cities
WHERE city_id IN (SELECT city_id
              FROM (SELECT city_id,
                             ROW_NUMBER() OVER (partition BY city, state, country ORDER BY city_id) AS rnum
                     FROM cities) t
              WHERE t.rnum > 1);