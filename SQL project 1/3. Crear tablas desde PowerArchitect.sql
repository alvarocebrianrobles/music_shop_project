
CREATE SEQUENCE public.positions_position_id_seq;

CREATE TABLE public.positions (
                position_id INTEGER NOT NULL DEFAULT nextval('public.positions_position_id_seq'),
                title VARCHAR,
                CONSTRAINT positions_pk PRIMARY KEY (position_id)
);


ALTER SEQUENCE public.positions_position_id_seq OWNED BY public.positions.position_id;

CREATE SEQUENCE public.cities_city_id_seq;

CREATE TABLE public.Cities (
                city_id INTEGER NOT NULL DEFAULT nextval('public.cities_city_id_seq'),
                city VARCHAR NOT NULL,
                state VARCHAR,
                country VARCHAR,
                CONSTRAINT cities_pk PRIMARY KEY (city_id)
);


ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.Cities.city_id;

CREATE SEQUENCE public.address_addressid_seq_1_2;

CREATE TABLE public.customer_address (
                address_id INTEGER NOT NULL DEFAULT nextval('public.address_addressid_seq_1_2'),
                address VARCHAR,
                postal_code VARCHAR,
                city_id INTEGER,
                CONSTRAINT customer_address_pk PRIMARY KEY (address_id)
);


ALTER SEQUENCE public.address_addressid_seq_1_2 OWNED BY public.customer_address.address_id;

CREATE SEQUENCE public.composers_composer_id_seq_1;

CREATE TABLE public.composers (
                composer_id INTEGER NOT NULL DEFAULT nextval('public.composers_composer_id_seq_1'),
                composer VARCHAR,
                CONSTRAINT composers_pk PRIMARY KEY (composer_id)
);


ALTER SEQUENCE public.composers_composer_id_seq_1 OWNED BY public.composers.composer_id;

CREATE SEQUENCE public.address_addressid_seq_1_1;

CREATE TABLE public.employee_address (
                emp_address_id INTEGER NOT NULL DEFAULT nextval('public.address_addressid_seq_1_1'),
                address VARCHAR,
                postal_code VARCHAR,
                city_id INTEGER,
                CONSTRAINT employee_address_pk PRIMARY KEY (emp_address_id)
);


ALTER SEQUENCE public.address_addressid_seq_1_1 OWNED BY public.employee_address.emp_address_id;

CREATE SEQUENCE public.employee_employeeid_seq_1_1_1;

CREATE TABLE public.employee (
                employee_id INTEGER NOT NULL DEFAULT nextval('public.employee_employeeid_seq_1_1_1'),
                first_name VARCHAR,
                last_name VARCHAR,
                birth_date DATE,
                hire_date DATE,
                position_id INTEGER,
                CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);


ALTER SEQUENCE public.employee_employeeid_seq_1_1_1 OWNED BY public.employee.employee_id;

CREATE SEQUENCE public.employee_employeeid_seq_1_1_3;

CREATE TABLE public.emp_contact (
                emp_contact_id INTEGER NOT NULL DEFAULT nextval('public.employee_employeeid_seq_1_1_3'),
                phone VARCHAR,
                fax VARCHAR,
                email VARCHAR,
                emp_address_id INTEGER NOT NULL,
                employee_id INTEGER NOT NULL,
                CONSTRAINT emp_contact_pk PRIMARY KEY (emp_contact_id)
);


ALTER SEQUENCE public.employee_employeeid_seq_1_1_3 OWNED BY public.emp_contact.emp_contact_id;

CREATE TABLE public.customers (
                customerid INTEGER NOT NULL,
                first_name VARCHAR,
                last_name VARCHAR,
                CONSTRAINT customers_pk PRIMARY KEY (customerid)
);


CREATE SEQUENCE public.employee_employeeid_seq_1_1_4;

CREATE TABLE public.customer_contact (
                cust_contact_id INTEGER NOT NULL DEFAULT nextval('public.employee_employeeid_seq_1_1_4'),
                phone VARCHAR,
                fax VARCHAR,
                email VARCHAR,
                address_id INTEGER,
                customerid INTEGER NOT NULL,
                CONSTRAINT customer_contact_pk PRIMARY KEY (cust_contact_id)
);


ALTER SEQUENCE public.employee_employeeid_seq_1_1_4 OWNED BY public.customer_contact.cust_contact_id;

CREATE TABLE public.invoices (
                invoiceid INTEGER NOT NULL,
                invoice_date DATE,
                customerid INTEGER NOT NULL,
                employee_id INTEGER NOT NULL,
                address_id INTEGER NOT NULL,
                CONSTRAINT invoiceid PRIMARY KEY (invoiceid)
);


CREATE TABLE public.mediatype (
                mediatypeid INTEGER NOT NULL,
                music_type VARCHAR,
                CONSTRAINT mediatypeid PRIMARY KEY (mediatypeid)
);


CREATE TABLE public.genres (
                genreid INTEGER NOT NULL,
                music_genre VARCHAR,
                CONSTRAINT genreid PRIMARY KEY (genreid)
);


CREATE TABLE public.artists (
                artistid INTEGER NOT NULL,
                artist_name VARCHAR,
                CONSTRAINT artistid PRIMARY KEY (artistid)
);


CREATE TABLE public.albums (
                albumid INTEGER NOT NULL,
                album_title VARCHAR,
                CONSTRAINT albumid PRIMARY KEY (albumid)
);


CREATE TABLE public.tracks (
                trackid INTEGER NOT NULL,
                name VARCHAR,
                unit_price NUMERIC,
                albumid INTEGER NOT NULL,
                composer_id INTEGER,
                CONSTRAINT trakcid PRIMARY KEY (trackid)
);


CREATE TABLE public.artist_track (
                trackid INTEGER NOT NULL,
                artistid INTEGER NOT NULL,
                CONSTRAINT artist_track_pk PRIMARY KEY (trackid)
);


CREATE TABLE public.track_details (
                trackid INTEGER NOT NULL,
                milliseconds INTEGER,
                track_bytes INTEGER,
                mediatypeid INTEGER,
                genreid INTEGER,
                CONSTRAINT track_details_pk PRIMARY KEY (trackid)
);


CREATE TABLE public.invoicelines (
                invoicelineid INTEGER NOT NULL,
                quantity INTEGER,
                unit_price NUMERIC,
                line_total NUMERIC,
                invoiceid INTEGER NOT NULL,
                trackid INTEGER NOT NULL,
                CONSTRAINT invoicelineid PRIMARY KEY (invoicelineid)
);


ALTER TABLE public.employee ADD CONSTRAINT positions_employee_fk
FOREIGN KEY (position_id)
REFERENCES public.positions (position_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employee_address ADD CONSTRAINT cities_customer_addresses_fk
FOREIGN KEY (city_id)
REFERENCES public.Cities (city_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_address ADD CONSTRAINT cities_customer_address_fk
FOREIGN KEY (city_id)
REFERENCES public.Cities (city_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_contact ADD CONSTRAINT customer_address_customer_contact_fk
FOREIGN KEY (address_id)
REFERENCES public.customer_address (address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.invoices ADD CONSTRAINT customer_address_invoices_fk
FOREIGN KEY (address_id)
REFERENCES public.customer_address (address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tracks ADD CONSTRAINT composers_tracks_fk
FOREIGN KEY (composer_id)
REFERENCES public.composers (composer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.emp_contact ADD CONSTRAINT employee_address_emp_contact_fk
FOREIGN KEY (emp_address_id)
REFERENCES public.employee_address (emp_address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.invoices ADD CONSTRAINT employee_invoices_fk
FOREIGN KEY (employee_id)
REFERENCES public.employee (employee_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.emp_contact ADD CONSTRAINT employee_emp_contact_fk
FOREIGN KEY (employee_id)
REFERENCES public.employee (employee_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.invoices ADD CONSTRAINT customers_invoices_fk
FOREIGN KEY (customerid)
REFERENCES public.customers (customerid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.customer_contact ADD CONSTRAINT customers_customer_contact_fk
FOREIGN KEY (customerid)
REFERENCES public.customers (customerid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.invoicelines ADD CONSTRAINT invoices_invoicelines_fk
FOREIGN KEY (invoiceid)
REFERENCES public.invoices (invoiceid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.track_details ADD CONSTRAINT mediatype_track_details_fk
FOREIGN KEY (mediatypeid)
REFERENCES public.mediatype (mediatypeid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.track_details ADD CONSTRAINT genres_track_details_fk
FOREIGN KEY (genreid)
REFERENCES public.genres (genreid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.artist_track ADD CONSTRAINT artists_artist_track_fk
FOREIGN KEY (artistid)
REFERENCES public.artists (artistid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tracks ADD CONSTRAINT albums_tracks_fk
FOREIGN KEY (albumid)
REFERENCES public.albums (albumid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.invoicelines ADD CONSTRAINT tracks_invoicelines_fk
FOREIGN KEY (trackid)
REFERENCES public.tracks (trackid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.track_details ADD CONSTRAINT tracks_track_details_fk
FOREIGN KEY (trackid)
REFERENCES public.tracks (trackid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.artist_track ADD CONSTRAINT tracks_artist_track_fk
FOREIGN KEY (trackid)
REFERENCES public.tracks (trackid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;