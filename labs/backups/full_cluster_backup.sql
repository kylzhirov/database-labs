--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:+lQxtASJSHD7ldd4J/4y6g==$DlmLUCWgTcEl4CxveaWjl5iUOR10/UQWwxNYlHtJpWw=:NKaKcZeeC4lfT3TNbL7KWq7f2DymWlRtrtljtVb+qUE=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "new_database" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: new_database; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE new_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE new_database OWNER TO postgres;

\connect new_database

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    balance numeric(10,2)
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_account_id_seq OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_log (
    id integer NOT NULL,
    action text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.audit_log OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_log_id_seq OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: customer_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_feedback (
    id integer NOT NULL,
    customer_name text,
    feedback text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_feedback OWNER TO postgres;

--
-- Name: customer_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_feedback_id_seq OWNER TO postgres;

--
-- Name: customer_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_feedback_id_seq OWNED BY public.customer_feedback.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    name character varying(100),
    email character varying(100)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    department character varying(100),
    email character varying(100)
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    product_id integer NOT NULL,
    stock numeric(10,2)
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: inventory_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_product_id_seq OWNER TO postgres;

--
-- Name: inventory_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_product_id_seq OWNED BY public.inventory.product_id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    message character varying(100)
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: managers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.managers (
    manager_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    salary numeric(10,2)
);


ALTER TABLE public.managers OWNER TO postgres;

--
-- Name: managers_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.managers_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.managers_manager_id_seq OWNER TO postgres;

--
-- Name: managers_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.managers_manager_id_seq OWNED BY public.managers.manager_id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    order_date date,
    amount numeric(10,2),
    region_id integer,
    product_name character varying(100),
    customer_id integer,
    total integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: pg_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pg_locks (
    locktype text,
    pid integer,
    granted boolean
);


ALTER TABLE public.pg_locks OWNER TO postgres;

--
-- Name: pg_stat_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pg_stat_activity (
    pid integer NOT NULL,
    usename text,
    query text
);


ALTER TABLE public.pg_stat_activity OWNER TO postgres;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    product_name character varying(100),
    year integer,
    sales_amount numeric(10,2)
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: pivoted_sales; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pivoted_sales AS
 SELECT product_name,
    sum(
        CASE
            WHEN (year = 2022) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2022,
    sum(
        CASE
            WHEN (year = 2023) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2023,
    sum(
        CASE
            WHEN (year = 2024) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2024
   FROM public.sales
  GROUP BY product_name;


ALTER VIEW public.pivoted_sales OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    name character varying(100),
    price numeric(10,2)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: regional_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regional_sales (
    region_id integer NOT NULL,
    total_sales numeric(10,2)
);


ALTER TABLE public.regional_sales OWNER TO postgres;

--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regional_sales_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regional_sales_region_id_seq OWNER TO postgres;

--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regional_sales_region_id_seq OWNED BY public.regional_sales.region_id;


--
-- Name: sales_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_data (
    id integer NOT NULL,
    product_name text,
    quantity integer,
    price numeric(10,2),
    sale_date date
);


ALTER TABLE public.sales_data OWNER TO postgres;

--
-- Name: sales_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_data_id_seq OWNER TO postgres;

--
-- Name: sales_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_data_id_seq OWNED BY public.sales_data.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    faculty character varying(100),
    date_of_birth date
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    id integer NOT NULL,
    user_id integer NOT NULL,
    theme text NOT NULL
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_preferences_id_seq OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_preferences_id_seq OWNED BY public.user_preferences.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: warehouse_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_1 (
    product_name character varying(100),
    product_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.warehouse_1 OWNER TO postgres;

--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warehouse_1_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouse_1_product_id_seq OWNER TO postgres;

--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warehouse_1_product_id_seq OWNED BY public.warehouse_1.product_id;


--
-- Name: warehouse_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_2 (
    product_name character varying(100),
    product_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.warehouse_2 OWNER TO postgres;

--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warehouse_2_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouse_2_product_id_seq OWNER TO postgres;

--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warehouse_2_product_id_seq OWNED BY public.warehouse_2.product_id;


--
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: customer_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_feedback ALTER COLUMN id SET DEFAULT nextval('public.customer_feedback_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: inventory product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory ALTER COLUMN product_id SET DEFAULT nextval('public.inventory_product_id_seq'::regclass);


--
-- Name: managers manager_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers ALTER COLUMN manager_id SET DEFAULT nextval('public.managers_manager_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: regional_sales region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_sales ALTER COLUMN region_id SET DEFAULT nextval('public.regional_sales_region_id_seq'::regclass);


--
-- Name: sales_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_data ALTER COLUMN id SET DEFAULT nextval('public.sales_data_id_seq'::regclass);


--
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- Name: user_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN id SET DEFAULT nextval('public.user_preferences_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: warehouse_1 product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_1 ALTER COLUMN product_id SET DEFAULT nextval('public.warehouse_1_product_id_seq'::regclass);


--
-- Name: warehouse_2 product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_2 ALTER COLUMN product_id SET DEFAULT nextval('public.warehouse_2_product_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (account_id, balance) FROM stdin;
3	50.00
4	81.00
5	1300.00
9	700.00
10	800.00
11	2300.00
13	1150.00
12	0.00
14	0.00
6	1000.00
2	2100.00
1	1001900.00
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_log (id, action, "timestamp") FROM stdin;
1	user_creation	2025-09-22 19:47:26.954875+06
2	user_creation	2025-09-22 19:47:26.962954+06
\.


--
-- Data for Name: customer_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_feedback (id, customer_name, feedback, submitted_at) FROM stdin;
1	Smith, John	Great product	2025-09-24 19:24:30.765446
2	Alice "Allie" Brown	Great product	2025-09-24 19:24:30.765446
3	Bob Miller	Fast shipping, good support	2025-09-24 19:24:30.765446
4	Jane Doe	Fast shipping, good support	2025-09-24 19:24:30.765446
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, name, email) FROM stdin;
1	Alex	al1999@example.com
2	Edward	ed2000@example.com
8	Nathan	na1998@example.com
10	John Doe	john@email.com
11	Alice	alice@email.com
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, first_name, last_name, department, email) FROM stdin;
4	Farnk	Davis	\N	email@example.com
6	Alice	Jones	\N	da1234@example.com
3	first_name	last_name	IT	email
5	Emma	Davis	IT	lskadfj@example.com
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (product_id, stock) FROM stdin;
102	20.00
100	5.00
101	9.00
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (message) FROM stdin;
Starting process
Process completed
Starting process
Process completed
\.


--
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.managers (manager_id, first_name, last_name, salary) FROM stdin;
1	Artem	Semagin	300000.00
2	Viktor	Korneplod	0.00
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity) FROM stdin;
1	1	101	1
2	1	101	1
5	13	101	2
6	13	102	1
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, order_date, amount, region_id, product_name, customer_id, total) FROM stdin;
6	\N	\N	\N	\N	6	100
9	\N	\N	\N	\N	1	300
13	\N	\N	\N	\N	1	1000
\.


--
-- Data for Name: pg_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pg_locks (locktype, pid, granted) FROM stdin;
\.


--
-- Data for Name: pg_stat_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pg_stat_activity (pid, usename, query) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (name, price) FROM stdin;
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
\.


--
-- Data for Name: regional_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regional_sales (region_id, total_sales) FROM stdin;
1	123123.00
2	50000.00
3	50340.00
4	30300.00
5	4050050.00
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (product_name, year, sales_amount) FROM stdin;
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
\.


--
-- Data for Name: sales_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_data (id, product_name, quantity, price, sale_date) FROM stdin;
1	Widget A	10	19.99	2023-07-01
2	Gadget B	\N	29.95	2023-07-02
3	Tool C	5	\N	2023-07-03
4	Gadget B	2	29.95	\N
5	Widget A	\N	\N	\N
6	Widget A	10	19.99	2023-07-01
7	Gadget B	\N	29.95	2023-07-02
8	Tool C	5	\N	2023-07-03
9	Gadget B	2	29.95	\N
10	Widget A	\N	\N	\N
11	Widget A	10	19.99	2023-07-01
12	Gadget B	\N	29.95	2023-07-02
13	Tool C	5	\N	2023-07-03
14	Gadget B	2	29.95	\N
15	Widget A	\N	\N	\N
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, first_name, last_name, email, faculty, date_of_birth) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (id, user_id, theme) FROM stdin;
1	1	dark
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email) FROM stdin;
1	John Doe	john@example.com
\.


--
-- Data for Name: warehouse_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warehouse_1 (product_name, product_id, quantity) FROM stdin;
Keyboard	3	5
Monitor	4	3
Printer	5	0
Mouse	6	0
Priner	7	0
\.


--
-- Data for Name: warehouse_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warehouse_2 (product_name, product_id, quantity) FROM stdin;
Laptop	1	2
Mouse	2	0
Keyboard	3	8
Headphones	6	4
Webcam	7	0
Mouse	4	0
\.


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 14, true);


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 2, true);


--
-- Name: customer_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_feedback_id_seq', 4, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 11, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 6, true);


--
-- Name: inventory_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_product_id_seq', 1, false);


--
-- Name: managers_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.managers_manager_id_seq', 2, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 6, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 13, true);


--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regional_sales_region_id_seq', 5, true);


--
-- Name: sales_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_data_id_seq', 15, true);


--
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 1, false);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_preferences_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warehouse_1_product_id_seq', 1, false);


--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warehouse_2_product_id_seq', 1, false);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: customer_feedback customer_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_feedback
    ADD CONSTRAINT customer_feedback_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (product_id);


--
-- Name: managers managers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (manager_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: pg_stat_activity pg_stat_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pg_stat_activity
    ADD CONSTRAINT pg_stat_activity_pkey PRIMARY KEY (pid);


--
-- Name: regional_sales regional_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_sales
    ADD CONSTRAINT regional_sales_pkey PRIMARY KEY (region_id);


--
-- Name: sales_data sales_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_data
    ADD CONSTRAINT sales_data_pkey PRIMARY KEY (id);


--
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouse_1 warehouse_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_1
    ADD CONSTRAINT warehouse_1_pkey PRIMARY KEY (product_id);


--
-- Name: warehouse_2 warehouse_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_2
    ADD CONSTRAINT warehouse_2_pkey PRIMARY KEY (product_id);


--
-- Name: order_items fk_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES public.inventory(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_preferences user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    balance numeric(10,2)
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_account_id_seq OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_log (
    id integer NOT NULL,
    action text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.audit_log OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_log_id_seq OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: customer_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_feedback (
    id integer NOT NULL,
    customer_name text,
    feedback text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_feedback OWNER TO postgres;

--
-- Name: customer_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_feedback_id_seq OWNER TO postgres;

--
-- Name: customer_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_feedback_id_seq OWNED BY public.customer_feedback.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    name character varying(100),
    email character varying(100)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    department character varying(100),
    email character varying(100)
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    product_id integer NOT NULL,
    stock numeric(10,2)
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: inventory_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_product_id_seq OWNER TO postgres;

--
-- Name: inventory_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_product_id_seq OWNED BY public.inventory.product_id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    message character varying(100)
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: managers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.managers (
    manager_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    salary numeric(10,2)
);


ALTER TABLE public.managers OWNER TO postgres;

--
-- Name: managers_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.managers_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.managers_manager_id_seq OWNER TO postgres;

--
-- Name: managers_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.managers_manager_id_seq OWNED BY public.managers.manager_id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    order_date date,
    amount numeric(10,2),
    region_id integer,
    product_name character varying(100),
    customer_id integer,
    total integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: pg_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pg_locks (
    locktype text,
    pid integer,
    granted boolean
);


ALTER TABLE public.pg_locks OWNER TO postgres;

--
-- Name: pg_stat_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pg_stat_activity (
    pid integer NOT NULL,
    usename text,
    query text
);


ALTER TABLE public.pg_stat_activity OWNER TO postgres;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    product_name character varying(100),
    year integer,
    sales_amount numeric(10,2)
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: pivoted_sales; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pivoted_sales AS
 SELECT product_name,
    sum(
        CASE
            WHEN (year = 2022) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2022,
    sum(
        CASE
            WHEN (year = 2023) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2023,
    sum(
        CASE
            WHEN (year = 2024) THEN sales_amount
            ELSE (0)::numeric
        END) AS year_2024
   FROM public.sales
  GROUP BY product_name;


ALTER VIEW public.pivoted_sales OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    name character varying(100),
    price numeric(10,2)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: regional_sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regional_sales (
    region_id integer NOT NULL,
    total_sales numeric(10,2)
);


ALTER TABLE public.regional_sales OWNER TO postgres;

--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regional_sales_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regional_sales_region_id_seq OWNER TO postgres;

--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regional_sales_region_id_seq OWNED BY public.regional_sales.region_id;


--
-- Name: sales_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_data (
    id integer NOT NULL,
    product_name text,
    quantity integer,
    price numeric(10,2),
    sale_date date
);


ALTER TABLE public.sales_data OWNER TO postgres;

--
-- Name: sales_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_data_id_seq OWNER TO postgres;

--
-- Name: sales_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_data_id_seq OWNED BY public.sales_data.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    faculty character varying(100),
    date_of_birth date
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    id integer NOT NULL,
    user_id integer NOT NULL,
    theme text NOT NULL
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_preferences_id_seq OWNER TO postgres;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_preferences_id_seq OWNED BY public.user_preferences.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: warehouse_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_1 (
    product_name character varying(100),
    product_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.warehouse_1 OWNER TO postgres;

--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warehouse_1_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouse_1_product_id_seq OWNER TO postgres;

--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warehouse_1_product_id_seq OWNED BY public.warehouse_1.product_id;


--
-- Name: warehouse_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_2 (
    product_name character varying(100),
    product_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.warehouse_2 OWNER TO postgres;

--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warehouse_2_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warehouse_2_product_id_seq OWNER TO postgres;

--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warehouse_2_product_id_seq OWNED BY public.warehouse_2.product_id;


--
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: customer_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_feedback ALTER COLUMN id SET DEFAULT nextval('public.customer_feedback_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: inventory product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory ALTER COLUMN product_id SET DEFAULT nextval('public.inventory_product_id_seq'::regclass);


--
-- Name: managers manager_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers ALTER COLUMN manager_id SET DEFAULT nextval('public.managers_manager_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: regional_sales region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_sales ALTER COLUMN region_id SET DEFAULT nextval('public.regional_sales_region_id_seq'::regclass);


--
-- Name: sales_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_data ALTER COLUMN id SET DEFAULT nextval('public.sales_data_id_seq'::regclass);


--
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- Name: user_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN id SET DEFAULT nextval('public.user_preferences_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: warehouse_1 product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_1 ALTER COLUMN product_id SET DEFAULT nextval('public.warehouse_1_product_id_seq'::regclass);


--
-- Name: warehouse_2 product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_2 ALTER COLUMN product_id SET DEFAULT nextval('public.warehouse_2_product_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (account_id, balance) FROM stdin;
3	50.00
4	81.00
5	1300.00
9	700.00
10	800.00
11	2300.00
13	1150.00
12	0.00
14	0.00
6	1000.00
2	2100.00
1	1001900.00
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_log (id, action, "timestamp") FROM stdin;
1	user_creation	2025-09-22 19:47:26.954875+06
2	user_creation	2025-09-22 19:47:26.962954+06
\.


--
-- Data for Name: customer_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_feedback (id, customer_name, feedback, submitted_at) FROM stdin;
1	Smith, John	Great product	2025-09-24 19:24:30.765446
2	Alice "Allie" Brown	Great product	2025-09-24 19:24:30.765446
3	Bob Miller	Fast shipping, good support	2025-09-24 19:24:30.765446
4	Jane Doe	Fast shipping, good support	2025-09-24 19:24:30.765446
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, name, email) FROM stdin;
1	Alex	al1999@example.com
2	Edward	ed2000@example.com
8	Nathan	na1998@example.com
10	John Doe	john@email.com
11	Alice	alice@email.com
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, first_name, last_name, department, email) FROM stdin;
4	Farnk	Davis	\N	email@example.com
6	Alice	Jones	\N	da1234@example.com
3	first_name	last_name	IT	email
5	Emma	Davis	IT	lskadfj@example.com
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (product_id, stock) FROM stdin;
102	20.00
100	5.00
101	9.00
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (message) FROM stdin;
Starting process
Process completed
Starting process
Process completed
Starting process
Process completed
Starting process
Process completed
\.


--
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.managers (manager_id, first_name, last_name, salary) FROM stdin;
1	Artem	Semagin	300000.00
2	Viktor	Korneplod	0.00
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity) FROM stdin;
1	1	101	1
2	1	101	1
5	13	101	2
6	13	102	1
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, order_date, amount, region_id, product_name, customer_id, total) FROM stdin;
6	\N	\N	\N	\N	6	100
9	\N	\N	\N	\N	1	300
13	\N	\N	\N	\N	1	1000
\.


--
-- Data for Name: pg_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pg_locks (locktype, pid, granted) FROM stdin;
\.


--
-- Data for Name: pg_stat_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pg_stat_activity (pid, usename, query) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (name, price) FROM stdin;
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
Laptop	999.99
Mouse	25.99
Keyboard	79.99
\.


--
-- Data for Name: regional_sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regional_sales (region_id, total_sales) FROM stdin;
1	123123.00
2	50000.00
3	50340.00
4	30300.00
5	4050050.00
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (product_name, year, sales_amount) FROM stdin;
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
Laptop	2023	12000.00
Laptop	2024	15000.00
Mouse	2024	700.00
Keyboard	2022	800.00
\.


--
-- Data for Name: sales_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales_data (id, product_name, quantity, price, sale_date) FROM stdin;
1	Widget A	10	19.99	2023-07-01
2	Gadget B	\N	29.95	2023-07-02
3	Tool C	5	\N	2023-07-03
4	Gadget B	2	29.95	\N
5	Widget A	\N	\N	\N
6	Widget A	10	19.99	2023-07-01
7	Gadget B	\N	29.95	2023-07-02
8	Tool C	5	\N	2023-07-03
9	Gadget B	2	29.95	\N
10	Widget A	\N	\N	\N
11	Widget A	10	19.99	2023-07-01
12	Gadget B	\N	29.95	2023-07-02
13	Tool C	5	\N	2023-07-03
14	Gadget B	2	29.95	\N
15	Widget A	\N	\N	\N
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, first_name, last_name, email, faculty, date_of_birth) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (id, user_id, theme) FROM stdin;
1	1	dark
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email) FROM stdin;
1	John Doe	john@example.com
\.


--
-- Data for Name: warehouse_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warehouse_1 (product_name, product_id, quantity) FROM stdin;
Keyboard	3	5
Monitor	4	3
Printer	5	0
Mouse	6	0
Priner	7	0
\.


--
-- Data for Name: warehouse_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warehouse_2 (product_name, product_id, quantity) FROM stdin;
Laptop	1	2
Mouse	2	0
Keyboard	3	8
Headphones	6	4
Webcam	7	0
Mouse	4	0
\.


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 14, true);


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 2, true);


--
-- Name: customer_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_feedback_id_seq', 4, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 11, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 6, true);


--
-- Name: inventory_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_product_id_seq', 1, false);


--
-- Name: managers_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.managers_manager_id_seq', 2, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 6, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 13, true);


--
-- Name: regional_sales_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regional_sales_region_id_seq', 5, true);


--
-- Name: sales_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_data_id_seq', 15, true);


--
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 1, false);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_preferences_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: warehouse_1_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warehouse_1_product_id_seq', 1, false);


--
-- Name: warehouse_2_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warehouse_2_product_id_seq', 1, false);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: customer_feedback customer_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_feedback
    ADD CONSTRAINT customer_feedback_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (product_id);


--
-- Name: managers managers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (manager_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: pg_stat_activity pg_stat_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pg_stat_activity
    ADD CONSTRAINT pg_stat_activity_pkey PRIMARY KEY (pid);


--
-- Name: regional_sales regional_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regional_sales
    ADD CONSTRAINT regional_sales_pkey PRIMARY KEY (region_id);


--
-- Name: sales_data sales_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_data
    ADD CONSTRAINT sales_data_pkey PRIMARY KEY (id);


--
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouse_1 warehouse_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_1
    ADD CONSTRAINT warehouse_1_pkey PRIMARY KEY (product_id);


--
-- Name: warehouse_2 warehouse_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_2
    ADD CONSTRAINT warehouse_2_pkey PRIMARY KEY (product_id);


--
-- Name: order_items fk_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES public.inventory(product_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_preferences user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "university" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: university; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE university WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE university OWNER TO postgres;

\connect university

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course_enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_enrollments (
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    semester character varying(20) NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE,
    grade character(2)
);


ALTER TABLE public.course_enrollments OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    customer_name character varying(100),
    email character varying(150)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ALTER COLUMN customer_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    dept_id integer NOT NULL,
    dept_name character varying(100)
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_name character varying(100),
    order_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    price numeric(10,2)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: university_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.university_students (
    student_id integer NOT NULL,
    first_name text NOT NULL,
    last_name character varying(50) NOT NULL,
    email_address character varying(100) NOT NULL,
    faculty character varying(100),
    date_of_birth date
);


ALTER TABLE public.university_students OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.university_students.student_id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id bigint NOT NULL,
    amount numeric(15,2),
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- Name: university_students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- Data for Name: course_enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_enrollments (student_id, course_id, semester, enrollment_date, grade) FROM stdin;
1	101	2024-Spring	2025-09-01	A 
1	102	2024-Spring	2025-09-01	B+
2	101	2024-Spring	2025-09-01	A-
1	101	2024-Fall	2025-09-01	A+
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, customer_name, email) FROM stdin;
1000	VIP Customer	vip@example.com
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (dept_id, dept_name) FROM stdin;
1	Computer Science
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_name, order_date) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_name, price) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (transaction_id, amount, transaction_date) FROM stdin;
\.


--
-- Data for Name: university_students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.university_students (student_id, first_name, last_name, email_address, faculty, date_of_birth) FROM stdin;
\.


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 3, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 1, false);


--
-- Name: course_enrollments course_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_enrollments
    ADD CONSTRAINT course_enrollments_pkey PRIMARY KEY (student_id, course_id, semester);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: university_students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_students
    ADD CONSTRAINT students_email_key UNIQUE (email_address);


--
-- Name: university_students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: university_students unique_student_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.university_students
    ADD CONSTRAINT unique_student_email UNIQUE (email_address);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

