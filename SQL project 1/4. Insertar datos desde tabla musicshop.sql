INSERT INTO cities (city, state, country)
SELECT DISTINCT employee_city, employee_state, employee_country FROM musicshop;

INSERT INTO cities (city, state, country)
SELECT DISTINCT invoice_billing_city, invoice_billing_state, invoice_billing_country FROM musicshop;

INSERT INTO cities (city, state, country)
SELECT DISTINCT customer_city, customer_state, customer_country FROM musicshop;

DELETE FROM cities
WHERE city_id IN (SELECT city_id
              FROM (SELECT city_id,
                             ROW_NUMBER() OVER (partition BY city, state, country ORDER BY city_id) AS rnum
                     FROM cities) t
              WHERE t.rnum > 1);


-- Employee

INSERT INTO positions (title)
SELECT DISTINCT employee_title FROM musicshop;

-- Hay que cambiar el id 2 de employee porque hace referencia al supervisor que se especifica en la columna reporst_to y no sabemos quién es
INSERT INTO employee (first_name, last_name, birth_date, hire_date, position_id) 
SELECT DISTINCT employee_first_name, employee_last_name, employee_birth_date, employee_hire_date, position_id
FROM musicshop as mus JOIN positions as pos 
ON mus.employee_title = pos.title;

INSERT INTO employee_address (address, postal_code, city_id) 
SELECT DISTINCT employee_address, employee_postal_code, city_id
FROM musicshop as mus LEFT JOIN cities as cit 
ON mus.employee_city = cit.city AND mus.employee_country = cit.country;

INSERT INTO emp_contact (phone, fax, email, emp_address_id, employee_id) 
SELECT DISTINCT employee_phone, employee_fax, employee_email, emp_address_id, employee_id
FROM musicshop as mus 
	JOIN employee_address as ead ON mus.employee_address = ead.address AND mus.employee_postal_code = ead.postal_code
	JOIN employee as emp ON mus.employee_first_name = emp.first_name AND mus.employee_last_name = emp.last_name AND mus.employee_birth_date = emp.birth_date;


-- Customers

INSERT INTO customers 
SELECT DISTINCT customerid, customer_first_name, customer_last_name
FROM musicshop as mus;

INSERT INTO customer_address (address, postal_code, city_id) 
SELECT DISTINCT customer_address, customer_postal_code, city_id
FROM musicshop as mus LEFT JOIN cities as cit 
ON mus.customer_city = cit.city	AND mus.customer_country = cit.country;

INSERT INTO customer_address (address, postal_code, city_id) 
SELECT DISTINCT invoice_billing_address, invoice_billing_postal_code, city_id
FROM musicshop as mus LEFT JOIN cities as cit 
ON mus.customer_city = cit.city	AND mus.customer_country = cit.country;

DELETE FROM customer_address
WHERE address_id IN (SELECT address_id
              FROM (SELECT address_id,
                             ROW_NUMBER() OVER (partition BY address, postal_code, city_id ORDER BY address_id) AS rnum
                     FROM customer_address) t
              WHERE t.rnum > 1);

INSERT INTO customer_contact (phone, fax, email, address_id, customerid) 
SELECT DISTINCT customer_phone, customer_fax, customer_email, address_id, cus.customerid
FROM musicshop as mus 
	LEFT JOIN customer_address as cad ON mus.customer_address = cad.address AND mus.customer_postal_code = cad.postal_code
	JOIN customers as cus ON mus.customerid = cus.customerid;
-- Hago el left join porque hay 4 customers que tienen código postal nulo.


-- Invoices

INSERT INTO invoices
SELECT DISTINCT invoiceid, invoice_date, customerid, employee_id, address_id
FROM musicshop as mus 
	JOIN employee as emp ON mus.employee_first_name = emp.first_name AND mus.employee_last_name = emp.last_name
	JOIN customer_address as cad ON mus.customer_address = cad.address; -- No es necesario añadir el post_code porque todos los address son diferentes en el csv


-- Tracks

INSERT INTO genres 
SELECT DISTINCT genreid, music_genre
FROM musicshop as mus;

INSERT INTO mediatype 
SELECT DISTINCT mediatypeid, media_type
FROM musicshop as mus;

INSERT INTO composers(composer)
SELECT DISTINCT track_composer
FROM musicshop as mus;

INSERT INTO albums 
SELECT DISTINCT albumid, album_title
FROM musicshop as mus;

INSERT INTO artists 
SELECT DISTINCT artistid, artist_name
FROM musicshop as mus;

INSERT INTO tracks 
SELECT DISTINCT ON(trackid) trackid, track_name, track_unit_price, mus.albumid, composer_id
FROM musicshop as mus 
JOIN albums ON mus.albumid = albums.albumid
LEFT JOIN composers as comp ON mus.track_composer = comp.composer;

INSERT INTO artist_track 
SELECT DISTINCT mus.trackid, mus.artistid
FROM musicshop as mus 
JOIN tracks ON mus.trackid = tracks.trackid
JOIN artists ON mus.artistid = artists.artistid;

INSERT INTO track_details 
SELECT DISTINCT trackid, track_milliseconds, track_bytes, mediatypeid, genreid
FROM musicshop as mus 
JOIN mediatype as med ON mus.media_type = med.music_type
JOIN genres ON mus.music_genre = genres.music_genre;


-- Invoicelines

INSERT INTO invoicelines 
SELECT DISTINCT invoicelineid, invoice_line_quantity, invoice_line_unit_price, invoice_line_total, invoiceid, trackid 
FROM musicshop as mus;









