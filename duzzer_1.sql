--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE applications (
    id integer NOT NULL,
    name_person character varying(512) NOT NULL,
    apartment character varying(512) NOT NULL,
    cite character varying(512) NOT NULL,
    email character varying(512),
    phone character varying(512) NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    comment character varying(512),
    sort integer DEFAULT 0,
    street character varying(512) NOT NULL,
    surname character varying(512) NOT NULL,
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone,
    status integer DEFAULT 0 NOT NULL,
    seller_id integer,
    house character varying(512)
);


ALTER TABLE applications OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE applications_id_seq OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE applications_id_seq OWNED BY applications.id;


--
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE brand (
    id integer NOT NULL,
    cat integer,
    name character varying(512) NOT NULL,
    html_bottom text,
    html_top text,
    keywords character varying(512),
    active integer DEFAULT 1 NOT NULL,
    text text,
    title character varying(512),
    little_description character varying(512),
    sort integer DEFAULT 0,
    createdat timestamp without time zone,
    deletedat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE brand OWNER TO postgres;

--
-- Name: brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE brand_id_seq OWNER TO postgres;

--
-- Name: brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE brand_id_seq OWNED BY brand.id;


--
-- Name: characteristics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE characteristics (
    id integer NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    name character varying(512),
    system_name character varying(512),
    name_description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    cat_multi character varying(512),
    measure character varying(512),
    value character varying(512)
);


ALTER TABLE characteristics OWNER TO postgres;

--
-- Name: characteristics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE characteristics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE characteristics_id_seq OWNER TO postgres;

--
-- Name: characteristics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE characteristics_id_seq OWNED BY characteristics.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE files (
    id integer NOT NULL,
    name character varying(512),
    text text,
    title character varying(512),
    description text,
    keywords character varying(512),
    size character varying NOT NULL,
    orig_name character varying(128) NOT NULL,
    type character varying(128) NOT NULL,
    file character varying(128) NOT NULL,
    name_table character varying(32),
    crop text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id_album integer,
    active integer DEFAULT 1,
    sort integer,
    main integer
);


ALTER TABLE files OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE files_id_seq OWNER TO postgres;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE files_id_seq OWNED BY files.id;


--
-- Name: lang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lang (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    title character varying(512),
    little_description character varying(512),
    sort integer DEFAULT 0,
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE lang OWNER TO postgres;

--
-- Name: lang_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lang_id_seq OWNER TO postgres;

--
-- Name: lang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lang_id_seq OWNED BY lang.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE menu (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    sys_cat character varying(32),
    text text,
    active integer DEFAULT 1 NOT NULL,
    cat integer DEFAULT 0,
    title character varying(512),
    author character varying(128),
    keywords character varying(512),
    description character varying(512),
    sort integer DEFAULT 0,
    class character varying(32),
    controller character varying(32),
    album integer,
    fields_land integer,
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE menu OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu_id_seq OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE menu_id_seq OWNED BY menu.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orders (
    id integer NOT NULL,
    count integer NOT NULL,
    sum_price integer NOT NULL,
    current_price integer NOT NULL,
    current_discount integer NOT NULL,
    id_parent integer NOT NULL,
    id_applications integer NOT NULL,
    id_user integer,
    id_seller integer,
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: params; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE params (
    id integer NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    html_bottom text,
    html_top text,
    text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(512),
    system_name character varying(512)
);


ALTER TABLE params OWNER TO postgres;

--
-- Name: params_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE params_id_seq OWNER TO postgres;

--
-- Name: params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE params_id_seq OWNED BY params.id;


--
-- Name: playground; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE playground (
    equip_id integer NOT NULL,
    type character varying(50) NOT NULL,
    color character varying(25) NOT NULL,
    location character varying(25),
    install_date date,
    CONSTRAINT playground_location_check CHECK (((location)::text = ANY (ARRAY[('north'::character varying)::text, ('south'::character varying)::text, ('west'::character varying)::text, ('east'::character varying)::text, ('northeast'::character varying)::text, ('southeast'::character varying)::text, ('southwest'::character varying)::text, ('northwest'::character varying)::text])))
);


ALTER TABLE playground OWNER TO postgres;

--
-- Name: playground_equip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE playground_equip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE playground_equip_id_seq OWNER TO postgres;

--
-- Name: playground_equip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE playground_equip_id_seq OWNED BY playground.equip_id;


--
-- Name: power; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE power (
    id integer NOT NULL,
    id_user integer NOT NULL,
    id_menu character varying(32) NOT NULL,
    r integer NOT NULL,
    x integer NOT NULL,
    w integer NOT NULL,
    d integer NOT NULL,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone,
    "deletedAt" timestamp without time zone
);


ALTER TABLE power OWNER TO postgres;

--
-- Name: power_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE power_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE power_id_seq OWNER TO postgres;

--
-- Name: power_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE power_id_seq OWNED BY power.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    id integer NOT NULL,
    author character varying(64),
    name character varying(512) NOT NULL,
    html_bottom text,
    html_top text,
    keywords character varying(512),
    active integer DEFAULT 1 NOT NULL,
    cat integer,
    sort integer,
    tags character varying(512),
    text text,
    title character varying(512),
    to_main integer,
    description character varying(512),
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone,
    brand integer,
    discount integer,
    params json,
    price integer,
    vendor_code character varying(64),
    user_id integer,
    reviews text
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: seo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE seo (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    keywords character varying(512) NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    title character varying(512),
    description character varying(512),
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone,
    author character varying
);


ALTER TABLE seo OWNER TO postgres;

--
-- Name: seo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seo_id_seq OWNER TO postgres;

--
-- Name: seo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE seo_id_seq OWNED BY seo.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE statuses (
    id integer NOT NULL,
    parent_id integer NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    status integer DEFAULT 0,
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone,
    id_user integer
);


ALTER TABLE statuses OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE statuses_id_seq OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE statuses_id_seq OWNED BY statuses.id;


--
-- Name: str; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE str (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    html_bottom text,
    html_top text,
    keywords character varying(512),
    active integer DEFAULT 1 NOT NULL,
    cat integer,
    sort integer,
    tags character varying(512),
    text text,
    title character varying(512),
    to_main integer,
    description character varying(512),
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone,
    author character varying
);


ALTER TABLE str OWNER TO postgres;

--
-- Name: str_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE str_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE str_id_seq OWNER TO postgres;

--
-- Name: str_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE str_id_seq OWNED BY str.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tags (
    id integer NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    id_user integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100) DEFAULT NULL::character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    usertype text NOT NULL,
    text text NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    save_password character varying(32) NOT NULL,
    username character varying(32)[]
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: villas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE villas (
    author character varying(64),
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    html_bottom text,
    html_top text,
    keywords character varying(512),
    active integer DEFAULT 1 NOT NULL,
    cat integer,
    sort integer,
    tags character varying(512),
    text text,
    title character varying(512),
    to_main integer,
    description character varying(512),
    created_at timestamp without time zone,
    deleted_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE villas OWNER TO postgres;

--
-- Name: villas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE villas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE villas_id_seq OWNER TO postgres;

--
-- Name: villas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE villas_id_seq OWNED BY villas.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY applications ALTER COLUMN id SET DEFAULT nextval('applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY brand ALTER COLUMN id SET DEFAULT nextval('brand_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY characteristics ALTER COLUMN id SET DEFAULT nextval('characteristics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY files ALTER COLUMN id SET DEFAULT nextval('files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lang ALTER COLUMN id SET DEFAULT nextval('lang_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu ALTER COLUMN id SET DEFAULT nextval('menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY params ALTER COLUMN id SET DEFAULT nextval('params_id_seq'::regclass);


--
-- Name: equip_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playground ALTER COLUMN equip_id SET DEFAULT nextval('playground_equip_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY power ALTER COLUMN id SET DEFAULT nextval('power_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY seo ALTER COLUMN id SET DEFAULT nextval('seo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statuses ALTER COLUMN id SET DEFAULT nextval('statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY str ALTER COLUMN id SET DEFAULT nextval('str_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY villas ALTER COLUMN id SET DEFAULT nextval('villas_id_seq'::regclass);


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY applications (id, name_person, apartment, cite, email, phone, active, comment, sort, street, surname, created_at, deleted_at, updated_at, status, seller_id, house) FROM stdin;
12	Игорь	47	Волгоград	igorianru@gmail.com	+79375560973	1		0	Продольная, 47	Носачёв	2017-10-01 20:10:21.248	\N	\N	0	\N	\N
\.


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('applications_id_seq', 12, true);


--
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY brand (id, cat, name, html_bottom, html_top, keywords, active, text, title, little_description, sort, createdat, deletedat, updatedat) FROM stdin;
2	\N	Cona 2	\N	\N	Cona 2	1	Cona 2	Cona 2	Cona 2	0	2017-07-26 11:52:54	\N	\N
1	\N	Cona 1	\N	\N	Cona 1	1	Cona 1	Cona 1	Cona 1	0	2017-07-19 11:53:01	\N	\N
\.


--
-- Name: brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('brand_id_seq', 2, true);


--
-- Data for Name: characteristics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY characteristics (id, active, name, system_name, name_description, created_at, updated_at, cat_multi, measure, value) FROM stdin;
4	1	Цвет	color		\N	\N	\N		[{"col": 12, "type": "color", "name": "color", "name_p": "Цвет"}]
6	1	Расход	consumption_m2		\N	\N	\N	л на м²	[{"col": 12, "type": "input", "name": "consumption_m2", "name_p": "Расход"}]
7	1	Размер формы	form_size		\N	\N	3	мм	[\r\n\t{"col": 4, "type": "input", "name": "length", "name_p": "Длина"},\r\n\t{"col": 4, "type": "input", "name": "width", "name_p": "Ширина"},\r\n\t{"col": 4, "type": "input", "name": "height", "name_p": "Высота"}\r\n]
8	1	Выход камня	stone_outlet		\N	\N	3	м²	[{"col": 12, "type": "input", "name": "stone_outlet", "name_p": "Выход камня"}]
9	1	Размер камня	stone_size		\N	\N	3	см	[\r\n\t{"col": 6, "type": "input", "name": "length", "name_p": "Длина"},\r\n\t{"col": 6, "type": "input", "name": "width", "name_p": "Ширина"}\r\n]
11	1	Вес формы	form_weight		\N	\N	3	кг	[{"col": 12, "type": "input", "name": "form_weight", "name_p": "Вес формы"}]
5	1	Плотность концентрат	concentrate_density_m3		\N	\N	\N	г/см³	[{"col": 12, "type": "input", "name": "concentrate_density_m3", "name_p": "Плотность концентрата"}]
3	1	Размеры	dimensions_length_width	длина/ширина	\N	\N	\N	мм	[{"col":6,"type":"input","name":"length","name_p":"Длина"},{"col":6,"type":"input","name":"width","name_p":"Ширина"}]
10	1	Толщина камня	thickness_of_stone		\N	\N	["3","5"]	см	[{"col":12,"type":"input","name":"thickness_of_stone","name_p":"Толщина"}]
1	1	Вес	weight		\N	\N	["1","5"]	г	[{"col":12,"type":"input","name":"weight","name_p":"Вес, г"}]
2	1	Толщина	thickness		\N	\N	\N	мм	[{"col": 12, "type": "input", "name": "thickness", "name_p": "Толщина"}]
12	1	Вариантов текстур	var_textury_fdk	Сколько вариантов текстур можно получить с одной формы	\N	\N	3	шт	[{"col":12,"type":"input","name":"var_textury_fdk","name_p":"Вариантов текстур"}]
\.


--
-- Name: characteristics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('characteristics_id_seq', 14, true);


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY files (id, name, text, title, description, keywords, size, orig_name, type, file, name_table, crop, created_at, updated_at, id_album, active, sort, main) FROM stdin;
23	\N	\N	\N	\N	\N	96.0Ki	homer_simpson___06___simpsons_by_frasier_and_niles-d38uqts.jpg	jpg	07ece2eaa3871652cc29c5e91ece506ec9f29278.jpg	users	\N	\N	\N	1	1	\N	1
16	test	testtest	\N	\N	\N	79.3Ki	Simpsons fish.png	png	a89fe97ceb1656e1c04ee757cc50a8e5111aff2c.png	str	\N	\N	\N	1	1	\N	1
19	gbbkjk		\N	\N	\N	79.3Ki	Simpsons fish.png	png	81b117df9c20aac57fcc91ad751783db62ef3f67.png	villas_slider	\N	\N	\N	0	1	0	0
18	gbb		\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	20f0935454b0b170dd897900d9972cd27b178dfc.jpg	villas	\N	\N	\N	0	1	0	1
15	test info	test infotest info	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	89e2e4ec6d319d42975b2bb545f6bc139fe927f2.jpg	str	\N	\N	\N	1	1	\N	0
17	objFile	objFile	\N	\N	\N	869.3Ki	outer_space_planets_desktop_1680x1050_hd-wallpaper-641866.jpg	jpg	3cf1ced1ba6972e059055168f2b140cfcc3ca638.jpg	str	\N	\N	\N	1	1	1	0
21	\N	\N	\N	\N	\N	4.2Mi	4637357.jpeg	jpeg	4b7f468a009899e39b4369b9854741b0e3238ba2.jpeg	villas_slider	\N	\N	\N	0	1	\N	0
20	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	359080f4cadf5c893cc263053258e1dca6785a1c.png	villas_slider	\N	\N	\N	0	1	\N	1
22	\N	\N	\N	\N	\N	96.0Ki	homer_simpson___06___simpsons_by_frasier_and_niles-d38uqts.jpg	jpg	76bd820b07d96bafd22ff3bbd23188634bab8b37.jpg	users	\N	\N	\N	1	1	\N	0
46	\N	\N	\N	\N	\N	15.1Ki	screen_002.png	png	cb637f67c189c0bc4a85dc3961e70a2dbbc6fc70.png	products	\N	\N	\N	7	1	\N	1
40	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	7e98453e5a752869ab4aad7e52eb8a461522cc26.jpg	products	\N	\N	\N	5	1	\N	0
41	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	55fd6dff2d420f54819b3789467d4b42ec3afa9f.jpg	products	\N	\N	\N	5	1	\N	1
47	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	69a24a31eb86535012aa0bf84019b3398418ebed.jpg	main_page	\N	\N	\N	1	1	\N	0
43	\N	\N	\N	\N	\N	511.0Ki	0c99d0f667b6f5633f6841dceab8ef02.jpg	jpg	ad3e60ea373c24bdfb376e86a407288efb445b9c.jpg	products	\N	\N	\N	6	1	\N	1
48	\N	\N	\N	\N	\N	979.7Ki	1237477129_ph00528.jpg	jpg	9da86c9a6c6a050de6b8a750c75997f3d49f44f9.jpg	main_page	\N	\N	\N	1	1	\N	0
34	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	4792a14dd1bc9df3fe7863d7dfff975d9e6f5677.jpg	products	\N	\N	\N	2	1	\N	0
38	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	3feb3683d7414def04a5292e3b6d81f91b269ed4.png	products	\N	\N	\N	4	1	\N	1
39	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	a861d906834010e4f7363b25ec2428cfaef0f491.jpg	products	\N	\N	\N	4	1	\N	0
44	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	46b25be979c3128031907b9675586a70c18ea2d1.jpg	products	\N	\N	\N	2	1	\N	1
35	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	3847af709814231f82f08d16c8424321b7002e74.png	products	\N	\N	\N	3	1	\N	0
37	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	2bba2ba0a76d734ac81772d24174f6be0e2515c0.jpg	products	\N	\N	\N	3	1	\N	0
36	\N	\N	\N	\N	\N	979.7Ki	1237477129_ph00528.jpg	jpg	fd6c5ea1fab7ac146699f9b0edb3c43c08c734a5.jpg	products	\N	\N	\N	3	1	\N	0
45	\N	\N	\N	\N	\N	4.2Mi	4637357.jpeg	jpeg	bc0d5804d6b7adc7f899c84db00d700882dec33c.jpeg	products	\N	\N	\N	3	1	\N	1
49	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	2b34511afb992ea751afd21cd8d3fedc4c05948f.jpg	products	\N	\N	\N	22	1	\N	1
62	\N	\N	\N	\N	\N	406.4Ki	kislotni-krasitel-cherny.jpg	jpg	4465fa7bd026d549b9811dc11818c1291a303e2c.jpg	products	\N	\N	\N	26	1	\N	1
56	\N	\N	\N	\N	\N	491.1Ki	S_R_F.JPG	JPG	d667b1cb1a2f704a0e2069e8b7d9bd9973ea7a1a.JPG	products	\N	\N	\N	23	1	\N	0
52	\N	\N	\N	\N	\N	501.2Ki	S_N_GS.JPG	JPG	e7072d963b72580a318509df36233194e608c8d8.JPG	products	\N	\N	\N	24	1	\N	0
51	\N	\N	\N	\N	\N	387.4Ki	S_N_GS-s.JPG	JPG	56776ea4b6ef963fb9d91fd15c946ac01124bfd1.JPG	products	\N	\N	\N	24	1	\N	1
24	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	ea10461af97a98edc57d310af1c84b4ec560d6ae.png	users	\N	\N	\N	18	1	\N	0
25	\N	\N	\N	\N	\N	96.0Ki	homer_simpson___06___simpsons_by_frasier_and_niles-d38uqts.jpg	jpg	346bf70a172886552a6b1ea4cd5c16fa0394d8bb.jpg	users	\N	\N	\N	18	1	\N	1
53	\N	\N	\N	\N	\N	496.4Ki	S_N_F.JPG	JPG	d6b5417180c11b2850251969a3682613337cc028.JPG	products	\N	\N	\N	25	1	\N	0
54	\N	\N	\N	\N	\N	446.0Ki	S_N_F-s.JPG	JPG	e57313c36949017e3942b9542c91e13373c3b5a3.JPG	products	\N	\N	\N	25	1	\N	1
55	\N	\N	\N	\N	\N	445.0Ki	S_R_F-s.JPG	JPG	ec709a3f1bc168ee435c81dddf2b3c90daf73a3b.JPG	products	\N	\N	\N	23	1	\N	1
63	\N	\N	\N	\N	\N	78.8Ki	kislotny-krasitel-krasny3.jpg	jpg	e820be045dc5942695b8d0a91c5efbd5a282b08e.jpg	products	\N	\N	\N	27	1	\N	0
64	\N	\N	\N	\N	\N	137.7Ki	kislotny-krasitel-krasny1.jpg	jpg	549671b300d86069385ae504cb1e15d49fdea0e4.jpg	products	\N	\N	\N	27	1	\N	0
26	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	370f3c7fa4509e0e2126351328abcc30ff117e0e.png	str	\N	\N	\N	2	1	\N	1
65	\N	\N	\N	\N	\N	168.8Ki	kislotny-krasitel-krasny2.jpg	jpg	7cc87e71a7a77a363224111c875a3b3dc78e6d17.jpg	products	\N	\N	\N	27	1	\N	0
57	\N	\N	\N	\N	\N	406.4Ki	kislotni-krasitel-cherny3.jpg	jpg	5c969286746f36516f66f5cbc4ac06dd799f1657.jpg	products	\N	\N	\N	26	1	\N	0
59	\N	\N	\N	\N	\N	111.3Ki	kislotni-krasitel-cherny2.jpg	jpg	e5af2c8fb8f13cee6325f71f2e6435d409d60c0d.jpg	products	\N	\N	\N	26	1	\N	0
60	\N	\N	\N	\N	\N	112.6Ki	kislotni-krasitel-cherny4.jpg	jpg	07cbb8995e0d118c46430d27ee71b6074a32f80a.jpg	products	\N	\N	\N	26	1	\N	0
61	\N	\N	\N	\N	\N	284.9Ki	kislotni-krasitel-cherny1.jpg	jpg	db0e87cc062718823c1efe1cd3dfac1d5d8f2eb6.jpg	products	\N	\N	\N	26	1	\N	0
66	\N	\N	\N	\N	\N	406.4Ki	kislotni-krasitel-cherny.jpg	jpg	e2a97b178e14cd54fe67a7ac3ac01dc1fb2c5137.jpg	products	\N	\N	\N	27	1	\N	1
67	\N	\N	\N	\N	\N	61.0Ki	kislotny-krasitel-korichnevy2.jpg	jpg	3bda86e325b53eba6fd1f52c03d50948f84a4c00.jpg	products	\N	\N	\N	28	1	\N	0
68	\N	\N	\N	\N	\N	118.1Ki	kislotny-krasitel-korichnevy1.jpg	jpg	311b7101658f2bb382ffbc5d4aa2b24dbaf6dabc.jpg	products	\N	\N	\N	28	1	\N	0
71	\N	\N	\N	\N	\N	36.3Ki	kislotny-krasitel-zeleny1.jpg	jpg	0ecf48e1630b5e443bb419d7ea19bb32a4f5c893.jpg	products	\N	\N	\N	30	1	\N	0
72	\N	\N	\N	\N	\N	151.6Ki	kislotny-krasitel-zeleny2.jpg	jpg	059e17d986bca271095bd9c8039bcf98ccdb2170.jpg	products	\N	\N	\N	30	1	\N	0
31	\N	\N	\N	\N	\N	869.3Ki	outer_space_planets_desktop_1680x1050_hd-wallpaper-641866.jpg	jpg	fca122e7dc019cbaefb1c60d130c49a546c03ced.jpg	products	\N	\N	\N	1	1	\N	0
96	\N	\N	\N	\N	\N	316.0Ki	M_10-15_70-30_F-s.JPG	JPG	8df7fd3bbb420ff6996feb87896ec1c66f98643b.JPG	products	\N	\N	\N	43	1	\N	1
85	\N	\N	\N	\N	\N	416.9Ki	S_G_F-s.JPG	JPG	56f5ee9ef7c4bb7ca0baeda76d9834dd5fcd09f1.JPG	products	\N	\N	\N	35	1	\N	1
70	\N	\N	\N	\N	\N	406.4Ki	kislotny-krasitel-jelty.jpg	jpg	f8150bf329429c41940f3003ebc8e563b02e1ab5.jpg	products	\N	\N	\N	29	1	\N	1
73	\N	\N	\N	\N	\N	406.4Ki	kislotny-krasitel-zeleny.jpg	jpg	a18d025b36713ab15aca6d8ff932f0e56c29aeb6.jpg	products	\N	\N	\N	30	1	\N	1
74	\N	\N	\N	\N	\N	272.8Ki	kislotni-krasitel-siny2.jpg	jpg	91c00e828b6ecdae0b3a5b5fa21a58783ea30320.jpg	products	\N	\N	\N	31	1	\N	0
75	\N	\N	\N	\N	\N	35.9Ki	kislotni-krasitel-siny1.jpg	jpg	cb730dc4dbc8447304e151cd60e72ea3bc550371.jpg	products	\N	\N	\N	31	1	\N	0
76	\N	\N	\N	\N	\N	406.4Ki	kislotni-krasitel-siny.jpg	jpg	4b8901a2e7fc0fbb787b372f6fc3a02ea56c1cc0.jpg	products	\N	\N	\N	31	1	\N	1
33	\N	\N	\N	\N	\N	4.2Mi	4637357.jpeg	jpeg	9acad47c57501e1f90a45c7c5801719138f0e7ff.jpeg	products	\N	\N	\N	1	1	\N	0
42	тест	тест	\N	\N	\N	79.3Ki	Simpsons fish.png	png	ebee885330ea7f15350ae8f69cb0e3c0868ee29b.png	products	\N	\N	\N	1	1	0	0
30	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	b5ade7f7f5f72228c3c6fc206b53e0773e9d0bb7.jpg	products	\N	\N	\N	1	1	\N	0
32	\N	\N	\N	\N	\N	79.3Ki	Simpsons fish.png	png	3bff88a2e676175c36d1bdcd70f13eb19c99220d.png	products	\N	\N	\N	1	1	\N	1
77	\N	\N	\N	\N	\N	524.7Ki	S_R_GS.JPG	JPG	a182ad64e9a2dd46c5ea812c6adc9867020f6161.JPG	products	\N	\N	\N	32	1	\N	0
97	\N	\N	\N	\N	\N	191.3Ki	M_10-15_60-40_F.JPG	JPG	b5372c672a0f388dea6b38f757a6f1b537cde062.JPG	products	\N	\N	\N	44	1	\N	0
78	\N	\N	\N	\N	\N	387.6Ki	S_R_GS-s.JPG	JPG	daa24870d382ff2b754e52a799bd79b05d991f15.JPG	products	\N	\N	\N	32	1	\N	1
79	\N	\N	\N	\N	\N	50.5Ki	krasitel-main.jpg	jpg	db2ca91e75c2dece4601b957c0805df84ddb43d7.jpg	main_page	\N	\N	\N	1	1	\N	0
86	\N	\N	\N	\N	\N	460.3Ki	S_G_GS.JPG	JPG	b8f3d4726f57405f726dc39a71c1e9dcaa81f4c2.JPG	products	\N	\N	\N	36	1	\N	0
87	\N	\N	\N	\N	\N	361.7Ki	S_G_GS-s.JPG	JPG	243cfc749d6a7a7cb53cabb392351e2c216dd023.JPG	products	\N	\N	\N	36	1	\N	1
98	\N	\N	\N	\N	\N	341.9Ki	M_10-15_60-40_F-s.JPG	JPG	6857d7ae271e21752cf11464ec0f8915c475cbd8.JPG	products	\N	\N	\N	44	1	\N	1
81	\N	\N	\N	\N	\N	225.0Ki	S_B_F.JPG	JPG	1ff67115b24a7a750b30615c1de8314d309a0ce3.JPG	products	\N	\N	\N	33	1	\N	0
80	\N	\N	\N	\N	\N	422.8Ki	S_B_F-s.JPG	JPG	0d757c7f3f9daccfbaa968291d7d3ad5daf467d7.JPG	products	\N	\N	\N	33	1	\N	1
82	\N	\N	\N	\N	\N	230.6Ki	S_B_GS.JPG	JPG	b4c2059f3665092976180f36f7a02a5eb145dfb0.JPG	products	\N	\N	\N	34	1	\N	0
83	\N	\N	\N	\N	\N	376.0Ki	S_B_GS-s.JPG	JPG	7ff557905a313c261c6c828fa2b14b016ef21189.JPG	products	\N	\N	\N	34	1	\N	1
88	\N	\N	\N	\N	\N	224.8Ki	S_Y_GS.JPG	JPG	344c11b7383210327cccf6ce777eb22f09dda17d.JPG	products	\N	\N	\N	37	1	\N	0
99	\N	\N	\N	\N	\N	358.4Ki	M_10-15_80-20_F.JPG	JPG	f6d99b3e9d43c1e263b4f6c7fb98081702f320bf.JPG	products	\N	\N	\N	45	1	\N	0
89	\N	\N	\N	\N	\N	420.4Ki	S_Y_GS-s.JPG	JPG	82e2c57a6ca577397167fd0e3f534a2febcb8a09.JPG	products	\N	\N	\N	37	1	\N	1
109	\N	\N	\N	\N	\N	348.3Ki	M_10-15_70-30_GS-s.JPG	JPG	040530dbdd3a2848fd0b3aa34965f46422cf9268.JPG	products	\N	\N	\N	50	1	\N	1
84	\N	\N	\N	\N	\N	228.6Ki	S_G_F.JPG	JPG	6c16d330306484a7680790c299da0217b658e50d.JPG	products	\N	\N	\N	35	1	\N	0
100	\N	\N	\N	\N	\N	285.7Ki	M_10-15_80-20_F-s.JPG	JPG	b98b02ed19e1543c346d4935c0acf228dfdb4c89.JPG	products	\N	\N	\N	45	1	\N	1
90	\N	\N	\N	\N	\N	238.5Ki	S_Y_F.JPG	JPG	f5920af6a5421d8803ec4ab7816df3cfdcdc7913.JPG	products	\N	\N	\N	38	1	\N	0
91	\N	\N	\N	\N	\N	520.5Ki	S_Y_F-s.JPG	JPG	1a3828d2349dc4582285c2c311165c75d6874c37.JPG	products	\N	\N	\N	38	1	\N	1
69	\N	\N	\N	\N	\N	406.4Ki	kislotny-krasitel-korichnevy.jpg	jpg	9f1add374a4f850e244b6f38f795459d813b3b8d.jpg	products	\N	\N	\N	28	1	\N	1
92	\N	\N	\N	\N	\N	346.1Ki	wheat-field_1600x1200.jpg	jpg	27f22dddc46729c79f6d1b056db12402182c0b97.jpg	products	\N	\N	\N	41	1	\N	1
93	\N	\N	\N	\N	\N	450.4Ki	M_10-15_50-50_F.JPG	JPG	2de7dd58123d597ea08b65588632c8901298846f.JPG	products	\N	\N	\N	42	1	\N	0
101	\N	\N	\N	\N	\N	151.0Ki	M_10-15_90-10_F.JPG	JPG	7d1c11deda2eb8bfcb7506434e13447e09934f9c.JPG	products	\N	\N	\N	46	1	\N	0
94	\N	\N	\N	\N	\N	378.0Ki	M_10-15_50-50_F-s.JPG	JPG	88fb19664d4712167c529008eb91e5ce6f6d732b.JPG	products	\N	\N	\N	42	1	\N	1
95	\N	\N	\N	\N	\N	179.7Ki	M_10-15_70-30_F.JPG	JPG	5c5ca2930d74e30c5eb365eb2d56f1f5dd2255ed.JPG	products	\N	\N	\N	43	1	\N	0
105	\N	\N	\N	\N	\N	182.1Ki	M_10-15_50-50_GS.JPG	JPG	d1991f62154d5ae160c7812502c466d802ee68ce.JPG	products	\N	\N	\N	48	1	\N	0
106	\N	\N	\N	\N	\N	351.8Ki	M_10-15_50-50_GS-s.JPG	JPG	582b52b85836d5a16059e59cea6fb9e01ff57f64.JPG	products	\N	\N	\N	48	1	\N	1
102	\N	\N	\N	\N	\N	253.4Ki	M_10-15_90-10_F-s.JPG	JPG	29be03d9af16c4d2cc008179f43f2cb545bb2ca3.JPG	products	\N	\N	\N	46	1	\N	1
103	\N	\N	\N	\N	\N	294.0Ki	M_10-15_95-5_F.JPG	JPG	08c69fefaad0179213c55b6a356c77cccb6bc867.JPG	products	\N	\N	\N	47	1	\N	0
104	\N	\N	\N	\N	\N	200.9Ki	M_10-15_95-5_F-s.JPG	JPG	d083963939349e0dce33fc5dc9dcb0034ef26766.JPG	products	\N	\N	\N	47	1	\N	1
107	\N	\N	\N	\N	\N	189.7Ki	M_10-15_70-30_GS.JPG	JPG	030b97fc2cb52c41b5608cdac1791eb7f31e4ffd.JPG	products	\N	\N	\N	49	1	\N	0
108	\N	\N	\N	\N	\N	354.4Ki	M_10-15_60-40_GS-s.JPG	JPG	114a7684523847116b4beffe6c3d858d66b6031c.JPG	products	\N	\N	\N	49	1	\N	1
113	\N	\N	\N	\N	\N	154.1Ki	M_10-15_90-10_ GS.JPG	JPG	46e704ac02a492a4bcc42a185bfa9e561b2a7b1b.JPG	products	\N	\N	\N	52	1	\N	0
110	\N	\N	\N	\N	\N	189.7Ki	M_10-15_70-30_GS.JPG	JPG	8e45260084c42024866c47994b92d4804fc2d178.JPG	products	\N	\N	\N	50	1	\N	0
112	\N	\N	\N	\N	\N	410.0Ki	M_10-15_80-20_GS.JPG	JPG	c34c5d2fd71f6f1f6abbf17862e01b86a2b9a78b.JPG	products	\N	\N	\N	51	1	\N	0
111	\N	\N	\N	\N	\N	333.8Ki	M_10-15_80-20_GS-s.JPG	JPG	6336e5fdba97fdb1ff6e4fd4dd36960e10db13a5.JPG	products	\N	\N	\N	51	1	\N	1
114	\N	\N	\N	\N	\N	269.9Ki	M_10-15_90-10_ GS-s.JPG	JPG	ed896b65026142791bb7a01d9449ef54e9e6f7b3.JPG	products	\N	\N	\N	52	1	\N	1
115	\N	\N	\N	\N	\N	149.2Ki	M_10-15_95-5_GS.JPG	JPG	536376248d420313ba77db47c3d53f0f19ac8652.JPG	products	\N	\N	\N	53	1	\N	0
116	\N	\N	\N	\N	\N	247.8Ki	M_10-15_95-5_GS-s.JPG	JPG	6a4c65ce59b47065383632ee1b6547a00c313ff2.JPG	products	\N	\N	\N	53	1	\N	1
117	\N	\N	\N	\N	\N	302.4Ki	M_05-10_80-20_F.JPG	JPG	b243af1c8a6ae81fa6ce37666ba5b1ab68f91af5.JPG	products	\N	\N	\N	54	1	\N	0
118	\N	\N	\N	\N	\N	241.6Ki	M_05-10_80-20_F-s.JPG	JPG	166ce8fe5afe076ec3320eb43a66b6de8591833b.JPG	products	\N	\N	\N	54	1	\N	1
119	\N	\N	\N	\N	\N	177.1Ki	M_05-10_70-30_F.JPG	JPG	26564fcfbba4c2cf67da2da2334b9589df837d2c.JPG	products	\N	\N	\N	55	1	\N	0
120	\N	\N	\N	\N	\N	296.1Ki	M_05-10_70-30_F-s.JPG	JPG	486d0381f24fadf414203f5352ba2dc67bc7adea.JPG	products	\N	\N	\N	55	1	\N	1
121	\N	\N	\N	\N	\N	187.2Ki	M_05-10_60-40_F.JPG	JPG	18f2091597b3bc34824003b31479c2f98a649e96.JPG	products	\N	\N	\N	56	1	\N	0
122	\N	\N	\N	\N	\N	324.8Ki	M_05-10_60-40_F-s.JPG	JPG	0f94036b552776e2141c2268910352c9b0fccea6.JPG	products	\N	\N	\N	56	1	\N	1
128	\N	\N	\N	\N	\N	246.6Ki	M_05-10_95-5_F.JPG	JPG	d19f6a393bc1957b63eabd764102c79468689759.JPG	products	\N	\N	\N	59	1	\N	0
130	\N	\N	\N	\N	\N	436.5Ki	M_05-10_50-50_GS.JPG	JPG	c7e1398f5a403dff6d1dc28ef98010512d42590f.JPG	products	\N	\N	\N	60	1	\N	0
129	\N	\N	\N	\N	\N	331.0Ki	M_05-10_50-50_GS-s.JPG	JPG	fbcea81b4bbe238a0934b68fedd93916cc0ea025.JPG	products	\N	\N	\N	60	1	\N	1
123	\N	\N	\N	\N	\N	446.6Ki	M_05-10_50-50_F.JPG	JPG	52dbdd1c98b95882e8256c1761214671541cee48.JPG	products	\N	\N	\N	57	1	\N	0
124	\N	\N	\N	\N	\N	353.1Ki	M_05-10_50-50_F-s.JPG	JPG	56c39992e023cf6624466ac155087ff1cc052bf9.JPG	products	\N	\N	\N	57	1	\N	1
125	\N	\N	\N	\N	\N	284.5Ki	M_05-10_90-10_F.JPG	JPG	47039aa08f29e2cc7eef742b57478e70648db075.JPG	products	\N	\N	\N	58	1	\N	0
126	\N	\N	\N	\N	\N	213.7Ki	M_05-10_90-10_F-s.JPG	JPG	563f0c9f68ecf8437bf6adde983a1203df550537.JPG	products	\N	\N	\N	58	1	\N	1
127	\N	\N	\N	\N	\N	181.7Ki	M_05-10_95-5_F-s.JPG	JPG	894454519ae47c93fb9d8eefb0ccb49a294fa95d.JPG	products	\N	\N	\N	59	1	\N	1
141	\N	\N	\N	\N	\N	55.8Ki	gal2-1.jpg	jpg	9907153b23ba63199a268c2d16b01569b2a29216.jpg	main_page	\N	\N	\N	1	1	\N	0
332	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	cc7ac2ca2e84bc0c1d4ee6f546be7b140d8aa916.jpg	products	\N	\N	\N	79	1	\N	0
333	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	75c0f4510061b68bb1943b76c76282b197b79faa.jpg	products	\N	\N	\N	79	1	\N	0
334	\N	\N	\N	\N	\N	305.3Ki	pm630c.jpg	jpg	b4e12681ee8c21f3d236459cfc36e02fd2a7551e.jpg	products	\N	\N	\N	78	1	\N	1
335	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	bacc338a3341579c8b19067be132647549ea0141.jpg	products	\N	\N	\N	78	1	\N	0
336	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	e387f31a492b8b6869bbf2432cd7a567969c71df.jpg	products	\N	\N	\N	78	1	\N	0
360	\N	\N	\N	\N	\N	142.9Ki	M_05-10_90-10_GS.JPG	JPG	6a74e35b44f0992805ce4e5d3d396f30ed8fc3d0.JPG	products	\N	\N	\N	64	1	\N	0
337	\N	\N	\N	\N	\N	313.0Ki	pm630b.jpg	jpg	30fd7008447a1d3fe3b06bd7b0e1e62f2e1e7b8e.jpg	products	\N	\N	\N	77	1	\N	1
359	\N	\N	\N	\N	\N	234.7Ki	M_05-10_90-10_GS-s.JPG	JPG	79c4d50457d12756ba2e39dfe6d4da119fb68c71.JPG	products	\N	\N	\N	64	1	\N	1
338	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	764f1dfc786e4225316dbc63263855870f0595f8.jpg	products	\N	\N	\N	77	1	\N	0
370	\N	\N	\N	\N	\N	709.0Ki	571.jpg	jpg	9a9eba81714052133d2d994bceda340d3b22046a.jpg	products	\N	\N	\N	110	1	\N	1
339	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	2d3c35c819e008bd8951a39fa0fa648207eae255.jpg	products	\N	\N	\N	77	1	\N	0
340	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	9bc1d0d445b05fb326c1d00e826960de6cb1f2fe.jpg	products	\N	\N	\N	76	1	\N	0
378	\N	\N	\N	\N	\N	55.8Ki	gal2-1.jpg	jpg	0686199967082cfa2658a32b383b9f7ae8468efb.jpg	main_page	\N	\N	\N	1	1	\N	0
341	\N	\N	\N	\N	\N	280.5Ki	pm630a.jpg	jpg	94b6c400b8768cfe51036f1838f5c67ef95e4628.jpg	products	\N	\N	\N	76	1	\N	1
171	\N	\N	\N	\N	\N	283.6Ki	stone-form-main.jpg	jpg	d8081b2e29eb2e2ab8b117b3a94c62f0b78e3728.jpg	main_page	\N	\N	\N	1	1	\N	0
172	\N	\N	\N	\N	\N	184.7Ki	stone-form-main1.jpg	jpg	dc4806ceb761107ec6ace7062e52a757fcce5a7f.jpg	main_page	\N	\N	\N	1	1	\N	0
342	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	ad9f9c6034935c5b8488af16ca4fbcbb13f865a0.jpg	products	\N	\N	\N	76	1	\N	0
385	\N	\N	\N	\N	\N	33.1Ki	sten-pan-ton.jpg	jpg	aa7778a7b2110262019f9a1c53d2a8b9a1f8765d.jpg	main_page	\N	\N	\N	1	1	\N	0
191	\N	\N	\N	\N	\N	373.0Ki	dostavka_555.jpg	jpg	e0bc8be0a14b683c66f1df9c79a922fef11ba75f.jpg	main_page	\N	\N	\N	1	1	\N	0
192	\N	\N	\N	\N	\N	337.8Ki	a3.jpg	jpg	895962673aa75e368569078b98ecda4fa639a8bf.jpg	main_page	\N	\N	\N	1	1	\N	0
193	\N	\N	\N	\N	\N	43.0Ki	dostavka_main.jpg	jpg	036aa8733c7821e98f617db5b3d58714df64c859.jpg	main_page	\N	\N	\N	1	1	\N	0
343	\N	\N	\N	\N	\N	1007.8Ki	pm620.jpg	jpg	68efc6cbb1e6d79e28ec47ab0d28fa9ea98df528.jpg	products	\N	\N	\N	75	1	\N	0
344	\N	\N	\N	\N	\N	257.3Ki	pm620l.jpg	jpg	2cbd0247f5e267772d7bb2e793d2483324bdada9.jpg	products	\N	\N	\N	75	1	\N	0
345	\N	\N	\N	\N	\N	229.9Ki	pm620d.jpg	jpg	72a3bfc1b3aa577c76c3baf1a8d34f792ef6db86.jpg	products	\N	\N	\N	75	1	\N	1
346	\N	\N	\N	\N	\N	1007.8Ki	pm620.jpg	jpg	1c58acf0d47bfc7cc6a12567a279299f7e7b0d75.jpg	products	\N	\N	\N	73	1	\N	0
347	\N	\N	\N	\N	\N	257.3Ki	pm620l.jpg	jpg	dca07ff195bd9a2b66853348e43f17f8c01b55b2.jpg	products	\N	\N	\N	73	1	\N	0
348	\N	\N	\N	\N	\N	249.6Ki	pm620c.jpg	jpg	038817c452cd9f18d85dc643a183b347f0a3fe02.jpg	products	\N	\N	\N	73	1	\N	1
363	\N	\N	\N	\N	\N	400.4Ki	M_05-10_70-30_GS.JPG	JPG	2367be88293d859fa26ca1caf29629729851448d.JPG	products	\N	\N	\N	62	1	\N	0
364	\N	\N	\N	\N	\N	297.8Ki	M_05-10_70-30_GS-s.JPG	JPG	2e083bae070bc070ad246b040bf0605397dfd796.JPG	products	\N	\N	\N	62	1	\N	1
379	\N	\N	\N	\N	\N	400.7Ki	300-0.jpg	jpg	adb9f60a5ac5cb2fdd5ea5bbeb2676cc94bd484d.jpg	main_page	\N	\N	\N	1	1	\N	0
381	\N	\N	\N	\N	\N	27.6Ki	dostavka-ton.jpg	jpg	5bb965fd1b4dda5bc9710698b540add969bbef67.jpg	main_page	\N	\N	\N	1	1	\N	0
246	\N	\N	\N	\N	\N	511.9Ki	571-2.jpg	jpg	728593e8d188a42dd10752e2a4e1b37781f892b5.jpg	products	\N	\N	\N	107	1	\N	1
247	\N	\N	\N	\N	\N	526.5Ki	570-11.jpg	jpg	b4abfb211810cc14a8a70f127894b541d466cb7d.jpg	products	\N	\N	\N	107	1	\N	1
248	\N	\N	\N	\N	\N	709.0Ki	571.jpg	jpg	772cbd8066cb2e1a1255cd986382cf30aab225f9.jpg	products	\N	\N	\N	107	1	\N	1
249	\N	\N	\N	\N	\N	658.1Ki	571-1.jpg	jpg	c532fa2db62597f9602283a5abc5897945ff638e.jpg	products	\N	\N	\N	107	1	\N	1
349	\N	\N	\N	\N	\N	1007.8Ki	pm620.jpg	jpg	77fa7c29b5d6a0d870755024117051dc1474b917.jpg	products	\N	\N	\N	71	1	\N	0
350	\N	\N	\N	\N	\N	257.3Ki	pm620l.jpg	jpg	fcb568178bc24a8c9768a0968e5f760ecf1ae7d9.jpg	products	\N	\N	\N	71	1	\N	0
351	\N	\N	\N	\N	\N	276.7Ki	pm620b.jpg	jpg	7acee8123fd479f5e12ed700d749c1bad2094f05.jpg	products	\N	\N	\N	71	1	\N	1
352	\N	\N	\N	\N	\N	1007.8Ki	pm620.jpg	jpg	ff96cdefbcbf830d4d0f51953c7d4ce4a4fa4934.jpg	products	\N	\N	\N	70	1	\N	0
353	\N	\N	\N	\N	\N	257.3Ki	pm620l.jpg	jpg	13e003d074b65a320a63d5c5966b7d658376703c.jpg	products	\N	\N	\N	70	1	\N	0
354	\N	\N	\N	\N	\N	259.2Ki	pm620a.jpg	jpg	5083d3af465068f0ba419a39bb08592f9fa953af.jpg	products	\N	\N	\N	70	1	\N	1
361	\N	\N	\N	\N	\N	278.5Ki	M_05-10_80-20_GS-s.JPG	JPG	f443960694d145403e4907d4f87627fceb9b91d7.JPG	products	\N	\N	\N	63	1	\N	1
367	\N	\N	\N	\N	\N	526.5Ki	570-11.jpg	jpg	15093a3dd69bbcf82178cca5b2bafddebde728d4.jpg	products	\N	\N	\N	110	1	\N	0
380	\N	\N	\N	\N	\N	184.7Ki	stone-form-main1.jpg	jpg	5d53e30a56469324a7acdfecf4715b6224f0ced2.jpg	main_page	\N	\N	\N	1	1	\N	0
278	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	8e72b36204e88fee2ef66efb61396834a4538696.jpg	products	\N	\N	\N	99	1	\N	0
299	\N	\N	\N	\N	\N	721.5Ki	200.jpg	jpg	980c2bb92408fbca6bb84cc00aebb70117b676af.jpg	products	\N	\N	\N	92	1	\N	1
279	\N	\N	\N	\N	\N	515.3Ki	551.jpg	jpg	7c62ecfa13dc44b63e9e997f8c49fac69c0e7037.jpg	products	\N	\N	\N	98	1	\N	1
254	\N	\N	\N	\N	\N	617.4Ki	572-2.jpg	jpg	74d7c5bbc634047f03d797c75ee7520045821257.jpg	products	\N	\N	\N	108	1	\N	0
255	\N	\N	\N	\N	\N	617.4Ki	572-2.jpg	jpg	bce9a5a8b3b64a0e94810a88042e840700fa1e0b.jpg	products	\N	\N	\N	108	1	\N	0
280	\N	\N	\N	\N	\N	735.4Ki	324.jpg	jpg	f10db3c74ce8584b61723fcd1db65382339e7cf1.jpg	products	\N	\N	\N	98	1	\N	0
256	\N	\N	\N	\N	\N	679.4Ki	572.jpg	jpg	ecbe146d7c95abaa11a7ecb875f1cf57cde4a006.jpg	products	\N	\N	\N	108	1	\N	1
257	\N	\N	\N	\N	\N	533.9Ki	572-3.jpg	jpg	1a380a3778c6c5bf249a936c376beb38706ccdef.jpg	products	\N	\N	\N	108	1	\N	0
258	\N	\N	\N	\N	\N	641.9Ki	570-1.jpg	jpg	1c3abb0e1fb88b28fdb5e848e3c0819dffe64e76.jpg	products	\N	\N	\N	106	1	\N	0
259	\N	\N	\N	\N	\N	526.5Ki	570-11.jpg	jpg	f78d26c4b18e0964caf33c83af4d38a1702fca78.jpg	products	\N	\N	\N	106	1	\N	0
261	\N	\N	\N	\N	\N	140.7Ki	570-12.jpg	jpg	e5500a7b0f4e3792358e5f7c79f2511fe8723c33.jpg	products	\N	\N	\N	106	1	\N	0
260	\N	\N	\N	\N	\N	725.5Ki	570.jpg	jpg	b9fe971e765b5c250631eb291ad65649777547f1.jpg	products	\N	\N	\N	106	1	\N	1
262	\N	\N	\N	\N	\N	511.0Ki	560-3.jpg	jpg	bf374b3d968a613c930cf0fda716a904870ac607.jpg	products	\N	\N	\N	105	1	\N	0
263	\N	\N	\N	\N	\N	468.0Ki	560-2.jpg	jpg	d53fc797a25bd5308e50e973e55531e592183a56.jpg	products	\N	\N	\N	105	1	\N	0
264	\N	\N	\N	\N	\N	626.6Ki	560-1.jpg	jpg	320733005851a613094439c8774428d23de243d0.jpg	products	\N	\N	\N	105	1	\N	0
291	\N	\N	\N	\N	\N	593.6Ki	260-1.jpg	jpg	d4dc77f9b05928076a9397e309b542c8ed71566b.jpg	products	\N	\N	\N	94	1	\N	0
265	\N	\N	\N	\N	\N	697.6Ki	560.jpg	jpg	51f873d4f0b7e423e3ee0ef1a467dedc92d1e3a2.jpg	products	\N	\N	\N	105	1	\N	1
266	\N	\N	\N	\N	\N	141.2Ki	560-0.jpg	jpg	eebaa39ebd0d74f056865c6f59aeebafb8efdf5b.jpg	products	\N	\N	\N	105	1	\N	0
267	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	6dcb6cbe87d92b39c92100817d33812dca37b3d8.jpg	products	\N	\N	\N	104	1	\N	0
281	\N	\N	\N	\N	\N	731.7Ki	300.jpg	jpg	0548108ef78168855edd1e3e7dc310cf3109c2e9.jpg	products	\N	\N	\N	97	1	\N	1
268	\N	\N	\N	\N	\N	112.6Ki	555.jpg	jpg	849d1c9aec5decd308da731687439db042666e92.jpg	products	\N	\N	\N	104	1	\N	1
282	\N	\N	\N	\N	\N	400.7Ki	300-0.jpg	jpg	2b1429ee7034daed6ffc6a0f2f08675f1887c8e4.jpg	products	\N	\N	\N	97	1	\N	0
269	\N	\N	\N	\N	\N	709.5Ki	554.jpg	jpg	44a588fde4bf6c586cff5265e439d2f99df97c06.jpg	products	\N	\N	\N	103	1	\N	1
270	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	2b79164b619ccfe85dfd67f74cb0ad5077f4e76c.jpg	products	\N	\N	\N	103	1	\N	0
283	\N	\N	\N	\N	\N	419.2Ki	praga.jpg	jpg	64cf495a1dd83695affcdc75235fb4168d9a279d.jpg	products	\N	\N	\N	97	1	\N	0
271	\N	\N	\N	\N	\N	746.1Ki	553.jpg	jpg	2564c8f3a43b5597439d596dfed95f6176e52056.jpg	products	\N	\N	\N	102	1	\N	1
272	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	bd8dd23e67c4e6e8ba84d2a6df5972eaa4c9ea16.jpg	products	\N	\N	\N	102	1	\N	1
273	\N	\N	\N	\N	\N	699.5Ki	552.jpg	jpg	0b4341b998abeccd85946ddf1f7dcfae9f64319a.jpg	products	\N	\N	\N	101	1	\N	1
274	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	fa957c4c4aef48aaee29ce15a3d3b58e576ed883.jpg	products	\N	\N	\N	101	1	\N	0
275	\N	\N	\N	\N	\N	675.0Ki	550-0.jpg	jpg	979294e196d70c6f338acc99317335a1a6112aa3.jpg	products	\N	\N	\N	100	1	\N	0
276	\N	\N	\N	\N	\N	515.3Ki	551.jpg	jpg	fb71c32d8c7c24825a3e6145ffbf4b64eb299de5.jpg	products	\N	\N	\N	100	1	\N	1
292	\N	\N	\N	\N	\N	602.1Ki	vertikalniu.jpg	jpg	48522deadcdc62b4e0951a05715b4b60b5553278.jpg	products	\N	\N	\N	94	1	\N	0
277	\N	\N	\N	\N	\N	516.8Ki	550.jpg	jpg	137fb77206d211167d871ad277923cabd5e78ba3.jpg	products	\N	\N	\N	99	1	\N	1
284	\N	\N	\N	\N	\N	706.6Ki	290.jpg	jpg	9105221f056c30839b12394b5723a89e6dcbd177.jpg	products	\N	\N	\N	96	1	\N	1
285	\N	\N	\N	\N	\N	353.0Ki	290-0.jpg	jpg	7bf0462b82d4289e3ed08f1a1b8ecf2e7c0f8a5e.jpg	products	\N	\N	\N	96	1	\N	0
293	\N	\N	\N	\N	\N	198.5Ki	vertkir.jpg	jpg	23e96791587b375107bef15cfcdbcd7a79357d97.jpg	products	\N	\N	\N	94	1	\N	0
290	\N	\N	\N	\N	\N	747.1Ki	260.jpg	jpg	f8f902a084dad9c3a47f3d35bca523e2e9fd7c84.jpg	products	\N	\N	\N	94	1	\N	1
294	\N	\N	\N	\N	\N	561.4Ki	203-1.jpg	jpg	dd340571fc6ef5fbbb6688461480ae2caa956920.jpg	products	\N	\N	\N	93	1	\N	0
287	\N	\N	\N	\N	\N	469.2Ki	vertikalniuugol.jpg	jpg	d9e5337d7bf143955d1e69332572c626df329b2b.jpg	products	\N	\N	\N	95	1	\N	0
288	\N	\N	\N	\N	\N	590.4Ki	261-1.jpg	jpg	6abdf49d78c53e3e3228f0fce7513ea702216e24.jpg	products	\N	\N	\N	95	1	\N	0
289	\N	\N	\N	\N	\N	198.5Ki	vertkir.jpg	jpg	b98d025d73c3cf19a6f283397c62118cb2f9525f.jpg	products	\N	\N	\N	95	1	\N	0
286	\N	\N	\N	\N	\N	744.2Ki	261.jpg	jpg	9b24722a8f1382acd48cd850c59d340f22cebc78.jpg	products	\N	\N	\N	95	1	\N	1
300	\N	\N	\N	\N	\N	250.4Ki	kkol.jpg	jpg	36a5fa1bfd400b9dc685438b1635f56ef9e000ee.jpg	products	\N	\N	\N	92	1	\N	0
295	\N	\N	\N	\N	\N	663.2Ki	203.jpg	jpg	dc4f00308453c0fdfa4fdde666837c28d55df4fe.jpg	products	\N	\N	\N	93	1	\N	1
296	\N	\N	\N	\N	\N	503.0Ki	kirpichkolotiu.jpg	jpg	bb771fa5e8fdd4b2a63c4986680d9ece695dada8.jpg	products	\N	\N	\N	93	1	\N	0
297	\N	\N	\N	\N	\N	250.4Ki	kkol.jpg	jpg	75a6bda511bd7d3747aaf11e907e2262eaeb4f40.jpg	products	\N	\N	\N	93	1	\N	0
298	\N	\N	\N	\N	\N	692.4Ki	200-1.jpg	jpg	9da28dc876eca45f7bd1dc10839746c3c8672e97.jpg	products	\N	\N	\N	92	1	\N	0
302	\N	\N	\N	\N	\N	603.6Ki	103-1.jpg	jpg	6ec0cb062a407f271426f37180f9f2d88b3311fc.jpg	products	\N	\N	\N	91	1	\N	0
301	\N	\N	\N	\N	\N	137.8Ki	kirkol.jpg	jpg	7e2e6b1e55f750f5fbf1e203cc20da06667bdc78.jpg	products	\N	\N	\N	92	1	\N	0
305	\N	\N	\N	\N	\N	434.5Ki	veneciyaugol.jpg	jpg	be348094bef7082d17db75b0da1784f7459fcdfc.jpg	products	\N	\N	\N	91	1	\N	1
303	\N	\N	\N	\N	\N	619.7Ki	100-0.jpg	jpg	6704fd3dff05bdc8a341b8adaf3bdde36cafc857.jpg	products	\N	\N	\N	91	1	\N	0
304	\N	\N	\N	\N	\N	708.3Ki	103.jpg	jpg	00e5c3bb12eeafb5449f83aa482b4ad830092389.jpg	products	\N	\N	\N	91	1	\N	0
308	\N	\N	\N	\N	\N	619.7Ki	100-0.jpg	jpg	fc4631ae225af78cd485c2547140208aa5d3558e.jpg	products	\N	\N	\N	90	1	\N	0
307	\N	\N	\N	\N	\N	689.1Ki	101.jpg	jpg	e5a28da133f81ff0f858421c96f364081ba9c77b.jpg	products	\N	\N	\N	90	1	\N	1
309	\N	\N	\N	\N	\N	619.7Ki	100-0.jpg	jpg	cad7125bda5a83d04377787ac85967fdfa7c8fb4.jpg	products	\N	\N	\N	89	1	\N	0
310	\N	\N	\N	\N	\N	690.3Ki	100.jpg	jpg	c645639bc63a589bef2605f0db696bb75764d343.jpg	products	\N	\N	\N	89	1	\N	1
312	\N	\N	\N	\N	\N	726.8Ki	610-0.jpg	jpg	4bbb9d0637d980fb990bb891d19d6ab27feea56c.jpg	products	\N	\N	\N	88	1	\N	0
311	\N	\N	\N	\N	\N	559.4Ki	612n.jpg	jpg	9ef827fff098f5373c6d3cde3b4818d881992508.jpg	products	\N	\N	\N	88	1	\N	1
314	\N	\N	\N	\N	\N	726.8Ki	610-0.jpg	jpg	81f8a9e4c673718b2e74eddc6f7e834fdca35a77.jpg	products	\N	\N	\N	87	1	\N	0
313	\N	\N	\N	\N	\N	566.1Ki	611n.jpg	jpg	815c304033c7d19e1cd55ef198cab391e8db8d4c.jpg	products	\N	\N	\N	87	1	\N	1
315	\N	\N	\N	\N	\N	674.7Ki	610-1.jpg	jpg	09273026ed286f41567d7330304e8778d2f6bf04.jpg	products	\N	\N	\N	86	1	\N	0
316	\N	\N	\N	\N	\N	726.8Ki	610-0.jpg	jpg	b1d7883420cf02b9d6e055f8b04e677d8c00fd27.jpg	products	\N	\N	\N	86	1	\N	0
317	\N	\N	\N	\N	\N	681.6Ki	610.jpg	jpg	83ffc68fe4bf808a778d58bcddae6b433d954bb2.jpg	products	\N	\N	\N	86	1	\N	1
356	\N	\N	\N	\N	\N	610.4Ki	pm640.jpg	jpg	e4415056805219f76cdb3637bc9a8f60f0665b7a.jpg	products	\N	\N	\N	69	1	\N	0
355	\N	\N	\N	\N	\N	361.7Ki	pm640-mold.jpg	jpg	18e830fb66443a795b1f629e49cba23530986e17.jpg	products	\N	\N	\N	69	1	\N	1
362	\N	\N	\N	\N	\N	360.2Ki	M_05-10_80-20_GS.JPG	JPG	c1b149987e5c05f524a6f6b1777f917fb8ed9a70.JPG	products	\N	\N	\N	63	1	\N	0
366	\N	\N	\N	\N	\N	414.3Ki	M_05-10_60-40_GS.JPG	JPG	3850d31adeb6aee3a0467ca95a00f8531f475cc6.JPG	products	\N	\N	\N	61	1	\N	0
365	\N	\N	\N	\N	\N	312.8Ki	M_05-10_60-40_GS-s.JPG	JPG	127e01f35bedf0ef15c03fde1dde8348bfb3f730.JPG	products	\N	\N	\N	61	1	\N	1
368	\N	\N	\N	\N	\N	658.1Ki	571-1.jpg	jpg	138070c6f48aee05020c278301bd3697efb7b029.jpg	products	\N	\N	\N	110	1	\N	0
371	\N	\N	\N	\N	\N	574.2Ki	540-0.jpg	jpg	9457f40d9300e034991be4e9cb8578385d8e0aeb.jpg	products	\N	\N	\N	114	1	\N	0
375	\N	\N	\N	\N	\N	266.8Ki	350_0.jpg	jpg	7b85899d894fd355ef88546f86d27325a81ff346.jpg	products	\N	\N	\N	115	1	\N	0
376	\N	\N	\N	\N	\N	752.8Ki	350.jpg	jpg	c5c128db3c241fdf88d26b80fc442eaa30bd334a.jpg	products	\N	\N	\N	115	1	\N	1
382	\N	\N	\N	\N	\N	40.8Ki	postavki-ton.jpg	jpg	006abf4a3943e68dc3dfb2ca555a7d581d5f5798.jpg	main_page	\N	\N	\N	1	1	\N	0
383	\N	\N	\N	\N	\N	106.4Ki	form-kamen-ton.jpg	jpg	92e596620a80e392aebaddb6282279cf9ce071e9.jpg	main_page	\N	\N	\N	1	1	\N	0
384	\N	\N	\N	\N	\N	14.3Ki	kislotn-kras-ton.jpg	jpg	8682f26eeed2899702189226f6f148a2d9613ec5.jpg	main_page	\N	\N	\N	1	1	\N	0
318	\N	\N	\N	\N	\N	998.8Ki	050-0.jpg	jpg	26cf1fb30c2f468aa6f4f7802c7919a35dca5139.jpg	products	\N	\N	\N	85	1	\N	0
319	\N	\N	\N	\N	\N	562.2Ki	stariukirpichugol.jpg	jpg	dbe3054da82816d3d8f15f437bef0ba5d2f7206c.jpg	products	\N	\N	\N	85	1	\N	1
320	\N	\N	\N	\N	\N	772.2Ki	051.jpg	jpg	da314e9f27c06ea2d566dc246c97796c624ce1e1.jpg	products	\N	\N	\N	84	1	\N	1
321	\N	\N	\N	\N	\N	998.8Ki	050-0.jpg	jpg	8950be22b1a4d78d64b255a4ad8499f83628f11f.jpg	products	\N	\N	\N	84	1	\N	0
322	\N	\N	\N	\N	\N	998.8Ki	050-0.jpg	jpg	0b3dcd3f1bd2c6c2819b294393ea444a2285f3c9.jpg	products	\N	\N	\N	83	1	\N	1
323	\N	\N	\N	\N	\N	672.2Ki	050-1.jpg	jpg	f01dc2908bede9bfd2e0e938ccef1aea925ed038.jpg	products	\N	\N	\N	83	1	\N	0
324	\N	\N	\N	\N	\N	714.5Ki	050.jpg	jpg	e4556ebaf1214a99cc6900522f8ed41194c9f607.jpg	products	\N	\N	\N	83	1	\N	0
325	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	f6581d04b5423212d630043abd9714412eeef788.jpg	products	\N	\N	\N	81	1	\N	0
326	\N	\N	\N	\N	\N	292.4Ki	pm630f.jpg	jpg	ced18abc1767f3157a3298b463a5153e8488065e.jpg	products	\N	\N	\N	81	1	\N	1
327	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	673aa22bf1789ca6b6fd77b344d8fe646d583870.jpg	products	\N	\N	\N	81	1	\N	0
328	\N	\N	\N	\N	\N	744.2Ki	pm630.jpg	jpg	9350a3aebc5ba81773195381fbd27121c2de2932.jpg	products	\N	\N	\N	80	1	\N	0
358	\N	\N	\N	\N	\N	119.6Ki	M_05-10_95-5_GS.JPG	JPG	3d19c7ec85f74458038c7e0a2233de0bfe4684c6.JPG	products	\N	\N	\N	65	1	\N	0
329	\N	\N	\N	\N	\N	284.5Ki	pm630e.jpg	jpg	ae60cadb880a1763b4772dd7e8c3c99034de9384.jpg	products	\N	\N	\N	80	1	\N	1
330	\N	\N	\N	\N	\N	219.0Ki	pm630l.jpg	jpg	bf9ffd1f836447803ce5920b9557a087114a46f4.jpg	products	\N	\N	\N	80	1	\N	0
331	\N	\N	\N	\N	\N	285.2Ki	pm630d.jpg	jpg	1f593cd938ff13d656d3370151f3995796117c51.jpg	products	\N	\N	\N	79	1	\N	1
357	\N	\N	\N	\N	\N	194.6Ki	M_05-10_95-5_GS-s.JPG	JPG	45b01bb01d9737684f6383556cb955b229cb7583.JPG	products	\N	\N	\N	65	1	\N	1
369	\N	\N	\N	\N	\N	511.9Ki	571-2.jpg	jpg	1c83841e45499716c7446242d86415467893aaf8.jpg	products	\N	\N	\N	110	1	\N	0
372	\N	\N	\N	\N	\N	739.2Ki	540.jpg	jpg	5637a0cb2848eff9faddcbb94fecb3b0254b67b5.jpg	products	\N	\N	\N	114	1	\N	1
377	\N	\N	\N	\N	\N	569.6Ki	350-1.jpg	jpg	49c7919f3e54c3ec280f07a10af4e4a72e704236.jpg	products	\N	\N	\N	115	1	\N	0
\.


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('files_id_seq', 385, true);


--
-- Data for Name: lang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lang (id, name, active, title, little_description, sort, created_at, deleted_at, updated_at) FROM stdin;
1	RU	1	Russian	Russian	1	\N	\N	\N
2	EN	1	English	English	1	\N	\N	\N
\.


--
-- Name: lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lang_id_seq', 2, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY menu (id, name, sys_cat, text, active, cat, title, author, keywords, description, sort, class, controller, album, fields_land, created_at, deleted_at, updated_at) FROM stdin;
4	Красители		Красители	1	0	Красители		Красители	Красители	0			\N	\N	\N	\N	2017-07-09 09:13:37.051
1	Формы		Формы	1	0	Формы		Формы	Формы	0			\N	\N	\N	\N	2017-07-09 09:13:58.091
3	Формы для камня			1	1	м		Формы для камня	Формы для камня	0			\N	\N	\N	\N	2017-07-09 09:14:44.326
5	Формы для панно		Формы для панно	1	1	Формы для панно		Формы для панно	Формы для панно	0			\N	\N	2017-07-09 09:19:24.843	\N	2017-07-09 09:19:24.843
7	Строительные материалы			1	0	Строительные материалы		Строительные материалы	Строительные материалы	0			\N	\N	2017-07-24 18:25:35.438	\N	2017-07-24 18:25:35.438
8	Инструменты		Инструменты	1	0	Инструменты		Инструменты	Инструменты	0			\N	\N	2017-07-24 18:25:49.457	\N	2017-07-24 18:25:49.457
9	Кирпич		Кирпич	1	0	Кирпич		Кирпич	Кирпич	0			\N	\N	2017-07-24 18:26:01.856	\N	2017-07-24 18:26:01.856
10	Шифер		Шифер	1	0	Шифер		Шифер	Шифер	0			\N	\N	2017-07-24 18:26:13.958	\N	2017-07-24 18:26:13.958
11	Краска			1	0	Краска		Краска	Краска	0			\N	\N	2017-07-24 18:26:24.856	\N	2017-07-24 18:26:24.856
12	Уголь		Уголь	1	0	Уголь		Уголь		0			\N	\N	2017-07-24 18:26:36.585	\N	2017-07-24 18:26:36.585
13	Гипсокартон		Гипсокартон	1	0	Гипсокартон		Гипсокартон	Гипсокартон	0			\N	\N	2017-07-24 18:26:49.072	\N	2017-07-24 18:26:49.072
14	Стеновые панели	0	Стеновые панели	1	7	Стеновые панели		Стеновые панели	Стеновые панели	0			0	0	2017-08-26 17:04:26.5	\N	2017-08-26 17:04:26.5
\.


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('menu_id_seq', 14, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orders (id, count, sum_price, current_price, current_discount, id_parent, id_applications, id_user, id_seller, created_at, deleted_at, updated_at) FROM stdin;
12	4	4400	1100	0	23	12	0	\N	2017-10-01 20:10:21.307	\N	\N
13	4	4800	1200	0	42	12	0	\N	2017-10-01 20:10:21.314	\N	\N
14	2	2000	1000	0	65	12	0	\N	2017-10-01 20:10:21.319	\N	\N
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 14, true);


--
-- Data for Name: params; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY params (id, active, html_bottom, html_top, text, created_at, updated_at, name, system_name) FROM stdin;
3	1			Duzzer — покупка классных строительных и отделочных материалов	\N	\N	Title main page	title_main_page
4	1			Duzzer — покупка с доставкой товаров для строительства и ремонта. Строительные и отделочные материалы от производителей	\N	\N	Description main page	description_main_page
5	1			<script type="text/javascript" > (function (d, w, c) { (w[c] = w[c] || []).push(function() { try { w.yaCounter46184952 = new Ya.Metrika({ id:46184952, clickmap:true, trackLinks:true, accurateTrackBounce:true, webvisor:true }); } catch(e) { } }); var n = d.getElementsByTagName("script")[0], s = d.createElement("script"), f = function () { n.parentNode.insertBefore(s, n); }; s.type = "text/javascript"; s.async = true; s.src = "https://mc.yandex.ru/metrika/watch.js"; if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); } })(document, window, "yandex_metrika_callbacks"); </script>\r\n	\N	\N	Метрика	metrika
1	1	\N	\N	{"block_1_1":{"link":"http://duzzer.ru/catalog/4","img":"/images/files/big/8682f26eeed2899702189226f6f148a2d9613ec5.jpg","text":"Кислотные красители"},"block_3_1":{"link":"http://duzzer.ru/catalog/7?cat=14","img":"/images/files/big/aa7778a7b2110262019f9a1c53d2a8b9a1f8765d.jpg","text":"Стеновые панели"},"block_2":{"link":"http://duzzer.ru/catalog/1?cat=3","img":"/images/files/big/92e596620a80e392aebaddb6282279cf9ce071e9.jpg","text":"Формы для камня"},"block_3_2":{"link":"http://duzzer.ru","img":"/images/files/big/006abf4a3943e68dc3dfb2ca555a7d581d5f5798.jpg","text":"Напрямую от производителей"},"block_1_2":{"link":"http://duzzer.ru","img":"/images/files/big/5bb965fd1b4dda5bc9710698b540add969bbef67.jpg","text":"Покупка с доставкой"}}	2017-08-26 17:04:26.5	2017-08-26 17:04:26.5	\N	main_page
\.


--
-- Name: params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('params_id_seq', 5, true);


--
-- Data for Name: playground; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY playground (equip_id, type, color, location, install_date) FROM stdin;
\.


--
-- Name: playground_equip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('playground_equip_id_seq', 1, false);


--
-- Data for Name: power; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY power (id, id_user, id_menu, r, x, w, d, "createdAt", "updatedAt", "deletedAt") FROM stdin;
213	11	4	0	0	0	0	2017-05-04 10:21:40.007	2017-05-04 10:21:40.007	\N
214	11	5	0	0	1	0	2017-05-04 10:21:40.04	2017-05-04 10:21:40.04	\N
217	11	8	0	0	0	0	2017-05-04 10:21:40.132	2017-05-04 10:21:40.132	\N
219	11	10	0	0	0	0	2017-05-04 10:21:40.197	2017-05-04 10:21:40.197	\N
220	11	11	0	0	0	0	2017-05-04 10:21:40.231	2017-05-04 10:21:40.231	\N
221	11	12	0	0	0	0	2017-05-04 10:21:40.266	2017-05-04 10:21:40.266	\N
208	1	10	1	0	0	0	\N	2017-05-05 21:27:23.101	\N
211	11	1	1	0	0	0	2017-05-04 10:21:39.909	2017-05-15 10:32:20.282	\N
212	11	2	0	1	0	0	2017-05-04 10:21:39.95	2017-05-15 10:32:20.318	\N
215	11	6	0	0	0	0	2017-05-04 10:21:40.072	2017-05-15 10:32:20.353	\N
216	11	7	1	0	0	0	2017-05-04 10:21:40.103	2017-05-15 10:32:20.432	\N
218	11	9	1	0	0	1	2017-05-04 10:21:40.164	2017-05-15 10:32:20.471	\N
202	1	4	1	0	0	0	\N	2017-05-08 18:11:07.628	\N
203	1	5	1	0	0	0	\N	2017-05-08 18:11:07.656	\N
206	1	8	1	0	0	0	\N	2017-05-08 18:11:07.762	\N
209	1	11	1	0	0	0	\N	2017-05-08 18:11:07.832	\N
210	1	12	1	0	0	0	\N	2017-05-08 18:11:07.865	\N
200	1	1	1	1	1	1	\N	2017-05-23 07:32:27.072	\N
201	1	2	1	1	1	1	\N	2017-05-23 07:32:27.109	\N
204	1	6	1	1	1	1	\N	2017-05-23 07:32:27.158	\N
205	1	7	1	1	1	1	\N	2017-05-23 07:32:27.192	\N
207	1	9	1	1	1	1	\N	2017-05-23 07:32:27.238	\N
222	1	14	1	1	1	1	2017-05-23 07:13:52.042	2017-05-23 07:32:27.277	\N
223	0	1	0	0	0	0	2017-05-24 14:22:56.402	2017-05-24 14:22:56.402	\N
224	0	2	0	0	0	0	2017-05-24 14:22:56.606	2017-05-24 14:22:56.606	\N
225	0	6	0	0	0	0	2017-05-24 14:22:56.654	2017-05-24 14:22:56.654	\N
226	0	7	1	0	0	0	2017-05-24 14:22:56.733	2017-05-24 14:22:56.733	\N
227	0	9	0	0	0	0	2017-05-24 14:22:56.81	2017-05-24 14:22:56.81	\N
228	0	14	1	1	0	0	2017-05-24 14:22:56.885	2017-05-24 14:22:56.885	\N
229	18	1	0	0	0	0	2017-05-24 14:23:34.108	2017-05-24 14:23:34.108	\N
230	18	2	0	0	0	0	2017-05-24 14:23:34.156	2017-05-24 14:23:34.156	\N
231	18	6	0	0	0	0	2017-05-24 14:23:34.25	2017-05-24 14:23:34.25	\N
232	18	7	1	0	0	0	2017-05-24 14:23:34.29	2017-05-24 14:23:34.29	\N
233	18	9	0	0	0	0	2017-05-24 14:23:34.329	2017-05-24 14:23:34.329	\N
234	18	14	1	1	0	0	2017-05-24 14:23:34.405	2017-05-24 14:23:34.405	\N
249	18	issues	1	1	1	1	2017-07-05 21:07:26.946	2017-07-06 19:40:15.61	\N
\.


--
-- Name: power_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('power_id_seq', 249, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (id, author, name, html_bottom, html_top, keywords, active, cat, sort, tags, text, title, to_main, description, created_at, deleted_at, updated_at, brand, discount, params, price, vendor_code, user_id, reviews) FROM stdin;
30		Кислотный краситель зеленый (1,2 кг)	\N	\N		1	4	\N	["кислотный краситель","зеленый"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель зеленый (1,2 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,200\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	1050	З-1	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
29		Кислотный краситель желтый (1,2 кг)	\N	\N		1	4	\N	["кислотный краситель","желтый"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель желтый (1,2 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,200\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	950	Ж-1	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
25		Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель","сандеко"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	S N F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
26		Кислотный краситель черный (1,2 кг)	\N	\N		1	4	\N	["кислотный краситель","черный"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель черный (1,2 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,200\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	950	Ч-1	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
36	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	S G GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
28		Кислотный краситель коричневый (1,2 кг)	\N	\N		1	4	\N	["краситель кислотный","коричневый"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель коричневый (1,2 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,200\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	950	Кр-3	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
32		Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20 мм\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553 мм\\",\\"width\\":\\"180 мм\\"}}"	1100	S R GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
31		Кислотный краситель синий (1,3 кг)	\N	\N		1	4	\N	["кислотный краситель","синий","16","18"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель синий (1,3 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,300\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	1150	С-1	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
23		Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель","19"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N	Стеновая панель «Sandeco»	\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	S R F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
33	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	[]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	S B F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
24		Стеновая панель «Sandeco»	\N	\N		1	14	\N	[]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20 мм\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553 мм\\",\\"width\\":\\"180 мм\\"}}"	1100	S N GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
34	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	S B GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
37	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	S Y GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
35	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	[]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>		\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	S G F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
27		Кислотный краситель красный (1,3 кг)	\N	\N		1	4	\N	["кислотный краситель","красный"]	<p>При создании кислотных красителей мы вдохновлялись продукцией американской компании Concrete Coatings, Inc. VIVID&trade;. По нашему мнению, кислотные красители этой компании обладают самыми лучшими характеристиками и разнообразием цветов. Кислотные красители мы сделали более концентрированными, что дает возможность получать сразу несколько оттенков из одного цвета красителя: из <em><strong>Ebony</strong></em> получается <em><strong>Mission Brown</strong></em>, из <em><strong>Mahogany</strong></em> - <em><strong>Weathered Terracotta</strong></em> и <em><strong>Caramel</strong></em>, из <em><strong>Walnut</strong></em> - <em><strong>Coffee</strong></em>. Светлые оттенки представлены <em><strong>Amber</strong></em>, <em><strong>Olive</strong></em> и <em><strong>Turquoise</strong></em>.</p>\n<p><strong>Применяется для окраса: </strong></p>\n<ul>\n<li>искусственного камня на белом и сером цементах,</li>\n<li>вибролитой и вибропрессованной тротуарной плитки,</li>\n<li>старых и новых бетонных полов, древесной щепы и т.д.</li>\n</ul>\n<p>Для получения желанного цвета разбавляется с водой в диапазоне от 1/1 до 1/50. Для получения темного насыщенного цвета используйте концентрат. Стойкий к воздействию УФ.</p>	Кислотный краситель красный (1,3 кг)	\N		\N	\N	\N	0	\N	"{\\"concentrate_density_m3\\":{\\"concentrate_density_m3\\":\\"1,300\\"},\\"consumption_m2\\":{\\"consumption_m2\\":\\"0,15-0,3\\"}}"	1050	К-2	\N	<p><iframe src="//www.youtube.com/embed/udzRtsWnIXg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
38	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	S Y F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
42	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 50/50 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
43	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 70/30 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
44	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 60/40 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
45	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 80/20 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
46	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 90/10 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
47	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 10-15 95/5 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
49	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 60/40 GS 	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
48	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 50/50 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
51	\N	Стеновая панель «Sandeco»	\N	\N		1	0	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 80/20 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
52	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 90/10 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
50	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 70/30 GS 	\N	<p>https://www.youtube.com/watch?time_continue=21&amp;v=06dJKJQVzdk</p>
53	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 10-15 95/5 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
54	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 05-10 80/20 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
55	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 05-10 70/30 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
56	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1200	M 05-10 60/40 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
57	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	M 05-10 50/50 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
58	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	M 05-10 90/10 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
59	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1100	M 05-10 95/5 F	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
60	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 50/50 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
61	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 60/40 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
65	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 95/5 GS 	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
63	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 80/20 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
70	\N	Резиновая форма PM620A Сланец Карпатский	\N	\N		1	3	\N	["искусственный камень","резиновые формы","полиуретановые формы","формы для камня"]	<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A&nbsp;</li>\n</ul>\n<h3>О серии Сланец Карпатский</h3>\n<p>Комплект представлен 3 плоскостными формами и 1 угловой. Неповторимость текстуры &mdash; 4 формы общей площадью 0,81 м&sup2;.</p>	Резиновая форма PM620A Сланец Карпатский	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"39\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"6\\"}}"	2400	PM620A	\N	
73	\N	Резиновая форма PM620C Сланец Карпатский	\N	\N		1	3	\N	["резиновые формы","формы для камня"]	<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A&nbsp;</li>\n</ul>\n<h3>О серии Сланец Карпатский</h3>\n<p>Комплект представлен 3 плоскостными формами и 1 угловой. Неповторимость текстуры &mdash; 4 формы общей площадью 0,81 м&sup2;.</p>	Резиновая форма PM620C Сланец Карпатский	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"39\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"6\\"}}"	2400	PM620C	\N	
71	\N	Резиновая форма PM620B Сланец Карпатский	\N	\N		1	3	\N	["резиновая форма","форма для камня"]	<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A&nbsp;</li>\n</ul>\n<h3>О серии Сланец Карпатский</h3>\n<p>Комплект представлен 3 плоскостными формами и 1 угловой. Неповторимость текстуры &mdash; 4 формы общей площадью 0,81 м&sup2;.</p>	Резиновая форма PM620B Сланец Карпатский	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"39\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"6\\"}}"	2400	PM620B	\N	
79	\N	Резиновая форма PM630D Старый замок	\N	\N		1	3	\N	["резиновая форма","форма для камня"]	<h3>Размер элементов:</h3>\n<ul>\n<li>27,5 х 18,5 х 2 см &mdash; 3 шт</li>\n<li>18,5 х 18,5 х 2 см</li>\n<li>27,5 х 9 х 2 см</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор&nbsp;&mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры&nbsp;&mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630D Старый замок	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"27,5\\",\\"width\\":\\"18,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	2400	PM630D	\N	
75	\N	Резиновая форма PM620D Сланец Карпатский Угловой элемент	\N	\N		1	3	\N	["резиновые формы","формы для камня"]	<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A&nbsp;</li>\n</ul>\n<h3>О серии Сланец Карпатский</h3>\n<p>Комплект представлен 3 плоскостными формами и 1 угловой. Неповторимость текстуры &mdash; 4 формы общей площадью 0,81 м&sup2;.</p>	Резиновая форма PM620D Сланец Карпатский Угловой элемент	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,18\\"},\\"stone_size\\":{\\"length\\":\\"23\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"6\\"}}"	2400	PM620D	\N	
69	\N	Резиновая форма PM640 Античное дерево	\N	\N		1	3	\N	["резиновая форма","форма для камня","полиуретановая форма"]	<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A</li>\n</ul>	Резиновая форма PM640 Античное дерево	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,25\\"},\\"stone_size\\":{\\"length\\":\\"235\\",\\"width\\":\\"60\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"18\\"}}"	2400	PM640	\N	
86	\N	Резиновая форма F610 Заводский кирпич	\N	\N		1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Заводский кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F610 Заводский кирпич	\N	Купить с доставкой резиновую форму для изготовления декоративного камня Заводский кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"50\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,18\\"},\\"stone_size\\":{\\"length\\":\\"23\\",\\"width\\":\\"6,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—0,8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	1800	F610	\N	
81	\N	Резиновая форма PM630F Старый замок	\N	\N		1	3	\N	["формы для декоративного камня"]	<h3>Размер элементов:</h3>\n<ul>\n<li>18,5 х 9 х 1,5 см &mdash; 8 шт</li>\n<li>9 х 9 х 1,5 см &mdash; 8 шт</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор &mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры &mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630F Старый замок	\N	Купить резиновую форму с доставкой для производства искусственного камня Старый замок	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,2\\"},\\"stone_size\\":{\\"length\\":\\"18,5\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	3000	PM630F	\N	
80	\N	Резиновая форма PM630E Старый замок	\N	\N		1	3	\N	["резиновая форма","форма для камня"]	<h3>Размер элементов:</h3>\n<ul>\n<li>27,5 х 18,5 х 2 см</li>\n<li>18,5 х 18,5 х 2 см &mdash; 2 шт</li>\n<li>27,5 х 9 х 2 см &mdash; 3 шт</li>\n<li>18,5 х 9 х 2 см</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор&nbsp;&mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры&nbsp;&mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630E Старый замок	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"27,5\\",\\"width\\":\\"18,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	2400	PM630E	\N	
78	\N	Резиновая форма PM630C Старый замок	\N	\N		1	3	\N	["резиновая форма","форма для камня"]	<h3>Размер элементов:</h3>\n<ul>\n<li>27,5 х 27,5 х 2 см</li>\n<li>18,5 х 18,5 х 2 см</li>\n<li>27,5 х 9 х 2 см &mdash; 2 шт</li>\n<li>18,5 х 9 х 2 см &mdash; 3 шт</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор&nbsp;&mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры&nbsp;&mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630C Старый замок	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"27,5\\",\\"width\\":\\"27,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	2400	PM630C	\N	
76	\N	Резиновая форма PM630A Старый замок	\N	\N		1	3	\N	["форма для камня","резиновая форма"]	<h3>Размер элементов:</h3>\n<ul>\n<li>18,5 х 18,5 х 2,5 см &mdash; 2 шт</li>\n<li>18,5 х 9 х 2,5 см &mdash; 3 шт</li>\n<li>27,5 х 9 х 2,5 см</li>\n<li>9 х 9 х 2,5 см &mdash; 3 шт</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор&nbsp;&mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры&nbsp;&mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630A Старый замок	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,17\\"},\\"stone_size\\":{\\"length\\":\\"18,5\\",\\"width\\":\\"9\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	2400	PM630A	\N	
84	\N	Резиновая форма F051 Старый кирпич	\N	\N		1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Старый кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F051 Старый кирпич	\N	Купить с доставкой резиновую форму для декоративного камня Старый кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"47\\",\\"width\\":\\"32\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,1\\"},\\"stone_size\\":{\\"length\\":\\"28,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	1500	F051	\N	<p><iframe src="//www.youtube.com/embed/JmhpCDETSPs" width="560" height="314" allowfullscreen="allowfullscreen"></iframe><img src="https://www.youtube.com/watch?v=JmhpCDETSPs" alt="" /></p>
85	\N	Резиновая форма F053 Старый кирпич Угол	\N	\N		1	3	\N	["форма для камня"]	<h3>Размер камня:</h3>\n<p>18х6 см &mdash; 4 шт, 9х6 см &mdash; 4 шт.</p>\n<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Старый кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F053 Старый кирпич Угол	\N	Купить с доставкой резиновую форму для изготовления декоративного камня Старый кирпич угол	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"31\\",\\"width\\":\\"30\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,06\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	1200	F053	\N	<p><iframe src="//www.youtube.com/embed/hF4FF8igIOA" width="560" height="314" allowfullscreen="allowfullscreen"></iframe><img src="https://www.youtube.com/watch?v=hF4FF8igIOA" alt="" /></p>
83	\N	Резиновые формы F050 Старый кирпич	\N	\N		1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Старый кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма Старый кирпич	\N	Купить с доставкой резиновую форму для декоративного камня Старый кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"61\\",\\"width\\":\\"45\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"28,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	3000	F050	\N	<p><iframe src="//www.youtube.com/embed/uTUHjfYUJzY" width="560" height="314" allowfullscreen="allowfullscreen"></iframe><img src="https://www.youtube.com/watch?v=uTUHjfYUJzY" /></p>
88	\N	Резиновая форма F612 Заводский кирпич	\N	\N		1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Заводский кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F612 Заводский кирпич	\N	Купить с доставкой форму для производства искусственного камня Заводский кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"40\\",\\"width\\":\\"26\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,07\\"},\\"stone_size\\":{\\"length\\":\\"23\\",\\"width\\":\\"6,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"1,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—0,8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"5\\"}}"	900	F612	\N	
89	\N	Резиновая форма F100 Кирпич Венеция	\N	\N	резиновые формы, форма для камня	1	3	\N	["форма для декоративного камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Венеция&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F100 Кирпич Венеция	\N	Купить с доставкой резиновую форму для камня Кирпич Венеция	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"61\\",\\"width\\":\\"49\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,23\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"5,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"21\\"}}"	3300	F100	\N	<p><iframe src="//www.youtube.com/embed/PZ2zTZe9TQc" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
95	\N	Резиновая форма F261 Кирпич вертикальный угол	\N	\N	кирпич вертикальный угол, формы для камня	1	3	\N	["форма для камня","кирпич вертикальный угол"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>18х5,5 см &mdash; 6 шт, 8,5х5,5 см &mdash; 6 шт</p>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич вертикальный угол&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F261 Кирпич вертикальный угол	\N	Купить с доставкой форму для производства декоративного камня Кирпич вертикальный угол	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"40\\",\\"width\\":\\"30\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,09\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"5,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"6\\"}}"	0	F261	\N	<p><iframe src="//www.youtube.com/embed/pLgR4h5UoV4" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
90	\N	Резиновая форма F101 Кирпич Венеция	\N	\N	кирпич венеция, форма для камня	1	3	\N	["резиновая форма","форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Венеция&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F101 Кирпич Венеция	\N	Купить с доставкой резиновую форму для изготовления декоративного камня Кирпич Венеция	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"41\\",\\"width\\":\\"37\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,11\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"10\\"}}"	1600	F101	\N	<p><iframe src="//www.youtube.com/embed/Ud2kgoiFsxc" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
91	\N	Резиновая форма F103 Кирпич Венеция угол	\N	\N	кирпич венеция угол, форма для камня	1	3	\N	["кирпич венеция угол","резиновая форма","форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>18х6 см &mdash; 4 шт, 9х6 см &mdash; 4 шт</p>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Венеция&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F103 Кирпич Венеция угол	\N	Купить с доставкой резиновую форму Кирпич Венеция угол для изготовления декоративного камня	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"32\\",\\"width\\":\\"29\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,06\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"4\\"}}"	1200	F103	\N	<p><iframe src="//www.youtube.com/embed/a-GMNwh_NDI" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
92	\N	Резиновая форма F200 Кирпич колотый	\N	\N	кирпич колотый, форма для камня	1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич колотый&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F200 Кирпич колотый	\N	Продажа с доставкой форм для изготовления декоративного камня Кирпич колотый	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"54\\",\\"width\\":\\"52\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,2\\"},\\"stone_size\\":{\\"length\\":\\"23,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1-1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"14\\"}}"	3000	F200	\N	<p><iframe src="//www.youtube.com/embed/HCST6vUzSWw" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
93	\N	Резиновая форма F203 Кирпич колотый угол	\N	\N	форма для камня, кирпич ломаный	1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>23,5х6 см &mdash; 4 шт, 12х6 см &mdash; 4 шт</p>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич колотый&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F203 Кирпич колотый угол	\N	Продажа с доставкой форм для изготовления искусственного камня Кирпич ломаный угол	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"39\\",\\"width\\":\\"31\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,08\\"},\\"stone_size\\":{\\"length\\":\\"23,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1-1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"4\\"}}"	1200	F203	\N	<p><iframe src="//www.youtube.com/embed/JNZo8jVUOag" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
94	\N	Резиновая форма F260 Кирпич вертикальный	\N	\N	форма для камня, кирпич вертикальный	1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич вертикальный&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F260 Кирпич вертикальный	\N	Купить с доставкой форму для производства декоративного камня Кирпич вертикальный	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"41\\",\\"width\\":\\"40\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,12\\"},\\"stone_size\\":{\\"length\\":\\"18\\",\\"width\\":\\"5,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	1500	F260	\N	<p><iframe src="//www.youtube.com/embed/ipO8962D7Tg" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
102	\N	Резиновая форма F553 Кирпич Манхэттен	\N	\N	кирпич манхэттен, форма для камня\r\n	1	3	\N	["форма для камня","кирпич манхэттен"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F553 Кирпич Манхэттен	\N	Продаём резиновые формы для производства камня Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,15\\"},\\"stone_size\\":{\\"length\\":\\"20,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	2100	F553	\N	<p><iframe src="//www.youtube.com/embed/45JylvPMl3I" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
97	\N	Резиновая форма F300 Кирпич Старая Прага	\N	\N	кирпич старая прага, форма для камня	1	3	\N	["кирпич старая прага","форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Старая Прага&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F300 Кирпич Старая Прага	\N	Купить с доставкой форму для изготовления искусственного камня Кирпич Старая Прага	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"54\\",\\"width\\":\\"31\\",\\"height\\":\\"3\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,12\\"},\\"stone_size\\":{\\"length\\":\\"24,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"8\\"}}"	1800	F300	\N	<p><iframe src="//www.youtube.com/embed/JeQdDG1XzEE" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
100	\N	Резиновая форма F551 Кирпич Манхэттен	\N	\N	форма для камня, кирпич манхэттен	1	3	\N	["форма для камня","кирпич манхэттен"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F551 Кирпич Манхэттен	\N	Купить с доставкой форму для производства искусственного камня Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,15\\"},\\"stone_size\\":{\\"length\\":\\"20,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	2100	F551	\N	<p><img src="https://www.youtube.com/watch?v=ZMYjxPgHe2U" alt="" /><iframe src="//www.youtube.com/embed/ZMYjxPgHe2U" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
103	\N	Резиновая форма F554 Кирпич Манхэттен	\N	\N	кирпич манхэттен, форма для камня	1	3	\N	["форма для камня","кирпич манхэттен"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F554 Кирпич Манхэттен	\N	Купить с доставкой форму для изготовления декоративного камня Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,15\\"},\\"stone_size\\":{\\"length\\":\\"20,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	2100	F554	\N	<p><iframe src="//www.youtube.com/embed/hkTB0phSsBM" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
87	\N	Резиновая форма F611 Заводский кирпич	\N	\N		1	3	\N	["форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Заводский кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F611 Заводский кирпич	\N	Купить с доставкой форму для производства декоративного камня Заводский кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"40\\",\\"width\\":\\"26\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,08\\"},\\"stone_size\\":{\\"length\\":\\"23\\",\\"width\\":\\"6,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"1,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—0,8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"5\\"}}"	900	F611	\N	
101	\N	Резиновая форма F552 Кирпич Манхэттен	\N	\N	кирпич манхэттен, форма для камня	1	3	\N	["формы для камня","кирпич манхэттен"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F552 Кирпич Манхэттен	\N	Продажа с доставкой форм для изготовления камня Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,15\\"},\\"stone_size\\":{\\"length\\":\\"20,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	2100	F552	\N	<p><iframe src="//www.youtube.com/embed/0qH9L69X5H4" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
99	\N	Резиновая форма F550 Кирпич Манхэттен	\N	\N	форма для камня, кирпич манхэттен	1	3	\N	["форма для камня","кирпич манхэттен"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F550 Кирпич Манхэттен	\N	Купить с доставкой поливинилпластовую форму для производства декоративного камня Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,15\\"},\\"stone_size\\":{\\"length\\":\\"20,5\\",\\"width\\":\\"5\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	2100	F550	\N	<p><iframe src="//www.youtube.com/embed/kzlACns9Kog" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
104	\N	Резиновая форма F555 Кирпич Манхэттен	\N	\N	форма для камня, кирпич манхэттен	1	3	\N	["кирпич манхэттен","форма для изготовления камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич Манхэттен&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F555 Кирпич Манхэттен	\N	Купить с доставкой форму для изготовления Кирпич Манхэттен	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"45\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,14\\"},\\"stone_size\\":{\\"length\\":\\"10\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"24\\"}}"	2100	F555	\N	<p><iframe src="//www.youtube.com/embed/VFoegVnP2As" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
106	\N	Резиновая форма F570 Венский клинкер	\N	\N	венский клинкер, форма для камня	1	3	\N	["форма для камня","венский клинкер"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Венский клинкер&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F570 Венский клинкер	\N	Купить с доставкой форму для камня Венский клинкер	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"69\\",\\"width\\":\\"54\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,28\\"},\\"stone_size\\":{\\"length\\":\\"21\\",\\"width\\":\\"5,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"24\\"}}"	2750	F570	\N	<p><iframe src="//www.youtube.com/embed/QMSIgQ5-0to" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
64	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновые панели"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 90/10 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
108	\N	Резиновая форма F572 Венский клинкер	\N	\N	форма для камня, венский клинкер	1	3	\N	["форма для камня","венский клинкер"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Венский клинкер&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F572 Венский клинкер	\N	Купить форму для камня для изготовления декоративного камня Венский клинкер	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"45\\",\\"width\\":\\"38\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,14\\"},\\"stone_size\\":{\\"length\\":\\"21\\",\\"width\\":\\"5,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	1200	F572	\N	<p><iframe src="//www.youtube.com/embed/GrfFn35kIoI" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
105	\N	Резиновая форма F560 Немецкий кирпич	\N	\N	немецкий кирпич, форма для камня	1	3	\N	["форма для камня","немецкий кирпич"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Немецкий кирпич&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F560 Немецкий кирпич	\N	Купить с доставкой резиновую форму для изготовления камня Немецкий кирпич	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"63\\",\\"width\\":\\"48\\",\\"height\\":\\"1,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,23\\"},\\"stone_size\\":{\\"length\\":\\"22\\",\\"width\\":\\"4,8\\"},\\"form_weight\\":{\\"form_weight\\":\\"4\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—0,8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"22\\"}}"	2400	F560	\N	<p><iframe src="//www.youtube.com/embed/XEOE8R5BSE8" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
98	\N	Резиновая форма F324 Клинкер гладкий	\N	\N		1	3	\N	[]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Клинкер гладкий&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>		\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"54\\",\\"width\\":\\"53\\",\\"height\\":\\"1,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,22\\"},\\"stone_size\\":{\\"length\\":\\"24,5\\",\\"width\\":\\"6\\"},\\"form_weight\\":{\\"form_weight\\":\\"3\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,6\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"14\\"}}"	1800	F324	\N	
96	\N	Резиновая форма F290 Кирпич римский	\N	\N	кирпич римский, форма для камня	1	3	\N	["резиновая форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Кирпич римский&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F290 Кирпич римский	\N	Купить с доставкой резиновую форму для изготовления декоративного камня Кирпич римский	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"55\\",\\"width\\":\\"32\\",\\"height\\":\\"10\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,13\\"},\\"stone_size\\":{\\"length\\":\\"25\\",\\"width\\":\\"6,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2,5\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,8\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"8\\"}}"	1500	F290	\N	<p><iframe src="//www.youtube.com/embed/bGIbhuzy53A" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
77	\N	Резиновая форма PM630B Старый замок	\N	\N		1	3	\N	["форма для камня","резиновая форма"]	<h3>Размер элементов:</h3>\n<ul>\n<li>27,5 х 27,5 х 2,5 см</li>\n<li>27,5 х 18,5 х 2,5 см</li>\n<li>27,5 х 9 х 2,5 см &mdash; 2 шт</li>\n<li>18,5 х 9 х 2,5 см &mdash; 2 шт</li>\n</ul>\n<p>Толщина камней из этой формы 2,5 см. В остальных формах этого комплекта камни имеют толщину 1,5, 2 и 2,5 см. Это сделано для достижения эффекта старинной кладки.</p>\n<h3>Особенности формы</h3>\n<ul>\n<li>Формы не требуют разделительной смазки.</li>\n<li>Формы используют для работ с бетоном, гипсом, смолами и полимерами.</li>\n<li>Формы мягкие и эластичные, выдерживают 1500&mdash;2000 циклов заливки бетоном.</li>\n<li>Формы не теряют геометрию и прекрасно удерживают пигменты на поверхности.</li>\n<li>Твердость по Шор&nbsp;&mdash; 45 A.</li>\n</ul>\n<h3>О серии</h3>\n<p>Старый замок Комплект представлен 6 формами. Неповторимость текстуры&nbsp;&mdash; 6 форм общей площадью 1,21 м&sup2;.</p>	Резиновая форма PM630B Старый замок	\N		\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"\\",\\"width\\":\\"\\",\\"height\\":\\"\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,21\\"},\\"stone_size\\":{\\"length\\":\\"27,5\\",\\"width\\":\\"27,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"2,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"\\"}}"	2400	Резиновая форма PM630B Старый замок	\N	
62	\N	Стеновая панель «Sandeco»	\N	\N		1	14	\N	["стеновая панель"]	<p>Утеплитель в стене, облицованной термопанелями &laquo;Сандеко&raquo; находится с внешней стороны, таким образом вся стена будет служить аккумулятором тепла &ndash; холода. Благодаря этому летом за ночь стена будет остывать, а днём &ndash; нагреваться, охлаждая здание.</p>\n<p>Зимой будет обратная ситуация &ndash; при проветривании помещения, или в случае отключение отопления, через стены теряется незначительное количества тепла, а тепло, уходящее через проёмы и кровлю, будет компенсироваться теплом, накопленным в стенах. Для примера кирпичный дом, с толщиной стен в один кирпич, при утеплённой кровле и двухкамерных окнах, в случае отключения отопления зимой будет остывать не более, чем на 1-2 градуса в день.</p>	Стеновая панель «Sandeco»	\N		\N	\N	\N	0	\N	"{\\"weight\\":{\\"weight\\":\\"20 кг/м²\\"},\\"thickness\\":{\\"thickness\\":\\"20\\"},\\"dimensions_length_width\\":{\\"length\\":\\"553\\",\\"width\\":\\"180  \\"}}"	1000	M 05-10 70/30 GS	\N	<p><iframe src="//www.youtube.com/embed/06dJKJQVzdk" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
110	\N	Резиновая форма F571 Венский клинкер	\N	\N	форма для камня, венский клинкер	1	3	\N	["венский клинкер","форма для камня"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Венский клинкер&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F571 Венский клинкер	\N	Купить с доставкой форму для изготовления декоративного камня Венский клинкер	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"45\\",\\"width\\":\\"38\\",\\"height\\":\\"2\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,14\\"},\\"stone_size\\":{\\"length\\":\\"21,2\\",\\"width\\":\\"5,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"2\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"0,5—1\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	1200	F571	\N	<p><iframe src="//www.youtube.com/embed/sdbed2QxoVU" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
114	\N	Резиновая форма F540 Аврора	\N	\N	аврора, форма для камня	1	3	\N	["резиновая форма","форма для камня","аврора"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Аврора&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F540 Аврора	\N	Купить с доставкой резиновую форму для изготовления декоративного камня Аврора	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"64\\",\\"width\\":\\"53\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,27\\"},\\"stone_size\\":{\\"length\\":\\"30\\",\\"width\\":\\"7,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"6\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1—1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"12\\"}}"	3600	F540	\N	<p><iframe src="//www.youtube.com/embed/2OAmQxizNr0" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
115	\N	Резиновая форма F350 Вавилон	\N	\N	форма для камня, вавилон	1	3	\N	["форма для камня","вавилон"]	<h3>Идеальная форма из Поливинилпласта&reg;:</h3>\n<p>Особопрочная, мягкая эластичная форма для камня &laquo;Вавилон&raquo; выполнена из разработанного и запатентованного нами материала &mdash; Поливинилпласт&reg;. Наши формы из Поливинилпласт&reg; похожи на полиуретановые формы и формы из силикона, но превосходят их по прочности, гибкости и стойкости к агрессивной щелочной среде.</p>\n<blockquote>\n<p>Форма универсальная, предназначена для заливки цементом и гипсом, в отличии от форм из силикона, не рвется и служит долго.</p>\n</blockquote>\n<h3>Назначение</h3>\n<p>Наши формы CONA прекрасно подходят как для крупного производства, так и для изготовления исскуственного камня в домашних условиях. Уникальный запатентованый материал форм спроектирован нашими химиками для тонкой передачи фактуры камня, идеально отражают самые сложные перепады.</p>\n<h3>Срок службы</h3>\n<p>При нагрузке 24/7 на производстве верно прослужит 5 лет! &mdash; без деформаций, разрывов, без потери геометрии и износа! При использовании в быту &mdash; бессрочна! Наши формы прекрасно себя зарекомендовали на заводах в России и СНГ.</p>	Резиновая форма F350 Вавилон	\N	Купить с доставкой форму для производства облицовочного камня Вавилон	\N	\N	\N	0	\N	"{\\"form_size\\":{\\"length\\":\\"46\\",\\"width\\":\\"37\\",\\"height\\":\\"2,5\\"},\\"stone_outlet\\":{\\"stone_outlet\\":\\"0,13\\"},\\"stone_size\\":{\\"length\\":\\"21\\",\\"width\\":\\"7,5\\"},\\"form_weight\\":{\\"form_weight\\":\\"3\\"},\\"thickness_of_stone\\":{\\"thickness_of_stone\\":\\"1—1,5\\"},\\"var_textury_fdk\\":{\\"var_textury_fdk\\":\\"8\\"}}"	1800	F350	\N	<p><iframe src="//www.youtube.com/embed/-RQPeo6BqVU" width="560" height="314" allowfullscreen="allowfullscreen"></iframe></p>
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 115, true);


--
-- Data for Name: seo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY seo (id, name, keywords, active, title, description, created_at, deleted_at, updated_at, author) FROM stdin;
1	main	Главная	1	Главная	Главная	2017-05-10 19:19:08.649	\N	2017-05-10 19:19:47.968	
\.


--
-- Name: seo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seo_id_seq', 1, true);


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY statuses (id, parent_id, active, status, created_at, deleted_at, updated_at, id_user) FROM stdin;
1	1	1	0	2017-05-26 08:24:47.053	\N	2017-05-26 09:20:47.053	\N
2	9	1	0	2017-09-30 11:47:58.274	\N	\N	0
3	12	1	0	2017-10-02 00:58:41	\N	\N	0
\.


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('statuses_id_seq', 3, true);


--
-- Data for Name: str; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY str (id, name, html_bottom, html_top, keywords, active, cat, sort, tags, text, title, to_main, description, created_at, deleted_at, updated_at, author) FROM stdin;
1	{"ru":"fds","en":"fdsf"}		{{!< ../../admin/layout}}\r\n{{#contentFor "head"}}\r\n    <link href="/admin/css/plugins/codemirror/codemirror.css" rel="stylesheet">\r\n    <link href="/admin/css/plugins/codemirror/dracula.css" rel="stylesheet">\r\n{{/contentFor}}\r\n\r\n<div class="con">\r\n    <div class="row wrapper border-bottom white-bg page-heading">\r\n        <div class="col-lg-12">\r\n            <h2>{{ module.name_module }}</h2>\r\n            <ol class="breadcrumb">\r\n                <li>\r\n                    <a href="/admin/">Рабочий стол</a>\r\n                </li>\r\n                <li>\r\n                    <a href="/admin/index/{{ table }}">Главный список</a>\r\n                </li>\r\n                <li class="active">\r\n                    <strong>{{# if id}}Редактирование{{ else }}Добавление{{/if}}</strong>\r\n                </li>\r\n            </ol>\r\n\r\n            <div class="ibox-tools">\r\n                {{# if modules.x }}\r\n                    <a href="/admin/update/{{ table }}" class="btn btn-primary">Добавить</a>\r\n                {{/if}}\r\n            </div>\r\n        </div>\r\n\r\n        <div class="ibox-content">\r\n            <form method="post" class="form-modules form-horizontal form-label-left">\r\n                <div class="" role="tabpanel" data-example-id="togglable-tabs">\r\n                    <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">\r\n                        <li role="presentation" class="active">\r\n                            <a\r\n                                    href="#url-00-tab"\r\n                                    id="00-tab"\r\n                                    role="tab"\r\n                                    data-toggle="tab"\r\n                                    aria-expanded="true"\r\n                            >\r\n                                Основные\r\n                            </a>\r\n                        </li>\r\n\r\n                        {{# if langShow }}\r\n                            {{#each lang as |val key| }}\r\n                                <li role="presentation" class="">\r\n                                    <a\r\n                                            href="#url-{{ key }}-tab"\r\n                                            id="{{ key }}-tab"\r\n                                            role="tab"\r\n                                            data-toggle="tab"\r\n                                            aria-expanded="false"\r\n                                    >\r\n                                        {{ val.name }}\r\n                                    </a>\r\n                                </li>\r\n                            {{/each}}\r\n                        {{/if}}\r\n                    </ul>\r\n\r\n                    <div id="myTabContent" class="tab-content">\r\n                        <div role="tabpanel" class="tab-pane fade active in" id="url-00-tab" aria-labelledby="00-tab">\r\n                            <div class="wrapper wrapper-content animated fadeIn">\r\n                                {{#each plugins as |v| }}\r\n                                    {{{ v.html_top }}}\r\n                                    {{{ v.html }}}\r\n                                    {{{ v.html_bottom }}}\r\n\r\n\r\n                                    {{# iff v.plugins.name '==' 'album' }}\r\n                                        {{#contentFor "footer"}}\r\n                                            <script>\r\n                                                $.ajax({\r\n                                                    type: "post",\r\n                                                    url: "/admin/file_manager/show_loader",\r\n                                                    data: {\r\n                                                        name_table : '{{ ../../../table }}',\r\n                                                        id_album   : '{{ ../../../id }}'\r\n                                                    },\r\n                                                    cache: false,\r\n                                                    dataType: "html",\r\n                                                    success: function (data) {\r\n                                                        $('#album').html(data);\r\n                                                    }\r\n                                                })\r\n                                            </script>\r\n                                        {{/contentFor}}\r\n                                    {{/iff}}\r\n                                {{/each}}\r\n                            </div>\r\n                        </div>\r\n\r\n                        {{# if langShow }}\r\n                            {{#each lang as |val key| }}\r\n                                <div\r\n                                        role="tabpanel"\r\n                                        class="tab-pane fade"\r\n                                        id="url-{{ key }}-tab"\r\n                                        aria-labelledby="{{ key }}-tab"\r\n                                >\r\n                                    <div class="wrapper wrapper-content animated fadeIn">\r\n                                        {{#each ../pluginsLang as |v k| }}\r\n                                            {{{ v.html_top }}}\r\n                                            {{{replace v.html '--options--' val.name '[]' }}}\r\n                                            {{{ v.html_bottom }}}\r\n                                        {{/each}}\r\n                                    </div>\r\n                                </div>\r\n                            {{/each}}\r\n                        {{/if}}\r\n                    </div>\r\n                </div>\r\n\r\n                <div class="text-right">\r\n                    <div class="loader"></div>\r\n                    <button class="btn btn-success" type="submit">Сохранить</button>\r\n                    <button class="btn btn-primary" formaction="/admin/update/{{ table }}/{{{df id 0}}}/1" type="submit">Применить</button>\r\n                    <button class="btn btn-default" formaction="/admin/index/{{ table }}" type="submit">Отменить</button>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n{{#contentFor "footer"}}\r\n    <script type="text/javascript" src="/js/lodash.min.js"></script>\r\n    <script src="/admin/js/plugins/tinymce/tinymce.min.js"></script>\r\n\r\n    <!-- CodeMirror -->\r\n    <script src="/admin/js/plugins/codemirror/codemirror.js"></script>\r\n    <script src="/admin/js/plugins/codemirror/mode/javascript/javascript.js"></script>\r\n\r\n    <script>\r\n        tinymce.init({\r\n            selector: ".area",\r\n            plugins: [\r\n                "advlist autolink lists link image charmap print preview anchor",\r\n                "searchreplace visualblocks code fullscreen",\r\n                "insertdatetime media table contextmenu paste",\r\n                " emoticons imagetools fullscreen"\r\n            ],\r\n            toolbar: "fullscreen insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | fontselect fontsizeselect"\r\n            + 'print preview media | emoticons ',\r\n            imagetools_cors_hosts: ['www.tinymce.com', 'codepen.io'],\r\n            image_class_list: [\r\n                {title: 'None', value: ''},\r\n                {title: 'Clear', value: 'clear'},\r\n                {title: 'Thumbnail', value: 'thumbnail'}\r\n            ],\r\n            class_list: [\r\n                {title: 'None', value: ''},\r\n                {title: 'Clear', value: 'clear'},\r\n                {title: 'Thumbnail', value: 'thumbnail'}\r\n            ],\r\n\r\n            menubar: true,\r\n            image_advtab: true,\r\n            image_dimensions: true,\r\n//            image_prepend_url: "/",\r\n            document_base_url : "/",\r\n            relative_urls: false,\r\n            language: "ru",\r\n            font_formats: "Andale Mono=andale mono,times;"+\r\n            "Arial=arial,helvetica,sans-serif;"+\r\n            "Arial Black=arial black,avant garde;"+\r\n            "Book Antiqua=book antiqua,palatino;"+\r\n            "Comic Sans MS=comic sans ms,sans-serif;"+\r\n            "Courier New=courier new,courier;"+\r\n            "Georgia=georgia,palatino;"+\r\n            "Helvetica=helvetica;"+\r\n            "Impact=impact,chicago;"+\r\n            "Symbol=symbol;"+\r\n            "Tahoma=tahoma,arial,helvetica,sans-serif;"+\r\n            "Terminal=terminal,monaco;"+\r\n            "Times New Roman=times new roman,times;"+\r\n            "Trebuchet MS=trebuchet ms,geneva;"+\r\n            "Verdana=verdana,geneva;"+\r\n            "Webdings=webdings;"+\r\n            "Wingdings=wingdings,zapf dingbats"\r\n        });\r\n        tinymce.init({\r\n            selector: ".area_min",\r\n            menubar: false,\r\n            language: "ru"\r\n        });\r\n    </script>\r\n    <script>\r\n        $(document).ready(function() {\r\n            CodeMirror.fromTextArea(document.getElementById("textareaHtml_top"), {\r\n                lineNumbers: true,\r\n                matchBrackets: true,\r\n                styleActiveLine: true,\r\n                foldGutter: true,\r\n                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],\r\n                extraKeys: {"Ctrl-Q": function(cm){ cm.foldCode(cm.getCursor()); }},\r\n//                theme: "dracula",\r\n            });\r\n\r\n            CodeMirror.fromTextArea(document.getElementById("textareaHtml_bottom"), {\r\n                lineNumbers: true,\r\n                matchBrackets: true,\r\n                styleActiveLine: true,\r\n                foldGutter: true,\r\n                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],\r\n                extraKeys: {"Ctrl-Q": function(cm){ cm.foldCode(cm.getCursor()); }},\r\n//                theme: "dracula",\r\n            });\r\n        });\r\n    </script>\r\n\r\n    {{# if data }}  {{/if}}\r\n        <script>\r\n            function json_decode (strJson) { // eslint-disable-line camelcase\r\n                //       discuss at: http://phpjs.org/functions/json_decode/\r\n                //      original by: Public Domain (http://www.json.org/json2.js)\r\n                // reimplemented by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)\r\n                //      improved by: T.J. Leahy\r\n                //      improved by: Michael White\r\n                //           note 1: If node or the browser does not offer JSON.parse,\r\n                //           note 1: this function falls backslash\r\n                //           note 1: to its own implementation using eval, and hence should be considered unsafe\r\n                //        example 1: json_decode('[ 1 ]')\r\n                //        returns 1: [1]\r\n                /*\r\n                 http://www.JSON.org/json2.js\r\n                 2008-11-19\r\n                 Public Domain.\r\n                 NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.\r\n                 See http://www.JSON.org/js.html\r\n                 */\r\n                var $global = (typeof window !== 'undefined' ? window : global)\r\n                $global.$locutus = $global.$locutus || {}\r\n                var $locutus = $global.$locutus\r\n                $locutus.php = $locutus.php || {}\r\n                var json = $global.JSON\r\n                if (typeof json === 'object' && typeof json.parse === 'function') {\r\n                    try {\r\n                        return json.parse(strJson)\r\n                    } catch (err) {\r\n                        if (!(err instanceof SyntaxError)) {\r\n                            throw new Error('Unexpected error type in json_decode()')\r\n                        }\r\n                        // usable by json_last_error()\r\n                        $locutus.php.last_error_json = 4\r\n                        return null\r\n                    }\r\n                }\r\n                var chars = [\r\n                    '\\u0000',\r\n                    '\\u00ad',\r\n                    '\\u0600-\\u0604',\r\n                    '\\u070f',\r\n                    '\\u17b4',\r\n                    '\\u17b5',\r\n                    '\\u200c-\\u200f',\r\n                    '\\u2028-\\u202f',\r\n                    '\\u2060-\\u206f',\r\n                    '\\ufeff',\r\n                    '\\ufff0-\\uffff'\r\n                ].join('')\r\n                var cx = new RegExp('[' + chars + ']', 'g')\r\n                var j\r\n                var text = strJson\r\n                // Parsing happens in four stages. In the first stage, we replace certain\r\n                // Unicode characters with escape sequences. JavaScript handles many characters\r\n                // incorrectly, either silently deleting them, or treating them as line endings.\r\n                cx.lastIndex = 0\r\n                if (cx.test(text)) {\r\n                    text = text.replace(cx, function (a) {\r\n                        return '\\\\u' + ('0000' + a.charCodeAt(0)\r\n                                        .toString(16))\r\n                                        .slice(-4)\r\n                    })\r\n                }\r\n                // In the second stage, we run the text against regular expressions that look\r\n                // for non-JSON patterns. We are especially concerned with '()' and 'new'\r\n                // because they can cause invocation, and '=' because it can cause mutation.\r\n                // But just to be safe, we want to reject all unexpected forms.\r\n                // We split the second stage into 4 regexp operations in order to work around\r\n                // crippling inefficiencies in IE's and Safari's regexp engines. First we\r\n                // replace the JSON backslash pairs with '@' (a non-JSON character). Second, we\r\n                // replace all simple value tokens with ']' characters. Third, we delete all\r\n                // open brackets that follow a colon or comma or that begin the text. Finally,\r\n                // we look to see that the remaining characters are only whitespace or ']' or\r\n                // ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.\r\n                var m = (/^[\\],:{}\\s]*$/)\r\n                        .test(text.replace(/\\\\(?:["\\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')\r\n                                .replace(/"[^"\\\\\\n\\r]*"|true|false|null|-?\\d+(?:\\.\\d*)?(?:[eE][+-]?\\d+)?/g, ']')\r\n                                .replace(/(?:^|:|,)(?:\\s*\\[)+/g, ''))\r\n                if (m) {\r\n                    // In the third stage we use the eval function to compile the text into a\r\n                    // JavaScript structure. The '{' operator is subject to a syntactic ambiguity\r\n                    // in JavaScript: it can begin a block or an object literal. We wrap the text\r\n                    // in parens to eliminate the ambiguity.\r\n                    j = eval('(' + text + ')') // eslint-disable-line no-eval\r\n                    return j\r\n                }\r\n                // usable by json_last_error()\r\n                $locutus.php.last_error_json = 4\r\n                return null\r\n            }\r\n\r\n            function json_encode (mixedVal) {\r\n                // eslint-disable-line camelcase\r\n                //       discuss at: http://phpjs.org/functions/json_encode/\r\n                //      original by: Public Domain (http://www.json.org/json2.js)\r\n                // reimplemented by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)\r\n                //      improved by: Michael White\r\n                //         input by: felix\r\n                //      bugfixed by: Brett Zamir (http://brett-zamir.me)\r\n                //        example 1: json_encode('Kevin')\r\n                //        returns 1: '"Kevin"'\r\n                /*\r\n                  http://www.JSON.org/json2.js\r\n                  2008-11-19\r\n                  Public Domain.\r\n                  NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.\r\n                  See http://www.JSON.org/js.html\r\n                */\r\n                var $global = (typeof window !== 'undefined' ? window : global)\r\n                $global.$locutus = $global.$locutus || {}\r\n                var $locutus = $global.$locutus\r\n                $locutus.php = $locutus.php || {}\r\n                var json = $global.JSON\r\n                var retVal\r\n                try {\r\n                    if (typeof json === 'object' && typeof json.stringify === 'function') {\r\n                        // Errors will not be caught here if our own equivalent to resource\r\n                        retVal = json.stringify(mixedVal)\r\n                        if (retVal === undefined) {\r\n                            throw new SyntaxError('json_encode')\r\n                        }\r\n                        return retVal\r\n                    }\r\n                    var value = mixedVal\r\n                    var quote = function (string) {\r\n                        var escapeChars = [\r\n                            '\\u0000-\\u001f',\r\n                            '\\u007f-\\u009f',\r\n                            '\\u00ad',\r\n                            '\\u0600-\\u0604',\r\n                            '\\u070f',\r\n                            '\\u17b4',\r\n                            '\\u17b5',\r\n                            '\\u200c-\\u200f',\r\n                            '\\u2028-\\u202f',\r\n                            '\\u2060-\\u206f',\r\n                            '\\ufeff',\r\n                            '\\ufff0-\\uffff'\r\n                        ].join('')\r\n                        var escapable = new RegExp('[\\\\"' + escapeChars + ']', 'g')\r\n                        var meta = {\r\n                            // table of character substitutions\r\n                            '\\b': '\\\\b',\r\n                            '\\t': '\\\\t',\r\n                            '\\n': '\\\\n',\r\n                            '\\f': '\\\\f',\r\n                            '\\r': '\\\\r',\r\n                            '"': '\\\\"',\r\n                            '\\\\': '\\\\\\\\'\r\n                        }\r\n                        escapable.lastIndex = 0\r\n                        return escapable.test(string) ? '"' + string.replace(escapable, function (a) {\r\n                                    var c = meta[a]\r\n                                    return typeof c === 'string' ? c : '\\\\u' + ('0000' + a.charCodeAt(0)\r\n                                                    .toString(16))\r\n                                                    .slice(-4)\r\n                                }) + '"' : '"' + string + '"'\r\n                    }\r\n                    var _str = function (key, holder) {\r\n                        var gap = ''\r\n                        var indent = '    '\r\n                        // The loop counter.\r\n                        var i = 0\r\n                        // The member key.\r\n                        var k = ''\r\n                        // The member value.\r\n                        var v = ''\r\n                        var length = 0\r\n                        var mind = gap\r\n                        var partial = []\r\n                        var value = holder[key]\r\n                        // If the value has a toJSON method, call it to obtain a replacement value.\r\n                        if (value && typeof value === 'object' && typeof value.toJSON === 'function') {\r\n                            value = value.toJSON(key)\r\n                        }\r\n                        // What happens next depends on the value's type.\r\n                        switch (typeof value) {\r\n                            case 'string':\r\n                                return quote(value)\r\n                            case 'number':\r\n                                // JSON numbers must be finite. Encode non-finite numbers as null.\r\n                                return isFinite(value) ? String(value) : 'null'\r\n                            case 'boolean':\r\n                            case 'null':\r\n                                // If the value is a boolean or null, convert it to a string. Note:\r\n                                // typeof null does not produce 'null'. The case is included here in\r\n                                // the remote chance that this gets fixed someday.\r\n                                return String(value)\r\n                            case 'object':\r\n                                // If the type is 'object', we might be dealing with an object or an array or\r\n                                // null.\r\n                                // Due to a specification blunder in ECMAScript, typeof null is 'object',\r\n                                // so watch out for that case.\r\n                                if (!value) {\r\n                                    return 'null'\r\n                                }\r\n                                // Make an array to hold the partial results of stringifying this object value.\r\n                                gap += indent\r\n                                partial = []\r\n                                // Is the value an array?\r\n                                if (Object.prototype.toString.apply(value) === '[object Array]') {\r\n                                    // The value is an array. Stringify every element. Use null as a placeholder\r\n                                    // for non-JSON values.\r\n                                    length = value.length\r\n                                    for (i = 0; i < length; i += 1) {\r\n                                        partial[i] = _str(i, value) || 'null'\r\n                                    }\r\n                                    // Join all of the elements together, separated with commas, and wrap them in\r\n                                    // brackets.\r\n                                    v = partial.length === 0 ? '[]' : gap\r\n                                            ? '[\\n' + gap + partial.join(',\\n' + gap) + '\\n' + mind + ']'\r\n                                            : '[' + partial.join(',') + ']'\r\n                                    gap = mind\r\n                                    return v\r\n                                }\r\n                                // Iterate through all of the keys in the object.\r\n                                for (k in value) {\r\n                                    if (Object.hasOwnProperty.call(value, k)) {\r\n                                        v = _str(k, value)\r\n                                        if (v) {\r\n                                            partial.push(quote(k) + (gap ? ': ' : ':') + v)\r\n                                        }\r\n                                    }\r\n                                }\r\n                                // Join all of the member texts together, separated with commas,\r\n                                // and wrap them in braces.\r\n                                v = partial.length === 0 ? '{}' : gap\r\n                                        ? '{\\n' + gap + partial.join(',\\n' + gap) + '\\n' + mind + '}'\r\n                                        : '{' + partial.join(',') + '}'\r\n                                gap = mind\r\n                                return v\r\n                            case 'undefined':\r\n                            case 'function':\r\n                            default:\r\n                                throw new SyntaxError('json_encode')\r\n                        }\r\n                    }\r\n                    // Make a fake root object containing our value under the key of ''.\r\n                    // Return the result of stringifying the value.\r\n                    return _str('', {\r\n                        '': value\r\n                    })\r\n                } catch (err) {\r\n                    // @todo: ensure error handling above throws a SyntaxError in all cases where it could\r\n                    // (i.e., when the JSON global is not available and there is an error)\r\n                    if (!(err instanceof SyntaxError)) {\r\n                        throw new Error('Unexpected error type in json_encode()')\r\n                    }\r\n                    // usable by json_last_error()\r\n                    $locutus.php.last_error_json = 4\r\n                    return null\r\n                }\r\n            }\r\n            $(document).ready(function () {\r\n                var plugins = {{{ pluginsStr }}};\r\n                var pluginsLang = {{{ pluginsLangStr }}};\r\n\r\n                function ucfirst( str ) {\r\n                    var f = str.charAt(0).toUpperCase();\r\n                    return f + str.substr(1, str.length-1);\r\n                }\r\n\r\n                $.ajax({\r\n                    cache: false,\r\n                    url: '/admin/modules/getDataSingle',\r\n                    data: {id: '{{ id }}', table: '{{ table }}'},\r\n                    type: 'post',\r\n                    dataType: 'JSON',\r\n                    success: function(data) {\r\n                        var text, body = data.data || {};\r\n\r\n                        _.map(pluginsLang, (v, k) => {\r\n                            text = _.unescape(body[k]);\r\n\r\n                            try {\r\n                                text = JSON.parse(text);\r\n                                if(text) {\r\n                                    $('[name="pl[' + k + '][ru]"]').val(text.ru);\r\n                                    $('[name="pl[' + k + '][en]"]').val(text.en);\r\n                                }\r\n                            } catch (err) {\r\n                                // обработка ошибки\r\n                            }\r\n                        });\r\n\r\n                        _.map(plugins, (v, k) => {\r\n                            console.log((v.plugins || {}).typeField, k)\r\n\r\n                            text = body[k];\r\n\r\n                            console.log(_.escape(text))\r\n\r\n                            if((v.plugins || {}).typeField === 'select' && text) {\r\n                                $('#select' + ucfirst(k)).val(text).trigger("change");\r\n                            } else {\r\n                                $('[name="pl[' + k + ']"]').val(_.escape(text));\r\n                            }\r\n                        })\r\n                    }\r\n                });\r\n            })\r\n        </script>\r\n{{/contentFor}}	{"ru":"","en":""}	1	0	\N		{"ru":"","en":""}	{"ru":"1","en":""}	0	{"ru":"","en":""}	\N	\N	2017-05-14 15:52:08.928	
2	{"ru":"kkjhkjhkjh","en":"kjlkj"}			{"ru":"llllllllllll","en":"lkjl"}	1	0	\N		{"ru":"<p>lll</p>","en":"<p>lkjl</p>"}	{"ru":"lll","en":"lkj"}	0	{"ru":"llllllllllllllllllllll","en":"kjlkj"}	2017-05-13 21:37:02.159	\N	2017-05-13 21:37:02.159	
3	{"ru":"hgfhfg","en":"hgf"}			{"ru":"","en":""}	1	0	\N		{"ru":"","en":""}	{"ru":"","en":""}	0	{"ru":"","en":""}	2017-05-13 21:38:47.065	\N	2017-05-13 21:38:47.065	
4	Товар 1	\N	\N	Товар 1 Keywords	1	0	\N	#test1#test2#test3	Товар 1 описание	Товар 1 Title	\N	Товар 1 Description	2017-07-08 14:43:34.918	\N	2017-07-08 14:43:34.918	
\.


--
-- Name: str_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('str_id_seq', 4, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, active, id_user, name, created_at, updated_at, deleted_at) FROM stdin;
16	1	1	testTagNew	2017-08-19 19:37:28.9	2017-08-19 19:37:28.9	\N
17	1	1	tag2	2017-08-19 19:37:50.732	2017-08-19 19:37:50.732	\N
18	1	1	tete	2017-09-12 21:18:29.266	2017-09-12 21:18:29.266	\N
19	1	1	синий	2017-09-12 21:26:30.502	2017-09-12 21:26:30.502	\N
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 19, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, name, email, password, remember_token, created_at, updated_at, usertype, text, active, save_password, username) FROM stdin;
1	Администратор системы	admin1	40bd001563085fc35165329ea1ff5c5ecbdbbeef		2015-06-11 07:47:53	2017-05-04 09:41:34.147	user	блаv1	1	123	\N
11	power	power@mail.ru	b573f24e55d6b7547cb53bd67b8f50a5256006ff	\N	2015-06-11 07:47:53	2017-05-04 09:38:12.677	user	power	1	power	\N
18	Продавец 01	sellers@sellers.ru	a94a8fe5ccb19ba61c4c0873d391e987982fbbd3	\N	2015-06-11 07:47:53	\N	sellers	Продавец 1	1	test	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 18, true);


--
-- Data for Name: villas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY villas (author, id, name, html_bottom, html_top, keywords, active, cat, sort, tags, text, title, to_main, description, created_at, deleted_at, updated_at) FROM stdin;
\N	1	{"ru":"","en":""}	\N	\N	\N	1	0	\N	\N	\N	\N	\N	\N	2017-05-26 08:20:47.053	\N	2017-05-26 08:20:47.053
\N	2	{"ru":"","en":""}	\N	\N	\N	1	0	\N	\N	\N	\N	\N	\N	2017-05-26 08:22:29.286	\N	2017-05-26 08:22:29.286
\.


--
-- Name: villas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('villas_id_seq', 2, true);


--
-- Name: applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- Name: characteristics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY characteristics
    ADD CONSTRAINT characteristics_pkey PRIMARY KEY (id);


--
-- Name: files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: lang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lang
    ADD CONSTRAINT lang_pkey PRIMARY KEY (id);


--
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: params_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY params
    ADD CONSTRAINT params_pkey PRIMARY KEY (id);


--
-- Name: playground_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playground
    ADD CONSTRAINT playground_pkey PRIMARY KEY (equip_id);


--
-- Name: power_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY power
    ADD CONSTRAINT power_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: seo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY seo
    ADD CONSTRAINT seo_pkey PRIMARY KEY (id);


--
-- Name: statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: str_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY str
    ADD CONSTRAINT str_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: villas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY villas
    ADD CONSTRAINT villas_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO pgadmin;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: applications; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE applications FROM PUBLIC;
REVOKE ALL ON TABLE applications FROM postgres;
GRANT ALL ON TABLE applications TO postgres;
GRANT ALL ON TABLE applications TO pgadmin;


--
-- Name: brand; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE brand FROM PUBLIC;
REVOKE ALL ON TABLE brand FROM postgres;
GRANT ALL ON TABLE brand TO postgres;
GRANT ALL ON TABLE brand TO pgadmin;


--
-- Name: characteristics; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE characteristics FROM PUBLIC;
REVOKE ALL ON TABLE characteristics FROM postgres;
GRANT ALL ON TABLE characteristics TO postgres;
GRANT ALL ON TABLE characteristics TO pgadmin;


--
-- Name: files; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE files FROM PUBLIC;
REVOKE ALL ON TABLE files FROM postgres;
GRANT ALL ON TABLE files TO postgres;
GRANT ALL ON TABLE files TO pgadmin;


--
-- Name: lang; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lang FROM PUBLIC;
REVOKE ALL ON TABLE lang FROM postgres;
GRANT ALL ON TABLE lang TO postgres;
GRANT ALL ON TABLE lang TO pgadmin;


--
-- Name: menu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE menu FROM PUBLIC;
REVOKE ALL ON TABLE menu FROM postgres;
GRANT ALL ON TABLE menu TO postgres;
GRANT ALL ON TABLE menu TO pgadmin;


--
-- Name: orders; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orders FROM PUBLIC;
REVOKE ALL ON TABLE orders FROM postgres;
GRANT ALL ON TABLE orders TO postgres;
GRANT ALL ON TABLE orders TO pgadmin;


--
-- Name: params; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE params FROM PUBLIC;
REVOKE ALL ON TABLE params FROM postgres;
GRANT ALL ON TABLE params TO postgres;
GRANT ALL ON TABLE params TO pgadmin;


--
-- Name: playground; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE playground FROM PUBLIC;
REVOKE ALL ON TABLE playground FROM postgres;
GRANT ALL ON TABLE playground TO postgres;
GRANT ALL ON TABLE playground TO pgadmin;


--
-- Name: power; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE power FROM PUBLIC;
REVOKE ALL ON TABLE power FROM postgres;
GRANT ALL ON TABLE power TO postgres;
GRANT ALL ON TABLE power TO pgadmin;


--
-- Name: products; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE products FROM PUBLIC;
REVOKE ALL ON TABLE products FROM postgres;
GRANT ALL ON TABLE products TO postgres;
GRANT ALL ON TABLE products TO pgadmin;


--
-- Name: seo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE seo FROM PUBLIC;
REVOKE ALL ON TABLE seo FROM postgres;
GRANT ALL ON TABLE seo TO postgres;
GRANT ALL ON TABLE seo TO pgadmin;


--
-- Name: statuses; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE statuses FROM PUBLIC;
REVOKE ALL ON TABLE statuses FROM postgres;
GRANT ALL ON TABLE statuses TO postgres;
GRANT ALL ON TABLE statuses TO pgadmin;


--
-- Name: str; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE str FROM PUBLIC;
REVOKE ALL ON TABLE str FROM postgres;
GRANT ALL ON TABLE str TO postgres;
GRANT ALL ON TABLE str TO pgadmin;


--
-- Name: tags; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tags FROM PUBLIC;
REVOKE ALL ON TABLE tags FROM postgres;
GRANT ALL ON TABLE tags TO postgres;
GRANT ALL ON TABLE tags TO pgadmin;


--
-- Name: users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM postgres;
GRANT ALL ON TABLE users TO postgres;
GRANT ALL ON TABLE users TO pgadmin;


--
-- Name: villas; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE villas FROM PUBLIC;
REVOKE ALL ON TABLE villas FROM postgres;
GRANT ALL ON TABLE villas TO postgres;
GRANT ALL ON TABLE villas TO pgadmin;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO pgadmin;


--
-- PostgreSQL database dump complete
--

