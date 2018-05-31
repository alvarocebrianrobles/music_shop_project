-- Imoprtar datos del csv

COPY music_shop
FROM '/Users/myMusicShop.csv' DELIMITER ',' CSV HEADER;

-- Eliminar comas

update music_shop
set track_bytes = regexp_replace(track_bytes, ',','');

update music_shop
set trackid = regexp_replace(trackid, ',','');

update music_shop
set invoicelineid = regexp_replace(invoicelineid, ',','');

update music_shop
set track_milliseconds = regexp_replace(track_milliseconds, ',', '');

update music_shop
set track_bytes = regexp_replace(track_bytes, ',','');

update music_shop
set track_milliseconds = regexp_replace(track_milliseconds, ',', '');

-- Cambiar tipos de datos (varchar to integer, date, monet, etc.) 

alter table musicshop
alter column albumid TYPE INTEGER USING (albumid::integer),
alter column artistid TYPE INTEGER USING (artistid::integer),
alter column trackid TYPE INTEGER USING (trackid::integer),
alter column track_milliseconds TYPE INTEGER USING (track_milliseconds::integer),
alter column track_bytes TYPE INTEGER USING (track_bytes::integer),
alter column track_unit_price TYPE MONEY USING (track_unit_price::money),
alter column genreid TYPE INTEGER USING (genreid::integer),
alter column mediatypeid TYPE INTEGER USING (mediatypeid::integer),
alter column invoicelineid TYPE INTEGER USING (invoicelineid::integer),
alter column invoice_line_unit_price TYPE MONEY USING (mediatypeid::money),
alter column invoice_line_quantity TYPE INTEGER USING (invoice_line_quantity::integer),
alter column invoice_line_total TYPE MONEY USING (invoice_line_total::money),
alter column invoiceid TYPE INTEGER USING (invoiceid::integer),
alter column invoice_date TYPE DATE USING to_date(invoice_date, 'YYYY-MM-DD'),
alter column invoice_total TYPE MONEY USING (invoice_total::money),
alter column customerid TYPE INTEGER USING (customerid::integer),
alter column employee_reports_to TYPE INTEGER USING (employee_reports_to::integer),
alter column employee_birth_date TYPE DATE USING to_date(employee_birth_date, 'YYYY-MM-DD'),
alter column employee_hire_date TYPE DATE USING to_date(employee_hire_date, 'YYYY-MM-DD')




