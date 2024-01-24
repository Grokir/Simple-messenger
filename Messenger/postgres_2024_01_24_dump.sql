--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying,
    is_delete boolean DEFAULT false NOT NULL
);


ALTER TABLE public.chat OWNER TO postgres;

--
-- Name: history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history (
    id integer NOT NULL,
    chat_id uuid NOT NULL,
    msg_id uuid NOT NULL
);


ALTER TABLE public.history OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.history_id_seq OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;


--
-- Name: msg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.msg (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    message character varying NOT NULL,
    time_message timestamp without time zone DEFAULT now() NOT NULL,
    was_delete boolean DEFAULT false NOT NULL
);


ALTER TABLE public.msg OWNER TO postgres;

--
-- Name: users_in_chat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_in_chat (
    id integer NOT NULL,
    chat_id uuid,
    user_id uuid,
    was_deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users_in_chat OWNER TO postgres;

--
-- Name: uic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.uic_id_seq OWNER TO postgres;

--
-- Name: uic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uic_id_seq OWNED BY public.users_in_chat.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    surname character varying,
    foto bytea,
    password character varying,
    login character varying NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);


--
-- Name: users_in_chat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_in_chat ALTER COLUMN id SET DEFAULT nextval('public.uic_id_seq'::regclass);


--
-- Data for Name: chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat (id, title, is_delete) FROM stdin;
c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	chat1	f
83f3dfef-4f58-4d69-8f50-0029f891194c	chat2	f
4093711b-6299-4550-8450-6679f33bd9fe	NewChat	f
f1d9f8ad-46f5-4e35-9b95-00b78b2fd7a5	TestChat	f
c721778c-3f9a-4dca-853c-c759662c9851	direct	f
5ffbc0e3-5fb3-4b70-bf33-9834e49a0790	TestChat	f
6e27860c-d4af-4c27-9402-d1b7a42bb991	direct	f
31be26c9-b056-4a03-9921-0b82eb67d80d	direct	f
f97eae2f-2cc0-4820-ab2f-1cfcbcb5a9ae	direct	f
2d5c1a72-a484-4445-9a76-a9833b19c66c	direct	f
5a9104d5-19c0-4b1d-8101-ab7e234c3a78	direct	f
2afd6536-8fef-4411-b5df-2c0d6e8d8660	direct	f
c0852115-0f65-4299-9bda-915b6105081b	direct	f
f897c353-cf9a-4396-b602-f8e05f2ac5d8	direct	f
c40ab5c4-82f8-4983-871d-2b2bca786ac1	direct	f
a4b06add-77ce-4dca-bdea-2094554ed19e	direct	f
518d31c7-1e3a-4478-82c5-014ba5f8d825	direct	f
0c4adf7b-43a9-4e79-8348-82f6cfd0c55a	direct	f
1a1b14a0-53e8-4f50-a001-c6803050340e	direct	f
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history (id, chat_id, msg_id) FROM stdin;
1	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	f8816260-afb0-46b7-a72f-eb36132f7db3
2	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	d90ace82-4710-4934-af73-2e4ee3257cc6
3	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	e3e21550-995b-4960-8773-9563165750b4
4	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	6f25a5ee-d899-4a28-9a4d-6380632114a8
5	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	f7ae828b-8993-4a43-a86f-93d20598ff95
6	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	f2bf2a25-ecca-41ee-91ae-cdfeac3f56c7
7	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	7123f848-77c3-42db-9826-8977f6e9a1ca
8	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	66c9c965-0627-4d4e-909c-2e9d5770a0e3
9	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	5f0a5186-0f78-411e-a9a8-73d17977402f
10	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	fc0a8030-2693-4e94-9d2a-881337a61ff2
11	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	fc0a8030-2693-4e94-9d2a-881337a61ff2
12	4093711b-6299-4550-8450-6679f33bd9fe	0a016052-5bc7-41af-93c3-f509177f8f37
16	4093711b-6299-4550-8450-6679f33bd9fe	91b474e3-5612-4825-804a-1f1cd2fb44e2
18	4093711b-6299-4550-8450-6679f33bd9fe	49600f20-7eb3-404f-ae41-bca753e34d5f
19	4093711b-6299-4550-8450-6679f33bd9fe	233dfe7e-c7ba-4c06-a6b6-bfd944594329
20	4093711b-6299-4550-8450-6679f33bd9fe	dd8952da-31ea-4134-974b-561432cd5e0d
21	4093711b-6299-4550-8450-6679f33bd9fe	2b750440-0ff0-4988-a511-7fdf9fa5be87
22	c721778c-3f9a-4dca-853c-c759662c9851	55425d5a-9d6d-45a4-9ca0-aeab9befe1ba
23	c721778c-3f9a-4dca-853c-c759662c9851	830a734a-ea92-4d84-8684-4523ef786a55
31	2afd6536-8fef-4411-b5df-2c0d6e8d8660	d9ae92b7-788d-423f-b243-65ea439d6fd1
33	2afd6536-8fef-4411-b5df-2c0d6e8d8660	d8473aea-e5b0-41c0-97a5-fb628a94d375
34	2afd6536-8fef-4411-b5df-2c0d6e8d8660	9ebf635a-66be-4299-8a75-8807066b5a98
35	2afd6536-8fef-4411-b5df-2c0d6e8d8660	238d3eb1-e245-42c9-82f4-94c8e2980776
36	2afd6536-8fef-4411-b5df-2c0d6e8d8660	f46f8ebb-882b-44b2-a9c9-12786b8e86a5
37	2afd6536-8fef-4411-b5df-2c0d6e8d8660	71bd77e7-1e6e-4398-bead-31ed0a093123
38	2afd6536-8fef-4411-b5df-2c0d6e8d8660	01f35b34-ba3a-4736-8ff6-c8e04c311939
39	2afd6536-8fef-4411-b5df-2c0d6e8d8660	8604f30e-caf8-4472-9976-0b21b4d5274a
40	2afd6536-8fef-4411-b5df-2c0d6e8d8660	48786985-a0c9-4125-9660-ba2eec5ae293
41	2afd6536-8fef-4411-b5df-2c0d6e8d8660	d849b5d7-2617-4328-b213-6295ef94a01a
\.


--
-- Data for Name: msg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.msg (id, user_id, message, time_message, was_delete) FROM stdin;
f8816260-afb0-46b7-a72f-eb36132f7db3	e40356db-86b1-4e84-8421-6b418271e8f1	msg1	2023-10-21 06:53:27.047576	f
d90ace82-4710-4934-af73-2e4ee3257cc6	8aabb47e-90ac-4404-93da-788df76901a9	msg2	2023-10-21 06:53:27.047576	f
e3e21550-995b-4960-8773-9563165750b4	e40356db-86b1-4e84-8421-6b418271e8f1	msg3	2023-10-21 06:53:27.047576	f
6f25a5ee-d899-4a28-9a4d-6380632114a8	8aabb47e-90ac-4404-93da-788df76901a9	msg4	2023-10-21 06:53:27.047576	f
f7ae828b-8993-4a43-a86f-93d20598ff95	e40356db-86b1-4e84-8421-6b418271e8f1	msg5	2023-10-21 06:53:27.047576	f
f2bf2a25-ecca-41ee-91ae-cdfeac3f56c7	8aabb47e-90ac-4404-93da-788df76901a9	msg6	2023-10-21 06:53:27.047576	f
7123f848-77c3-42db-9826-8977f6e9a1ca	e40356db-86b1-4e84-8421-6b418271e8f1	msg7	2023-10-21 06:53:27.047576	f
66c9c965-0627-4d4e-909c-2e9d5770a0e3	8aabb47e-90ac-4404-93da-788df76901a9	msg8	2023-10-21 06:53:27.047576	f
5f0a5186-0f78-411e-a9a8-73d17977402f	e40356db-86b1-4e84-8421-6b418271e8f1	msg9	2023-10-21 06:53:27.047576	f
fc0a8030-2693-4e94-9d2a-881337a61ff2	8aabb47e-90ac-4404-93da-788df76901a9	msg10	2023-10-21 06:53:27.047576	f
0a016052-5bc7-41af-93c3-f509177f8f37	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello world!	2023-12-16 20:49:48.967085	t
91b474e3-5612-4825-804a-1f1cd2fb44e2	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello chat!	2023-12-23 10:29:06.261863	t
49600f20-7eb3-404f-ae41-bca753e34d5f	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello chat!	2023-12-23 19:55:44.583205	t
233dfe7e-c7ba-4c06-a6b6-bfd944594329	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello chat!	2023-12-23 19:55:45.590847	t
dd8952da-31ea-4134-974b-561432cd5e0d	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello chat!	2023-12-23 19:55:48.357263	t
2b750440-0ff0-4988-a511-7fdf9fa5be87	1273d700-736c-4f98-a7ac-bbe9312d20b4	Hello chat!	2023-12-23 19:55:49.619127	t
55425d5a-9d6d-45a4-9ca0-aeab9befe1ba	e40356db-86b1-4e84-8421-6b418271e8f1	Hello C.S.!	2023-12-29 20:14:53.002571	t
830a734a-ea92-4d84-8684-4523ef786a55	e40356db-86b1-4e84-8421-6b418271e8f1	Hello C.S.!	2024-01-07 17:45:51.659118	f
d9ae92b7-788d-423f-b243-65ea439d6fd1	4ea13141-d65e-47fe-8f37-77abd619c7f2	Ку	2024-01-24 15:11:47.399922	f
d8473aea-e5b0-41c0-97a5-fb628a94d375	4ea13141-d65e-47fe-8f37-77abd619c7f2	Как дела??	2024-01-24 15:17:49.801689	f
9ebf635a-66be-4299-8a75-8807066b5a98	4cc646b7-2775-e839-8067-38a3a4efb56d	Дарова!	2024-01-24 16:08:25.375428	f
238d3eb1-e245-42c9-82f4-94c8e2980776	4cc646b7-2775-e839-8067-38a3a4efb56d	Да нормально...\nСам как?	2024-01-24 16:08:37.907147	f
f46f8ebb-882b-44b2-a9c9-12786b8e86a5	4ea13141-d65e-47fe-8f37-77abd619c7f2	Та всё гуд!)\nЗавтра с друзьями едем на природу шашлыки жарить!\nХе))))	2024-01-24 16:24:13.991569	f
71bd77e7-1e6e-4398-bead-31ed0a093123	4cc646b7-2775-e839-8067-38a3a4efb56d	Блииин...\nЯ тоже хочу... т.т	2024-01-24 16:26:40.664996	f
01f35b34-ba3a-4736-8ff6-c8e04c311939	4cc646b7-2775-e839-8067-38a3a4efb56d	Возьмёте с собой??	2024-01-24 16:45:30.965803	f
8604f30e-caf8-4472-9976-0b21b4d5274a	4ea13141-d65e-47fe-8f37-77abd619c7f2	Я у своих спрошу, - напишу.	2024-01-24 16:53:12.185991	f
48786985-a0c9-4125-9660-ba2eec5ae293	4cc646b7-2775-e839-8067-38a3a4efb56d	Ок	2024-01-24 16:54:42.498607	f
d849b5d7-2617-4328-b213-6295ef94a01a	4ea13141-d65e-47fe-8f37-77abd619c7f2	Ок	2024-01-24 17:21:52.653255	f
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, surname, foto, password, login) FROM stdin;
054efe67-9dc8-426e-beb7-c264258d92b0	Petr	Petrov	\N	Petr_pass	Petr_login
0c0d64dd-0c8b-419f-a702-43b435795129	Test	Test	\N	41c4b7ff426f41dae062f949951a67ccf285dc89aada0915d6704d02c2223667	TEST2
e6be2f28-f21b-4aef-a4e1-80535299b57a	Test	Test	\N	af7aa296eece5820c50cd9a72306dbb17f4b403bd1345a37935f5cae24f9758d	TEST3
4ea13141-d65e-47fe-8f37-77abd619c7f2	Grokir		\N	af7aa296eece5820c50cd9a72306dbb17f4b403bd1345a37935f5cae24f9758d	grxkir
1273d700-736c-4f98-a7ac-bbe9312d20b4	Petr	Ivanov	\N	674259d469ced56235384aaf931ad1e62276276bcfe75cf53c750ffb3bab8e2b	Petr_I
4cc646b7-2775-e839-8067-38a3a4efb56d	Ivan	Ivanov	\N	d2122882305f6c51dd7310b9c401e7071c5ea4e238c23d4022dc0336f900bc19	IVA
dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	Pasha	Pavlov	\N	41c4b7ff426f41dae062f949951a67ccf285dc89aada0915d6704d02c2223667	Login
3cce3619-6bdb-4d1b-a84a-7eaa47737de1	User3	User3	\N	\N	usr_3
e40356db-86b1-4e84-8421-6b418271e8f1	User1	User1	\N	\N	usr_1
8aabb47e-90ac-4404-93da-788df76901a9	User2	User2	\N	\N	usr_2
370a8941-5c70-4b4f-a318-7d4ebbcdac18	Petr	Petrovich	\N	pass	PPP 3
d150ca4a-7c79-4b76-ad50-b9e35fde2b7d	DELETED	DELETED	\\xefbbbf	some_pass	some_login
d12e9961-e974-4976-82de-c10a3f084c49	Test user		\N	ee677c8850634d9dfb40d330d2ca61b933e6349c35d233c5bcd8e0cfbe082cd6	TEST
64cb022e-b316-4394-958c-531875bd6949	Test user		\N	7b0f7f0ea6a683723767f9b7fc3bea78ff39c83168837a07a0ed5b80a36c5e69	TEST crypto
711116c2-a8fc-411c-b000-8078ce63564c	Petr	Ivanov	\N	aa539bcd52a093e50dc049ed6e1d3ab79c0a0f5bdbee6384fbda00ea9f7efd29	test_user
\.


--
-- Data for Name: users_in_chat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_in_chat (id, chat_id, user_id, was_deleted) FROM stdin;
1	c663b9b1-7b42-40b9-9cbf-dfcad8ff2a25	e40356db-86b1-4e84-8421-6b418271e8f1	f
58	518d31c7-1e3a-4478-82c5-014ba5f8d825	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
61	0c4adf7b-43a9-4e79-8348-82f6cfd0c55a	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
59	a4b06add-77ce-4dca-bdea-2094554ed19e	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
60	c0852115-0f65-4299-9bda-915b6105081b	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
62	a4b06add-77ce-4dca-bdea-2094554ed19e	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
63	518d31c7-1e3a-4478-82c5-014ba5f8d825	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
64	0c4adf7b-43a9-4e79-8348-82f6cfd0c55a	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
65	c0852115-0f65-4299-9bda-915b6105081b	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
66	c40ab5c4-82f8-4983-871d-2b2bca786ac1	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
67	f897c353-cf9a-4396-b602-f8e05f2ac5d8	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
68	c40ab5c4-82f8-4983-871d-2b2bca786ac1	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
69	f897c353-cf9a-4396-b602-f8e05f2ac5d8	dfbdc128-be1c-468d-8918-5ef2f3d3f7b6	f
70	1a1b14a0-53e8-4f50-a001-c6803050340e	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
2	4093711b-6299-4550-8450-6679f33bd9fe	370a8941-5c70-4b4f-a318-7d4ebbcdac18	f
4	4093711b-6299-4550-8450-6679f33bd9fe	8aabb47e-90ac-4404-93da-788df76901a9	f
71	1a1b14a0-53e8-4f50-a001-c6803050340e	711116c2-a8fc-411c-b000-8078ce63564c	f
6	4093711b-6299-4550-8450-6679f33bd9fe	4cc646b7-2775-e839-8067-38a3a4efb56d	f
3	4093711b-6299-4550-8450-6679f33bd9fe	1273d700-736c-4f98-a7ac-bbe9312d20b4	t
20	c721778c-3f9a-4dca-853c-c759662c9851	e40356db-86b1-4e84-8421-6b418271e8f1	f
5	4093711b-6299-4550-8450-6679f33bd9fe	e40356db-86b1-4e84-8421-6b418271e8f1	f
21	c721778c-3f9a-4dca-853c-c759662c9851	4cc646b7-2775-e839-8067-38a3a4efb56d	f
28	2d5c1a72-a484-4445-9a76-a9833b19c66c	e40356db-86b1-4e84-8421-6b418271e8f1	f
29	2d5c1a72-a484-4445-9a76-a9833b19c66c	4cc646b7-2775-e839-8067-38a3a4efb56d	f
30	5a9104d5-19c0-4b1d-8101-ab7e234c3a78	e40356db-86b1-4e84-8421-6b418271e8f1	f
31	5a9104d5-19c0-4b1d-8101-ab7e234c3a78	4cc646b7-2775-e839-8067-38a3a4efb56d	f
32	2afd6536-8fef-4411-b5df-2c0d6e8d8660	4ea13141-d65e-47fe-8f37-77abd619c7f2	f
33	2afd6536-8fef-4411-b5df-2c0d6e8d8660	4cc646b7-2775-e839-8067-38a3a4efb56d	f
\.


--
-- Name: history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.history_id_seq', 41, true);


--
-- Name: uic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uic_id_seq', 71, true);


--
-- Name: chat chat_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pk PRIMARY KEY (id);


--
-- Name: history history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pk PRIMARY KEY (id);


--
-- Name: msg msg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.msg
    ADD CONSTRAINT msg_pk PRIMARY KEY (id);


--
-- Name: users_in_chat uic_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_in_chat
    ADD CONSTRAINT uic_pk PRIMARY KEY (id);


--
-- Name: user user_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_login_key UNIQUE (login);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: history history_chat_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_chat_id_fk FOREIGN KEY (chat_id) REFERENCES public.chat(id);


--
-- Name: history history_msg_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_msg_id_fk FOREIGN KEY (msg_id) REFERENCES public.msg(id);


--
-- Name: msg msg_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.msg
    ADD CONSTRAINT msg_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: users_in_chat uic_chat_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_in_chat
    ADD CONSTRAINT uic_chat_id_fk FOREIGN KEY (chat_id) REFERENCES public.chat(id);


--
-- Name: users_in_chat uic_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_in_chat
    ADD CONSTRAINT uic_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

