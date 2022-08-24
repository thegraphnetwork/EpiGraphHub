--
-- PostgreSQL database dump
--

-- Dumped from database version 10.19 (Ubuntu 10.19-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.19 (Ubuntu 10.19-0ubuntu0.18.04.1)

\c dev_privatehub

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
-- Name: DATABASE dev_privatehub; Type: COMMENT; Schema: -; Owner: dev_admin
--

COMMENT ON DATABASE dev_privatehub IS 'Database to contain restricted access data.';


--
-- Name: switzerland; Type: SCHEMA; Schema: -; Owner: dev_admin
--

CREATE SCHEMA switzerland;


ALTER SCHEMA switzerland OWNER TO dev_admin;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: plpython3u; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpython3u WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpython3u; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpython3u IS 'PL/Python3U untrusted procedural language';


--
-- Name: plpython3u; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpython3u WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpython3u; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpython3u IS 'PL/PythonU untrusted procedural language';


--
-- Name: plr; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plr WITH SCHEMA public;


--
-- Name: EXTENSION plr; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plr IS 'load R interpreter and execute R script from within a database';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_raster; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS postgis_raster WITH SCHEMA public;


--
-- Name: EXTENSION postgis_raster; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis_raster IS 'PostGIS geometry, geography, and raster spatial types and functions';





SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hug_hosp_data; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.hug_hosp_data (
    index bigint,
    "Date_Entry" text,
    "ID " bigint,
    "Patient_id" text,
    "Week_ID" bigint,
    "Week" bigint,
    "Year" bigint,
    "Date_Exit" text,
    "DOH" double precision,
    "Sex" double precision,
    "Age" text,
    "Current_Hosp" bigint,
    "Death" double precision,
    "Week_ID_death" double precision,
    "Week_death" text,
    "Post_Cov" double precision,
    "Serology" text,
    "Serology_U" text,
    "Serology_C" text,
    "Dropout" text,
    "IMS " double precision,
    "IMS_Cause" text,
    "Vaccination_Swiss" text,
    "Vaccination_Status" text,
    "Vaccin_Type" text,
    "Vaccin_Date_Month" text,
    "Vaccin_Date_Year" text,
    "Time_vax_to_infection" text,
    "Vaccination_3rd_dose" text,
    "Vaccine3_Date_Month" text,
    "Vaccine3_Date_Year" text,
    "Hosp_Ped" double precision,
    "PIMS" double precision,
    "Hosp_Severity" bigint,
    "Hosp_Bed_W44" double precision,
    "Hosp_Bed_W45" double precision,
    "Hosp_Bed_W46" text,
    "Hosp_Bed_W47" double precision,
    "Hosp_Bed_W48" double precision,
    "Hosp_Bed_W49" double precision,
    "Hosp_Bed_W50" double precision,
    "Hosp_Bed_W51" double precision,
    "Hosp_Bed_W52" double precision,
    "ICU_IN" double precision,
    "ICU_OUT" double precision,
    "Cov_Noso" text,
    "Cov_Rap" double precision,
    "Cov_Foreign" double precision,
    "Cov_Country" text,
    "Cov_NH" double precision
);


ALTER TABLE switzerland.hug_hosp_data OWNER TO dev_epigraph;

--
-- Name: ix_switzerland_hug_hosp_data_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_hug_hosp_data_index ON switzerland.hug_hosp_data USING btree (index);


--
-- PostgreSQL database dump complete
--
