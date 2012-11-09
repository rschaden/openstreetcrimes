--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: layer; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE layer (
    topology_id integer NOT NULL,
    layer_id integer NOT NULL,
    schema_name character varying(255) NOT NULL,
    table_name character varying(255) NOT NULL,
    feature_column character varying(255) NOT NULL,
    feature_type integer NOT NULL,
    level integer DEFAULT 0 NOT NULL,
    child_id integer
);


--
-- Name: raw_crime; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE raw_crime (
    id integer NOT NULL,
    guid character varying(255),
    title character varying(255),
    link character varying(255),
    date timestamp without time zone,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: raw_crime_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE raw_crime_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: raw_crime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE raw_crime_id_seq OWNED BY raw_crime.id;


--
-- Name: raw_crimes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE raw_crimes (
    id integer NOT NULL,
    guid character varying(255),
    title character varying(255),
    link character varying(255),
    date timestamp without time zone,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: raw_crimes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE raw_crimes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: raw_crimes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE raw_crimes_id_seq OWNED BY raw_crimes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: topology; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE topology (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    srid integer NOT NULL,
    "precision" double precision NOT NULL,
    hasz boolean DEFAULT false NOT NULL
);


--
-- Name: topology_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE topology_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE topology_id_seq OWNED BY topology.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY raw_crime ALTER COLUMN id SET DEFAULT nextval('raw_crime_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY raw_crimes ALTER COLUMN id SET DEFAULT nextval('raw_crimes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY topology ALTER COLUMN id SET DEFAULT nextval('topology_id_seq'::regclass);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: raw_crime_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY raw_crime
    ADD CONSTRAINT raw_crime_pkey PRIMARY KEY (id);


--
-- Name: raw_crimes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY raw_crimes
    ADD CONSTRAINT raw_crimes_pkey PRIMARY KEY (id);


--
-- Name: topology_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY topology
    ADD CONSTRAINT topology_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: geometry_columns_delete; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_delete AS ON DELETE TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_insert; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_insert AS ON INSERT TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_update; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_update AS ON UPDATE TO geometry_columns DO INSTEAD NOTHING;


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121108150720');

INSERT INTO schema_migrations (version) VALUES ('20121109223632');