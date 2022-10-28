--
-- PostgreSQL database dump
--

-- Dumped from database version 10.19 (Ubuntu 10.19-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.19 (Ubuntu 10.19-0ubuntu0.18.04.1)

\c dev_epigraphhub

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
-- Name: brasil; Type: SCHEMA; Schema: -; Owner: dev_admin
--

CREATE SCHEMA brasil;


ALTER SCHEMA brasil OWNER TO dev_admin;

--
-- Name: colombia; Type: SCHEMA; Schema: -; Owner: dev_admin
--

CREATE SCHEMA colombia;


ALTER SCHEMA colombia OWNER TO dev_admin;

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
-- Name: caso_full; Type: TABLE; Schema: brasil; Owner: dev_epigraph
--

CREATE TABLE brasil.caso_full (
    index bigint,
    city text,
    city_ibge_code double precision,
    date text,
    epidemiological_week bigint,
    estimated_population double precision,
    estimated_population_2019 double precision,
    is_last boolean,
    is_repeated boolean,
    last_available_confirmed bigint,
    last_available_confirmed_per_100k_inhabitants double precision,
    last_available_date text,
    last_available_death_rate double precision,
    last_available_deaths bigint,
    order_for_place bigint,
    place_type text,
    state text,
    new_confirmed bigint,
    new_deaths bigint
);


ALTER TABLE brasil.caso_full OWNER TO dev_epigraph;

--
-- Name: data_SARI_16_08_21.csv; Type: TABLE; Schema: brasil; Owner: dev_epigraph
--

CREATE TABLE brasil."data_SARI_16_08_21.csv" (
    index bigint,
    "Unnamed: 0" bigint,
    "DT_NOTIFIC" text,
    "SEM_NOT" bigint,
    "DT_SIN_PRI" text,
    "SEM_PRI" bigint,
    "SG_UF_NOT" text,
    "ID_REGIONA" text,
    "CO_REGIONA" double precision,
    "ID_MUNICIP" text,
    "CO_MUN_NOT" bigint,
    "ID_UNIDADE" text,
    "CO_UNI_NOT" bigint,
    "CS_SEXO" text,
    "DT_NASC" text,
    "NU_IDADE_N" bigint,
    "TP_IDADE" bigint,
    "COD_IDADE" text,
    "CS_GESTANT" bigint,
    "CS_RACA" double precision,
    "CS_ETINIA" text,
    "CS_ESCOL_N" double precision,
    "ID_PAIS" text,
    "CO_PAIS" bigint,
    "SG_UF" text,
    "ID_RG_RESI" text,
    "CO_RG_RESI" double precision,
    "ID_MN_RESI" text,
    "CO_MUN_RES" double precision,
    "CS_ZONA" double precision,
    "SURTO_SG" double precision,
    "NOSOCOMIAL" double precision,
    "AVE_SUINO" double precision,
    "FEBRE" double precision,
    "TOSSE" double precision,
    "GARGANTA" double precision,
    "DISPNEIA" double precision,
    "DESC_RESP" double precision,
    "SATURACAO" double precision,
    "DIARREIA" double precision,
    "VOMITO" double precision,
    "OUTRO_SIN" double precision,
    "OUTRO_DES" text,
    "PUERPERA" double precision,
    "FATOR_RISC" text,
    "CARDIOPATI" double precision,
    "HEMATOLOGI" double precision,
    "SIND_DOWN" double precision,
    "HEPATICA" double precision,
    "ASMA" double precision,
    "DIABETES" double precision,
    "NEUROLOGIC" double precision,
    "PNEUMOPATI" double precision,
    "IMUNODEPRE" double precision,
    "RENAL" double precision,
    "OBESIDADE" double precision,
    "OBES_IMC" text,
    "OUT_MORBI" double precision,
    "MORB_DESC" text,
    "VACINA" double precision,
    "DT_UT_DOSE" text,
    "MAE_VAC" double precision,
    "DT_VAC_MAE" text,
    "M_AMAMENTA" double precision,
    "DT_DOSEUNI" text,
    "DT_1_DOSE" text,
    "DT_2_DOSE" text,
    "ANTIVIRAL" double precision,
    "TP_ANTIVIR" double precision,
    "OUT_ANTIV" text,
    "DT_ANTIVIR" text,
    "HOSPITAL" double precision,
    "DT_INTERNA" text,
    "SG_UF_INTE" text,
    "ID_RG_INTE" text,
    "CO_RG_INTE" double precision,
    "ID_MN_INTE" text,
    "CO_MU_INTE" double precision,
    "UTI" double precision,
    "DT_ENTUTI" text,
    "DT_SAIDUTI" text,
    "SUPORT_VEN" double precision,
    "RAIOX_RES" double precision,
    "RAIOX_OUT" text,
    "DT_RAIOX" text,
    "AMOSTRA" double precision,
    "DT_COLETA" text,
    "TP_AMOSTRA" double precision,
    "OUT_AMOST" text,
    "PCR_RESUL" double precision,
    "DT_PCR" text,
    "POS_PCRFLU" double precision,
    "TP_FLU_PCR" double precision,
    "PCR_FLUASU" double precision,
    "FLUASU_OUT" text,
    "PCR_FLUBLI" double precision,
    "FLUBLI_OUT" text,
    "POS_PCROUT" double precision,
    "PCR_VSR" double precision,
    "PCR_PARA1" double precision,
    "PCR_PARA2" double precision,
    "PCR_PARA3" double precision,
    "PCR_PARA4" double precision,
    "PCR_ADENO" double precision,
    "PCR_METAP" double precision,
    "PCR_BOCA" double precision,
    "PCR_RINO" double precision,
    "PCR_OUTRO" double precision,
    "DS_PCR_OUT" text,
    "CLASSI_FIN" double precision,
    "CLASSI_OUT" text,
    "CRITERIO" double precision,
    "EVOLUCAO" double precision,
    "DT_EVOLUCA" text,
    "DT_ENCERRA" text,
    "DT_DIGITA" text,
    "HISTO_VGM" bigint,
    "PAIS_VGM" text,
    "CO_PS_VGM" double precision,
    "LO_PS_VGM" text,
    "DT_VGM" text,
    "DT_RT_VGM" text,
    "PCR_SARS2" double precision,
    "PAC_COCBO" text,
    "PAC_DSCBO" text,
    "OUT_ANIM" text,
    "DOR_ABD" double precision,
    "FADIGA" double precision,
    "PERD_OLFT" double precision,
    "PERD_PALA" double precision,
    "TOMO_RES" double precision,
    "TOMO_OUT" text,
    "DT_TOMO" text,
    "TP_TES_AN" double precision,
    "DT_RES_AN" text,
    "RES_AN" double precision,
    "POS_AN_FLU" double precision,
    "TP_FLU_AN" double precision,
    "POS_AN_OUT" double precision,
    "AN_SARS2" double precision,
    "AN_VSR" double precision,
    "AN_PARA1" double precision,
    "AN_PARA2" double precision,
    "AN_PARA3" double precision,
    "AN_ADENO" double precision,
    "AN_OUTRO" double precision,
    "DS_AN_OUT" text,
    "TP_AM_SOR" double precision,
    "SOR_OUT" text,
    "DT_CO_SOR" text,
    "TP_SOR" double precision,
    "OUT_SOR" text,
    "DT_RES" text,
    "RES_IGG" double precision,
    "RES_IGM" double precision,
    "RES_IGA" double precision,
    "ESTRANG" double precision,
    "VACINA_COV" double precision,
    "DOSE_1_COV" text,
    "DOSE_2_COV" text,
    "LAB_PR_COV" text,
    "LOTE_1_COV" text,
    "LOTE_2_COV" text,
    "FNT_IN_COV" double precision
);


ALTER TABLE brasil."data_SARI_16_08_21.csv" OWNER TO dev_epigraph;

--
-- Name: casos_positivos_covid; Type: TABLE; Schema: colombia; Owner: dev_epigraph
--

CREATE TABLE colombia.casos_positivos_covid (
    index bigint,
    "fecha reporte web" timestamp without time zone,
    "ID de caso" bigint,
    "Fecha de notificación" timestamp without time zone,
    "Código DIVIPOLA departamento" bigint,
    "Nombre departamento" text,
    "Código DIVIPOLA municipio" bigint,
    "Nombre municipio" text,
    "Edad" bigint,
    "Unidad de medida de edad" bigint,
    "Sexo" text,
    "Tipo de contagio" text,
    "Ubicación del caso" text,
    "Estado" text,
    "Código ISO del país" bigint,
    "Nombre del país" text,
    "Recuperado" text,
    "Fecha de inicio de síntomas" timestamp without time zone,
    "Fecha de muerte" timestamp without time zone,
    "Fecha de diagnóstico" timestamp without time zone,
    "Fecha de recuperación" timestamp without time zone,
    "Tipo de recuperación" text,
    "Pertenencia étnica" bigint,
    "Nombre del grupo étnico" text
);


ALTER TABLE colombia.casos_positivos_covid OWNER TO dev_epigraph;

CREATE TABLE colombia.casos_positivos_covid_d ( LIKE colombia.casos_positivos_covid );

--
-- Name: ABW_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ABW_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ABW_0" OWNER TO dev_epigraph;

--
-- Name: AFG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AFG_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AFG_0" OWNER TO dev_epigraph;

--
-- Name: AFG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AFG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AFG_1" OWNER TO dev_epigraph;

--
-- Name: AFG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AFG_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AFG_2" OWNER TO dev_epigraph;

--
-- Name: AGO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AGO_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AGO_0" OWNER TO dev_epigraph;

--
-- Name: AGO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AGO_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AGO_1" OWNER TO dev_epigraph;

--
-- Name: AGO_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AGO_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AGO_2" OWNER TO dev_epigraph;

--
-- Name: AGO_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AGO_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AGO_3" OWNER TO dev_epigraph;

--
-- Name: AIA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AIA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AIA_0" OWNER TO dev_epigraph;

--
-- Name: ALA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALA_0" OWNER TO dev_epigraph;

--
-- Name: ALA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALA_1" OWNER TO dev_epigraph;

--
-- Name: ALB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALB_0" OWNER TO dev_epigraph;

--
-- Name: ALB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALB_1" OWNER TO dev_epigraph;

--
-- Name: ALB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALB_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALB_2" OWNER TO dev_epigraph;

--
-- Name: ALB_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ALB_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ALB_3" OWNER TO dev_epigraph;

--
-- Name: AND_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AND_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AND_0" OWNER TO dev_epigraph;

--
-- Name: AND_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AND_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AND_1" OWNER TO dev_epigraph;

--
-- Name: ARE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARE_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARE_0" OWNER TO dev_epigraph;

--
-- Name: ARE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARE_1" OWNER TO dev_epigraph;

--
-- Name: ARE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARE_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARE_2" OWNER TO dev_epigraph;

--
-- Name: ARE_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARE_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARE_3" OWNER TO dev_epigraph;

--
-- Name: ARG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARG_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARG_0" OWNER TO dev_epigraph;

--
-- Name: ARG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARG_1" OWNER TO dev_epigraph;

--
-- Name: ARG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARG_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARG_2" OWNER TO dev_epigraph;

--
-- Name: ARM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARM_0" OWNER TO dev_epigraph;

--
-- Name: ARM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ARM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ARM_1" OWNER TO dev_epigraph;

--
-- Name: ASM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ASM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ASM_0" OWNER TO dev_epigraph;

--
-- Name: ASM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ASM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ASM_1" OWNER TO dev_epigraph;

--
-- Name: ASM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ASM_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ASM_2" OWNER TO dev_epigraph;

--
-- Name: ASM_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ASM_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ASM_3" OWNER TO dev_epigraph;

--
-- Name: ATA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ATA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ATA_0" OWNER TO dev_epigraph;

--
-- Name: ATF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ATF_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ATF_0" OWNER TO dev_epigraph;

--
-- Name: ATF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ATF_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ATF_1" OWNER TO dev_epigraph;

--
-- Name: ATG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ATG_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ATG_0" OWNER TO dev_epigraph;

--
-- Name: ATG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ATG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ATG_1" OWNER TO dev_epigraph;

--
-- Name: AUS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUS_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUS_0" OWNER TO dev_epigraph;

--
-- Name: AUS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUS_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUS_1" OWNER TO dev_epigraph;

--
-- Name: AUS_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUS_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUS_2" OWNER TO dev_epigraph;

--
-- Name: AUT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUT_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUT_0" OWNER TO dev_epigraph;

--
-- Name: AUT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUT_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUT_1" OWNER TO dev_epigraph;

--
-- Name: AUT_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUT_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUT_2" OWNER TO dev_epigraph;

--
-- Name: AUT_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AUT_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AUT_3" OWNER TO dev_epigraph;

--
-- Name: AZE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AZE_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AZE_0" OWNER TO dev_epigraph;

--
-- Name: AZE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AZE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AZE_1" OWNER TO dev_epigraph;

--
-- Name: AZE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."AZE_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."AZE_2" OWNER TO dev_epigraph;

--
-- Name: BDI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BDI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BDI_0" OWNER TO dev_epigraph;

--
-- Name: BDI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BDI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BDI_1" OWNER TO dev_epigraph;

--
-- Name: BDI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BDI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BDI_2" OWNER TO dev_epigraph;

--
-- Name: BDI_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BDI_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BDI_3" OWNER TO dev_epigraph;

--
-- Name: BDI_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BDI_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BDI_4" OWNER TO dev_epigraph;

--
-- Name: BEL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEL_0" OWNER TO dev_epigraph;

--
-- Name: BEL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEL_1" OWNER TO dev_epigraph;

--
-- Name: BEL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEL_2" OWNER TO dev_epigraph;

--
-- Name: BEL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEL_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEL_3" OWNER TO dev_epigraph;

--
-- Name: BEL_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEL_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEL_4" OWNER TO dev_epigraph;

--
-- Name: BEN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEN_0" OWNER TO dev_epigraph;

--
-- Name: BEN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEN_1" OWNER TO dev_epigraph;

--
-- Name: BEN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BEN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BEN_2" OWNER TO dev_epigraph;

--
-- Name: BFA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BFA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BFA_0" OWNER TO dev_epigraph;

--
-- Name: BFA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BFA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BFA_1" OWNER TO dev_epigraph;

--
-- Name: BFA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BFA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BFA_2" OWNER TO dev_epigraph;

--
-- Name: BFA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BFA_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BFA_3" OWNER TO dev_epigraph;

--
-- Name: BGD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGD_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGD_0" OWNER TO dev_epigraph;

--
-- Name: BGD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGD_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGD_1" OWNER TO dev_epigraph;

--
-- Name: BGD_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGD_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGD_2" OWNER TO dev_epigraph;

--
-- Name: BGD_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGD_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGD_3" OWNER TO dev_epigraph;

--
-- Name: BGD_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGD_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGD_4" OWNER TO dev_epigraph;

--
-- Name: BGR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGR_0" OWNER TO dev_epigraph;

--
-- Name: BGR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGR_1" OWNER TO dev_epigraph;

--
-- Name: BGR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BGR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BGR_2" OWNER TO dev_epigraph;

--
-- Name: BHR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BHR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BHR_0" OWNER TO dev_epigraph;

--
-- Name: BHR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BHR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BHR_1" OWNER TO dev_epigraph;

--
-- Name: BHS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BHS_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BHS_0" OWNER TO dev_epigraph;

--
-- Name: BHS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BHS_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BHS_1" OWNER TO dev_epigraph;

--
-- Name: BIH_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BIH_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BIH_0" OWNER TO dev_epigraph;

--
-- Name: BIH_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BIH_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BIH_1" OWNER TO dev_epigraph;

--
-- Name: BIH_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BIH_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BIH_2" OWNER TO dev_epigraph;

--
-- Name: BIH_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BIH_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BIH_3" OWNER TO dev_epigraph;

--
-- Name: BLM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLM_0" OWNER TO dev_epigraph;

--
-- Name: BLR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLR_0" OWNER TO dev_epigraph;

--
-- Name: BLR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLR_1" OWNER TO dev_epigraph;

--
-- Name: BLR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLR_2" OWNER TO dev_epigraph;

--
-- Name: BLZ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLZ_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLZ_0" OWNER TO dev_epigraph;

--
-- Name: BLZ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BLZ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BLZ_1" OWNER TO dev_epigraph;

--
-- Name: BMU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BMU_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BMU_0" OWNER TO dev_epigraph;

--
-- Name: BMU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BMU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BMU_1" OWNER TO dev_epigraph;

--
-- Name: BOL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BOL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BOL_0" OWNER TO dev_epigraph;

--
-- Name: BOL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BOL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BOL_1" OWNER TO dev_epigraph;

--
-- Name: BOL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BOL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BOL_2" OWNER TO dev_epigraph;

--
-- Name: BOL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BOL_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BOL_3" OWNER TO dev_epigraph;

--
-- Name: BRA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRA_0" OWNER TO dev_epigraph;

--
-- Name: BRA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRA_1" OWNER TO dev_epigraph;

--
-- Name: BRA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRA_2" OWNER TO dev_epigraph;

--
-- Name: BRA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRA_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRA_3" OWNER TO dev_epigraph;

--
-- Name: BRB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRB_0" OWNER TO dev_epigraph;

--
-- Name: BRB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRB_1" OWNER TO dev_epigraph;

--
-- Name: BRN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRN_0" OWNER TO dev_epigraph;

--
-- Name: BRN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRN_1" OWNER TO dev_epigraph;

--
-- Name: BRN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BRN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BRN_2" OWNER TO dev_epigraph;

--
-- Name: BTN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BTN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BTN_0" OWNER TO dev_epigraph;

--
-- Name: BTN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BTN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BTN_1" OWNER TO dev_epigraph;

--
-- Name: BTN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BTN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BTN_2" OWNER TO dev_epigraph;

--
-- Name: BVT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BVT_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BVT_0" OWNER TO dev_epigraph;

--
-- Name: BWA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BWA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BWA_0" OWNER TO dev_epigraph;

--
-- Name: BWA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BWA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BWA_1" OWNER TO dev_epigraph;

--
-- Name: BWA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."BWA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."BWA_2" OWNER TO dev_epigraph;

--
-- Name: CAF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAF_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAF_0" OWNER TO dev_epigraph;

--
-- Name: CAF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAF_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAF_1" OWNER TO dev_epigraph;

--
-- Name: CAF_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAF_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAF_2" OWNER TO dev_epigraph;

--
-- Name: CAN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAN_0" OWNER TO dev_epigraph;

--
-- Name: CAN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAN_1" OWNER TO dev_epigraph;

--
-- Name: CAN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAN_2" OWNER TO dev_epigraph;

--
-- Name: CAN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CAN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CAN_3" OWNER TO dev_epigraph;

--
-- Name: CCK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CCK_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CCK_0" OWNER TO dev_epigraph;

--
-- Name: CHE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHE_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHE_0" OWNER TO dev_epigraph;

--
-- Name: CHE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHE_1" OWNER TO dev_epigraph;

--
-- Name: CHE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHE_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHE_2" OWNER TO dev_epigraph;

--
-- Name: CHE_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHE_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHE_3" OWNER TO dev_epigraph;

--
-- Name: CHL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHL_0" OWNER TO dev_epigraph;

--
-- Name: CHL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHL_1" OWNER TO dev_epigraph;

--
-- Name: CHL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHL_2" OWNER TO dev_epigraph;

--
-- Name: CHL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHL_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHL_3" OWNER TO dev_epigraph;

--
-- Name: CHN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHN_0" OWNER TO dev_epigraph;

--
-- Name: CHN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHN_1" OWNER TO dev_epigraph;

--
-- Name: CHN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHN_2" OWNER TO dev_epigraph;

--
-- Name: CHN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CHN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CHN_3" OWNER TO dev_epigraph;

--
-- Name: CIV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CIV_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CIV_0" OWNER TO dev_epigraph;

--
-- Name: CIV_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CIV_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CIV_1" OWNER TO dev_epigraph;

--
-- Name: CIV_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CIV_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CIV_2" OWNER TO dev_epigraph;

--
-- Name: CIV_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CIV_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CIV_3" OWNER TO dev_epigraph;

--
-- Name: CIV_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CIV_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CIV_4" OWNER TO dev_epigraph;

--
-- Name: CMR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CMR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CMR_0" OWNER TO dev_epigraph;

--
-- Name: CMR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CMR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CMR_1" OWNER TO dev_epigraph;

--
-- Name: CMR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CMR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CMR_2" OWNER TO dev_epigraph;

--
-- Name: CMR_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CMR_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CMR_3" OWNER TO dev_epigraph;

--
-- Name: COD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COD_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COD_0" OWNER TO dev_epigraph;

--
-- Name: COD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COD_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COD_1" OWNER TO dev_epigraph;

--
-- Name: COD_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COD_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COD_2" OWNER TO dev_epigraph;

--
-- Name: COG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COG_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COG_0" OWNER TO dev_epigraph;

--
-- Name: COG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COG_1" OWNER TO dev_epigraph;

--
-- Name: COG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COG_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COG_2" OWNER TO dev_epigraph;

--
-- Name: COK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COK_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COK_0" OWNER TO dev_epigraph;

--
-- Name: COL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COL_0" OWNER TO dev_epigraph;

--
-- Name: COL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COL_1" OWNER TO dev_epigraph;

--
-- Name: COL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COL_2" OWNER TO dev_epigraph;

--
-- Name: COM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COM_0" OWNER TO dev_epigraph;

--
-- Name: COM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."COM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."COM_1" OWNER TO dev_epigraph;

--
-- Name: CPV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CPV_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CPV_0" OWNER TO dev_epigraph;

--
-- Name: CPV_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CPV_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CPV_1" OWNER TO dev_epigraph;

--
-- Name: CRI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CRI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CRI_0" OWNER TO dev_epigraph;

--
-- Name: CRI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CRI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CRI_1" OWNER TO dev_epigraph;

--
-- Name: CRI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CRI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CRI_2" OWNER TO dev_epigraph;

--
-- Name: CUB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CUB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CUB_0" OWNER TO dev_epigraph;

--
-- Name: CUB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CUB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CUB_1" OWNER TO dev_epigraph;

--
-- Name: CUB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CUB_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CUB_2" OWNER TO dev_epigraph;

--
-- Name: CXR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CXR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CXR_0" OWNER TO dev_epigraph;

--
-- Name: CYM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CYM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CYM_0" OWNER TO dev_epigraph;

--
-- Name: CYM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CYM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CYM_1" OWNER TO dev_epigraph;

--
-- Name: CYP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CYP_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CYP_0" OWNER TO dev_epigraph;

--
-- Name: CYP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CYP_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CYP_1" OWNER TO dev_epigraph;

--
-- Name: CZE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CZE_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CZE_0" OWNER TO dev_epigraph;

--
-- Name: CZE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CZE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CZE_1" OWNER TO dev_epigraph;

--
-- Name: CZE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."CZE_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."CZE_2" OWNER TO dev_epigraph;

--
-- Name: DEU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DEU_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DEU_0" OWNER TO dev_epigraph;

--
-- Name: DEU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DEU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DEU_1" OWNER TO dev_epigraph;

--
-- Name: DEU_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DEU_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DEU_2" OWNER TO dev_epigraph;

--
-- Name: DEU_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DEU_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DEU_3" OWNER TO dev_epigraph;

--
-- Name: DEU_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DEU_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DEU_4" OWNER TO dev_epigraph;

--
-- Name: DJI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DJI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DJI_0" OWNER TO dev_epigraph;

--
-- Name: DJI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DJI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DJI_1" OWNER TO dev_epigraph;

--
-- Name: DJI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DJI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DJI_2" OWNER TO dev_epigraph;

--
-- Name: DMA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DMA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DMA_0" OWNER TO dev_epigraph;

--
-- Name: DMA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DMA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DMA_1" OWNER TO dev_epigraph;

--
-- Name: DNK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DNK_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DNK_0" OWNER TO dev_epigraph;

--
-- Name: DNK_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DNK_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DNK_1" OWNER TO dev_epigraph;

--
-- Name: DNK_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DNK_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DNK_2" OWNER TO dev_epigraph;

--
-- Name: DOM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DOM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DOM_0" OWNER TO dev_epigraph;

--
-- Name: DOM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DOM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DOM_1" OWNER TO dev_epigraph;

--
-- Name: DOM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DOM_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DOM_2" OWNER TO dev_epigraph;

--
-- Name: DZA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DZA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DZA_0" OWNER TO dev_epigraph;

--
-- Name: DZA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DZA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DZA_1" OWNER TO dev_epigraph;

--
-- Name: DZA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."DZA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."DZA_2" OWNER TO dev_epigraph;

--
-- Name: ECU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ECU_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ECU_0" OWNER TO dev_epigraph;

--
-- Name: ECU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ECU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ECU_1" OWNER TO dev_epigraph;

--
-- Name: ECU_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ECU_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ECU_2" OWNER TO dev_epigraph;

--
-- Name: ECU_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ECU_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ECU_3" OWNER TO dev_epigraph;

--
-- Name: EGY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EGY_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EGY_0" OWNER TO dev_epigraph;

--
-- Name: EGY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EGY_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EGY_1" OWNER TO dev_epigraph;

--
-- Name: EGY_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EGY_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EGY_2" OWNER TO dev_epigraph;

--
-- Name: ERI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ERI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ERI_0" OWNER TO dev_epigraph;

--
-- Name: ERI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ERI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ERI_1" OWNER TO dev_epigraph;

--
-- Name: ERI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ERI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ERI_2" OWNER TO dev_epigraph;

--
-- Name: ESH_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESH_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESH_0" OWNER TO dev_epigraph;

--
-- Name: ESH_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESH_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESH_1" OWNER TO dev_epigraph;

--
-- Name: ESP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESP_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESP_0" OWNER TO dev_epigraph;

--
-- Name: ESP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESP_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESP_1" OWNER TO dev_epigraph;

--
-- Name: ESP_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESP_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESP_2" OWNER TO dev_epigraph;

--
-- Name: ESP_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESP_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESP_3" OWNER TO dev_epigraph;

--
-- Name: ESP_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ESP_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ESP_4" OWNER TO dev_epigraph;

--
-- Name: EST_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EST_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EST_0" OWNER TO dev_epigraph;

--
-- Name: EST_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EST_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EST_1" OWNER TO dev_epigraph;

--
-- Name: EST_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EST_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EST_2" OWNER TO dev_epigraph;

--
-- Name: EST_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."EST_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."EST_3" OWNER TO dev_epigraph;

--
-- Name: ETH_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ETH_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ETH_0" OWNER TO dev_epigraph;

--
-- Name: ETH_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ETH_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ETH_1" OWNER TO dev_epigraph;

--
-- Name: ETH_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ETH_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ETH_2" OWNER TO dev_epigraph;

--
-- Name: ETH_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ETH_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ETH_3" OWNER TO dev_epigraph;

--
-- Name: FIN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FIN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FIN_0" OWNER TO dev_epigraph;

--
-- Name: FIN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FIN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FIN_1" OWNER TO dev_epigraph;

--
-- Name: FIN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FIN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FIN_2" OWNER TO dev_epigraph;

--
-- Name: FIN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FIN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FIN_3" OWNER TO dev_epigraph;

--
-- Name: FIN_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FIN_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FIN_4" OWNER TO dev_epigraph;

--
-- Name: FJI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FJI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FJI_0" OWNER TO dev_epigraph;

--
-- Name: FJI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FJI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FJI_1" OWNER TO dev_epigraph;

--
-- Name: FJI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FJI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FJI_2" OWNER TO dev_epigraph;

--
-- Name: FLK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FLK_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FLK_0" OWNER TO dev_epigraph;

--
-- Name: FRA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_0" OWNER TO dev_epigraph;

--
-- Name: FRA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_1" OWNER TO dev_epigraph;

--
-- Name: FRA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_2" OWNER TO dev_epigraph;

--
-- Name: FRA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_3" OWNER TO dev_epigraph;

--
-- Name: FRA_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_4" OWNER TO dev_epigraph;

--
-- Name: FRA_5; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRA_5" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "GID_5" text,
    "NAME_5" text,
    "TYPE_5" text,
    "ENGTYPE_5" text,
    "CC_5" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRA_5" OWNER TO dev_epigraph;

--
-- Name: FRO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRO_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRO_0" OWNER TO dev_epigraph;

--
-- Name: FRO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRO_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRO_1" OWNER TO dev_epigraph;

--
-- Name: FRO_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FRO_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FRO_2" OWNER TO dev_epigraph;

--
-- Name: FSM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FSM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FSM_0" OWNER TO dev_epigraph;

--
-- Name: FSM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."FSM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."FSM_1" OWNER TO dev_epigraph;

--
-- Name: GAB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GAB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GAB_0" OWNER TO dev_epigraph;

--
-- Name: GAB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GAB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GAB_1" OWNER TO dev_epigraph;

--
-- Name: GAB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GAB_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GAB_2" OWNER TO dev_epigraph;

--
-- Name: GBR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GBR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GBR_0" OWNER TO dev_epigraph;

--
-- Name: GBR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GBR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GBR_1" OWNER TO dev_epigraph;

--
-- Name: GBR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GBR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GBR_2" OWNER TO dev_epigraph;

--
-- Name: GBR_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GBR_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GBR_3" OWNER TO dev_epigraph;

--
-- Name: GEO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GEO_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GEO_0" OWNER TO dev_epigraph;

--
-- Name: GEO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GEO_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GEO_1" OWNER TO dev_epigraph;

--
-- Name: GEO_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GEO_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GEO_2" OWNER TO dev_epigraph;

--
-- Name: GGY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GGY_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GGY_0" OWNER TO dev_epigraph;

--
-- Name: GGY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GGY_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GGY_1" OWNER TO dev_epigraph;

--
-- Name: GHA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GHA_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GHA_0" OWNER TO dev_epigraph;

--
-- Name: GHA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GHA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GHA_1" OWNER TO dev_epigraph;

--
-- Name: GHA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GHA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GHA_2" OWNER TO dev_epigraph;

--
-- Name: GIB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GIB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GIB_0" OWNER TO dev_epigraph;

--
-- Name: GIN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GIN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GIN_0" OWNER TO dev_epigraph;

--
-- Name: GIN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GIN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GIN_1" OWNER TO dev_epigraph;

--
-- Name: GIN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GIN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GIN_2" OWNER TO dev_epigraph;

--
-- Name: GIN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GIN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GIN_3" OWNER TO dev_epigraph;

--
-- Name: GLP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GLP_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GLP_0" OWNER TO dev_epigraph;

--
-- Name: GLP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GLP_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GLP_1" OWNER TO dev_epigraph;

--
-- Name: GLP_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GLP_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GLP_2" OWNER TO dev_epigraph;

--
-- Name: GMB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GMB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GMB_0" OWNER TO dev_epigraph;

--
-- Name: GMB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GMB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GMB_1" OWNER TO dev_epigraph;

--
-- Name: GMB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GMB_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GMB_2" OWNER TO dev_epigraph;

--
-- Name: GNB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNB_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNB_0" OWNER TO dev_epigraph;

--
-- Name: GNB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNB_1" OWNER TO dev_epigraph;

--
-- Name: GNB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNB_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNB_2" OWNER TO dev_epigraph;

--
-- Name: GNQ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNQ_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNQ_0" OWNER TO dev_epigraph;

--
-- Name: GNQ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNQ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNQ_1" OWNER TO dev_epigraph;

--
-- Name: GNQ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GNQ_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GNQ_2" OWNER TO dev_epigraph;

--
-- Name: GRC_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRC_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRC_0" OWNER TO dev_epigraph;

--
-- Name: GRC_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRC_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRC_1" OWNER TO dev_epigraph;

--
-- Name: GRC_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRC_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRC_2" OWNER TO dev_epigraph;

--
-- Name: GRC_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRC_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRC_3" OWNER TO dev_epigraph;

--
-- Name: GRD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRD_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRD_0" OWNER TO dev_epigraph;

--
-- Name: GRD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRD_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRD_1" OWNER TO dev_epigraph;

--
-- Name: GRL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRL_0" OWNER TO dev_epigraph;

--
-- Name: GRL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GRL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GRL_1" OWNER TO dev_epigraph;

--
-- Name: GTM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GTM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GTM_0" OWNER TO dev_epigraph;

--
-- Name: GTM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GTM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GTM_1" OWNER TO dev_epigraph;

--
-- Name: GTM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GTM_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GTM_2" OWNER TO dev_epigraph;

--
-- Name: GUF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUF_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUF_0" OWNER TO dev_epigraph;

--
-- Name: GUF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUF_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUF_1" OWNER TO dev_epigraph;

--
-- Name: GUF_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUF_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUF_2" OWNER TO dev_epigraph;

--
-- Name: GUM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUM_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUM_0" OWNER TO dev_epigraph;

--
-- Name: GUM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUM_1" OWNER TO dev_epigraph;

--
-- Name: GUY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUY_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUY_0" OWNER TO dev_epigraph;

--
-- Name: GUY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUY_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUY_1" OWNER TO dev_epigraph;

--
-- Name: GUY_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."GUY_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."GUY_2" OWNER TO dev_epigraph;

--
-- Name: HKG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HKG_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HKG_0" OWNER TO dev_epigraph;

--
-- Name: HKG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HKG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HKG_1" OWNER TO dev_epigraph;

--
-- Name: HMD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HMD_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HMD_0" OWNER TO dev_epigraph;

--
-- Name: HND_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HND_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HND_0" OWNER TO dev_epigraph;

--
-- Name: HND_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HND_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HND_1" OWNER TO dev_epigraph;

--
-- Name: HND_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HND_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HND_2" OWNER TO dev_epigraph;

--
-- Name: HRV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HRV_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HRV_0" OWNER TO dev_epigraph;

--
-- Name: HRV_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HRV_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HRV_1" OWNER TO dev_epigraph;

--
-- Name: HRV_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HRV_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HRV_2" OWNER TO dev_epigraph;

--
-- Name: HTI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HTI_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HTI_0" OWNER TO dev_epigraph;

--
-- Name: HTI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HTI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HTI_1" OWNER TO dev_epigraph;

--
-- Name: HTI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HTI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HTI_2" OWNER TO dev_epigraph;

--
-- Name: HTI_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HTI_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HTI_3" OWNER TO dev_epigraph;

--
-- Name: HTI_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HTI_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HTI_4" OWNER TO dev_epigraph;

--
-- Name: HUN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HUN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HUN_0" OWNER TO dev_epigraph;

--
-- Name: HUN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HUN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HUN_1" OWNER TO dev_epigraph;

--
-- Name: HUN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."HUN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."HUN_2" OWNER TO dev_epigraph;

--
-- Name: IDN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IDN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IDN_0" OWNER TO dev_epigraph;

--
-- Name: IDN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IDN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IDN_1" OWNER TO dev_epigraph;

--
-- Name: IDN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IDN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IDN_2" OWNER TO dev_epigraph;

--
-- Name: IDN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IDN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IDN_3" OWNER TO dev_epigraph;

--
-- Name: IDN_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IDN_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IDN_4" OWNER TO dev_epigraph;

--
-- Name: IMN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IMN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IMN_0" OWNER TO dev_epigraph;

--
-- Name: IMN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IMN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IMN_1" OWNER TO dev_epigraph;

--
-- Name: IMN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IMN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IMN_2" OWNER TO dev_epigraph;

--
-- Name: IND_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IND_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IND_0" OWNER TO dev_epigraph;

--
-- Name: IND_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IND_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IND_1" OWNER TO dev_epigraph;

--
-- Name: IND_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IND_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IND_2" OWNER TO dev_epigraph;

--
-- Name: IND_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IND_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IND_3" OWNER TO dev_epigraph;

--
-- Name: IOT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IOT_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IOT_0" OWNER TO dev_epigraph;

--
-- Name: IRL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRL_0" OWNER TO dev_epigraph;

--
-- Name: IRL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRL_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRL_1" OWNER TO dev_epigraph;

--
-- Name: IRN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRN_0" OWNER TO dev_epigraph;

--
-- Name: IRN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRN_1" OWNER TO dev_epigraph;

--
-- Name: IRN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRN_2" OWNER TO dev_epigraph;

--
-- Name: IRQ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRQ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRQ_0" OWNER TO dev_epigraph;

--
-- Name: IRQ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRQ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRQ_1" OWNER TO dev_epigraph;

--
-- Name: IRQ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."IRQ_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."IRQ_2" OWNER TO dev_epigraph;

--
-- Name: ISL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ISL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ISL_0" OWNER TO dev_epigraph;

--
-- Name: ISL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ISL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ISL_1" OWNER TO dev_epigraph;

--
-- Name: ISL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ISL_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ISL_2" OWNER TO dev_epigraph;

--
-- Name: ISR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ISR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ISR_0" OWNER TO dev_epigraph;

--
-- Name: ISR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ISR_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ISR_1" OWNER TO dev_epigraph;

--
-- Name: ITA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ITA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ITA_0" OWNER TO dev_epigraph;

--
-- Name: ITA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ITA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ITA_1" OWNER TO dev_epigraph;

--
-- Name: ITA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ITA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ITA_2" OWNER TO dev_epigraph;

--
-- Name: ITA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ITA_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ITA_3" OWNER TO dev_epigraph;

--
-- Name: JAM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JAM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JAM_0" OWNER TO dev_epigraph;

--
-- Name: JAM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JAM_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JAM_1" OWNER TO dev_epigraph;

--
-- Name: JEY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JEY_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JEY_0" OWNER TO dev_epigraph;

--
-- Name: JEY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JEY_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JEY_1" OWNER TO dev_epigraph;

--
-- Name: JOR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JOR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JOR_0" OWNER TO dev_epigraph;

--
-- Name: JOR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JOR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JOR_1" OWNER TO dev_epigraph;

--
-- Name: JOR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JOR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JOR_2" OWNER TO dev_epigraph;

--
-- Name: JPN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JPN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JPN_0" OWNER TO dev_epigraph;

--
-- Name: JPN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JPN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JPN_1" OWNER TO dev_epigraph;

--
-- Name: JPN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."JPN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."JPN_2" OWNER TO dev_epigraph;

--
-- Name: KAZ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KAZ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KAZ_0" OWNER TO dev_epigraph;

--
-- Name: KAZ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KAZ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KAZ_1" OWNER TO dev_epigraph;

--
-- Name: KAZ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KAZ_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KAZ_2" OWNER TO dev_epigraph;

--
-- Name: KEN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KEN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KEN_0" OWNER TO dev_epigraph;

--
-- Name: KEN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KEN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KEN_1" OWNER TO dev_epigraph;

--
-- Name: KEN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KEN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KEN_2" OWNER TO dev_epigraph;

--
-- Name: KEN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KEN_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KEN_3" OWNER TO dev_epigraph;

--
-- Name: KGZ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KGZ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KGZ_0" OWNER TO dev_epigraph;

--
-- Name: KGZ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KGZ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KGZ_1" OWNER TO dev_epigraph;

--
-- Name: KGZ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KGZ_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KGZ_2" OWNER TO dev_epigraph;

--
-- Name: KHM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KHM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KHM_0" OWNER TO dev_epigraph;

--
-- Name: KHM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KHM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KHM_1" OWNER TO dev_epigraph;

--
-- Name: KHM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KHM_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KHM_2" OWNER TO dev_epigraph;

--
-- Name: KHM_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KHM_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KHM_3" OWNER TO dev_epigraph;

--
-- Name: KHM_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KHM_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KHM_4" OWNER TO dev_epigraph;

--
-- Name: KIR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KIR_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KIR_0" OWNER TO dev_epigraph;

--
-- Name: KNA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KNA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KNA_0" OWNER TO dev_epigraph;

--
-- Name: KNA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KNA_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KNA_1" OWNER TO dev_epigraph;

--
-- Name: KOR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KOR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KOR_0" OWNER TO dev_epigraph;

--
-- Name: KOR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KOR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KOR_1" OWNER TO dev_epigraph;

--
-- Name: KOR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KOR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KOR_2" OWNER TO dev_epigraph;

--
-- Name: KWT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KWT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KWT_0" OWNER TO dev_epigraph;

--
-- Name: KWT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."KWT_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."KWT_1" OWNER TO dev_epigraph;

--
-- Name: LAO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LAO_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LAO_0" OWNER TO dev_epigraph;

--
-- Name: LAO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LAO_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LAO_1" OWNER TO dev_epigraph;

--
-- Name: LAO_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LAO_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LAO_2" OWNER TO dev_epigraph;

--
-- Name: LBN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBN_0" OWNER TO dev_epigraph;

--
-- Name: LBN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBN_1" OWNER TO dev_epigraph;

--
-- Name: LBN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBN_2" OWNER TO dev_epigraph;

--
-- Name: LBN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBN_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBN_3" OWNER TO dev_epigraph;

--
-- Name: LBR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBR_0" OWNER TO dev_epigraph;

--
-- Name: LBR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBR_1" OWNER TO dev_epigraph;

--
-- Name: LBR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBR_2" OWNER TO dev_epigraph;

--
-- Name: LBR_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBR_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBR_3" OWNER TO dev_epigraph;

--
-- Name: LBY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBY_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBY_0" OWNER TO dev_epigraph;

--
-- Name: LBY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LBY_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LBY_1" OWNER TO dev_epigraph;

--
-- Name: LCA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LCA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LCA_0" OWNER TO dev_epigraph;

--
-- Name: LCA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LCA_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LCA_1" OWNER TO dev_epigraph;

--
-- Name: LIE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LIE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LIE_0" OWNER TO dev_epigraph;

--
-- Name: LIE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LIE_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LIE_1" OWNER TO dev_epigraph;

--
-- Name: LKA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LKA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LKA_0" OWNER TO dev_epigraph;

--
-- Name: LKA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LKA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LKA_1" OWNER TO dev_epigraph;

--
-- Name: LKA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LKA_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LKA_2" OWNER TO dev_epigraph;

--
-- Name: LSO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LSO_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LSO_0" OWNER TO dev_epigraph;

--
-- Name: LSO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LSO_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LSO_1" OWNER TO dev_epigraph;

--
-- Name: LTU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LTU_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LTU_0" OWNER TO dev_epigraph;

--
-- Name: LTU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LTU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LTU_1" OWNER TO dev_epigraph;

--
-- Name: LTU_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LTU_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LTU_2" OWNER TO dev_epigraph;

--
-- Name: LUX_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LUX_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LUX_0" OWNER TO dev_epigraph;

--
-- Name: LUX_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LUX_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LUX_1" OWNER TO dev_epigraph;

--
-- Name: LUX_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LUX_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LUX_2" OWNER TO dev_epigraph;

--
-- Name: LUX_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LUX_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LUX_3" OWNER TO dev_epigraph;

--
-- Name: LUX_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LUX_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LUX_4" OWNER TO dev_epigraph;

--
-- Name: LVA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LVA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LVA_0" OWNER TO dev_epigraph;

--
-- Name: LVA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LVA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LVA_1" OWNER TO dev_epigraph;

--
-- Name: LVA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."LVA_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."LVA_2" OWNER TO dev_epigraph;

--
-- Name: MAC_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAC_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAC_0" OWNER TO dev_epigraph;

--
-- Name: MAC_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAC_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAC_1" OWNER TO dev_epigraph;

--
-- Name: MAC_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAC_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAC_2" OWNER TO dev_epigraph;

--
-- Name: MAF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAF_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAF_0" OWNER TO dev_epigraph;

--
-- Name: MAR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAR_0" OWNER TO dev_epigraph;

--
-- Name: MAR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAR_1" OWNER TO dev_epigraph;

--
-- Name: MAR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAR_2" OWNER TO dev_epigraph;

--
-- Name: MAR_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAR_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAR_3" OWNER TO dev_epigraph;

--
-- Name: MAR_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MAR_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MAR_4" OWNER TO dev_epigraph;

--
-- Name: MCO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MCO_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MCO_0" OWNER TO dev_epigraph;

--
-- Name: MDA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDA_0" OWNER TO dev_epigraph;

--
-- Name: MDA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDA_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDA_1" OWNER TO dev_epigraph;

--
-- Name: MDG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDG_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDG_0" OWNER TO dev_epigraph;

--
-- Name: MDG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDG_1" OWNER TO dev_epigraph;

--
-- Name: MDG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDG_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDG_2" OWNER TO dev_epigraph;

--
-- Name: MDG_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDG_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDG_3" OWNER TO dev_epigraph;

--
-- Name: MDG_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDG_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDG_4" OWNER TO dev_epigraph;

--
-- Name: MDV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MDV_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MDV_0" OWNER TO dev_epigraph;

--
-- Name: MEX_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MEX_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MEX_0" OWNER TO dev_epigraph;

--
-- Name: MEX_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MEX_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MEX_1" OWNER TO dev_epigraph;

--
-- Name: MEX_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MEX_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MEX_2" OWNER TO dev_epigraph;

--
-- Name: MHL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MHL_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MHL_0" OWNER TO dev_epigraph;

--
-- Name: MKD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MKD_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MKD_0" OWNER TO dev_epigraph;

--
-- Name: MKD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MKD_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MKD_1" OWNER TO dev_epigraph;

--
-- Name: MLI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLI_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLI_0" OWNER TO dev_epigraph;

--
-- Name: MLI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLI_1" OWNER TO dev_epigraph;

--
-- Name: MLI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLI_2" OWNER TO dev_epigraph;

--
-- Name: MLI_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLI_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLI_3" OWNER TO dev_epigraph;

--
-- Name: MLI_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLI_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLI_4" OWNER TO dev_epigraph;

--
-- Name: MLT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLT_0" OWNER TO dev_epigraph;

--
-- Name: MLT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLT_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLT_1" OWNER TO dev_epigraph;

--
-- Name: MLT_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MLT_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MLT_2" OWNER TO dev_epigraph;

--
-- Name: MMR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MMR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MMR_0" OWNER TO dev_epigraph;

--
-- Name: MMR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MMR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MMR_1" OWNER TO dev_epigraph;

--
-- Name: MMR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MMR_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MMR_2" OWNER TO dev_epigraph;

--
-- Name: MMR_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MMR_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MMR_3" OWNER TO dev_epigraph;

--
-- Name: MNE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNE_0" OWNER TO dev_epigraph;

--
-- Name: MNE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNE_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNE_1" OWNER TO dev_epigraph;

--
-- Name: MNG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNG_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNG_0" OWNER TO dev_epigraph;

--
-- Name: MNG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNG_1" OWNER TO dev_epigraph;

--
-- Name: MNG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNG_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNG_2" OWNER TO dev_epigraph;

--
-- Name: MNP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNP_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNP_0" OWNER TO dev_epigraph;

--
-- Name: MNP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MNP_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MNP_1" OWNER TO dev_epigraph;

--
-- Name: MOZ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MOZ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MOZ_0" OWNER TO dev_epigraph;

--
-- Name: MOZ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MOZ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MOZ_1" OWNER TO dev_epigraph;

--
-- Name: MOZ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MOZ_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MOZ_2" OWNER TO dev_epigraph;

--
-- Name: MOZ_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MOZ_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MOZ_3" OWNER TO dev_epigraph;

--
-- Name: MRT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MRT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MRT_0" OWNER TO dev_epigraph;

--
-- Name: MRT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MRT_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MRT_1" OWNER TO dev_epigraph;

--
-- Name: MRT_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MRT_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MRT_2" OWNER TO dev_epigraph;

--
-- Name: MSR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MSR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MSR_0" OWNER TO dev_epigraph;

--
-- Name: MSR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MSR_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MSR_1" OWNER TO dev_epigraph;

--
-- Name: MTQ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MTQ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MTQ_0" OWNER TO dev_epigraph;

--
-- Name: MTQ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MTQ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MTQ_1" OWNER TO dev_epigraph;

--
-- Name: MTQ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MTQ_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MTQ_2" OWNER TO dev_epigraph;

--
-- Name: MUS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MUS_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MUS_0" OWNER TO dev_epigraph;

--
-- Name: MUS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MUS_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MUS_1" OWNER TO dev_epigraph;

--
-- Name: MWI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MWI_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MWI_0" OWNER TO dev_epigraph;

--
-- Name: MWI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MWI_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MWI_1" OWNER TO dev_epigraph;

--
-- Name: MWI_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MWI_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MWI_2" OWNER TO dev_epigraph;

--
-- Name: MWI_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MWI_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MWI_3" OWNER TO dev_epigraph;

--
-- Name: MYS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MYS_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MYS_0" OWNER TO dev_epigraph;

--
-- Name: MYS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MYS_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MYS_1" OWNER TO dev_epigraph;

--
-- Name: MYS_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MYS_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MYS_2" OWNER TO dev_epigraph;

--
-- Name: MYT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MYT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MYT_0" OWNER TO dev_epigraph;

--
-- Name: MYT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."MYT_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."MYT_1" OWNER TO dev_epigraph;

--
-- Name: NAM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NAM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NAM_0" OWNER TO dev_epigraph;

--
-- Name: NAM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NAM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NAM_1" OWNER TO dev_epigraph;

--
-- Name: NAM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NAM_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NAM_2" OWNER TO dev_epigraph;

--
-- Name: NCL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NCL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NCL_0" OWNER TO dev_epigraph;

--
-- Name: NCL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NCL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NCL_1" OWNER TO dev_epigraph;

--
-- Name: NCL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NCL_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NCL_2" OWNER TO dev_epigraph;

--
-- Name: NER_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NER_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NER_0" OWNER TO dev_epigraph;

--
-- Name: NER_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NER_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NER_1" OWNER TO dev_epigraph;

--
-- Name: NER_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NER_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NER_2" OWNER TO dev_epigraph;

--
-- Name: NER_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NER_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NER_3" OWNER TO dev_epigraph;

--
-- Name: NFK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NFK_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NFK_0" OWNER TO dev_epigraph;

--
-- Name: NGA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NGA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NGA_0" OWNER TO dev_epigraph;

--
-- Name: NGA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NGA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NGA_1" OWNER TO dev_epigraph;

--
-- Name: NGA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NGA_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NGA_2" OWNER TO dev_epigraph;

--
-- Name: NIC_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NIC_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NIC_0" OWNER TO dev_epigraph;

--
-- Name: NIC_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NIC_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NIC_1" OWNER TO dev_epigraph;

--
-- Name: NIC_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NIC_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NIC_2" OWNER TO dev_epigraph;

--
-- Name: NIU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NIU_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NIU_0" OWNER TO dev_epigraph;

--
-- Name: NLD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NLD_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NLD_0" OWNER TO dev_epigraph;

--
-- Name: NLD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NLD_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NLD_1" OWNER TO dev_epigraph;

--
-- Name: NLD_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NLD_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NLD_2" OWNER TO dev_epigraph;

--
-- Name: NOR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NOR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NOR_0" OWNER TO dev_epigraph;

--
-- Name: NOR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NOR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NOR_1" OWNER TO dev_epigraph;

--
-- Name: NOR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NOR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NOR_2" OWNER TO dev_epigraph;

--
-- Name: NPL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NPL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NPL_0" OWNER TO dev_epigraph;

--
-- Name: NPL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NPL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NPL_1" OWNER TO dev_epigraph;

--
-- Name: NPL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NPL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NPL_2" OWNER TO dev_epigraph;

--
-- Name: NPL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NPL_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NPL_3" OWNER TO dev_epigraph;

--
-- Name: NPL_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NPL_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NPL_4" OWNER TO dev_epigraph;

--
-- Name: NRU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NRU_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NRU_0" OWNER TO dev_epigraph;

--
-- Name: NRU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NRU_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NRU_1" OWNER TO dev_epigraph;

--
-- Name: NZL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NZL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NZL_0" OWNER TO dev_epigraph;

--
-- Name: NZL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NZL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NZL_1" OWNER TO dev_epigraph;

--
-- Name: NZL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."NZL_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."NZL_2" OWNER TO dev_epigraph;

--
-- Name: OMN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."OMN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."OMN_0" OWNER TO dev_epigraph;

--
-- Name: OMN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."OMN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."OMN_1" OWNER TO dev_epigraph;

--
-- Name: OMN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."OMN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."OMN_2" OWNER TO dev_epigraph;

--
-- Name: PAK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAK_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAK_0" OWNER TO dev_epigraph;

--
-- Name: PAK_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAK_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAK_1" OWNER TO dev_epigraph;

--
-- Name: PAK_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAK_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAK_2" OWNER TO dev_epigraph;

--
-- Name: PAK_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAK_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAK_3" OWNER TO dev_epigraph;

--
-- Name: PAN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAN_0" OWNER TO dev_epigraph;

--
-- Name: PAN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAN_1" OWNER TO dev_epigraph;

--
-- Name: PAN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAN_2" OWNER TO dev_epigraph;

--
-- Name: PAN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PAN_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PAN_3" OWNER TO dev_epigraph;

--
-- Name: PCN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PCN_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PCN_0" OWNER TO dev_epigraph;

--
-- Name: PER_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PER_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PER_0" OWNER TO dev_epigraph;

--
-- Name: PER_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PER_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PER_1" OWNER TO dev_epigraph;

--
-- Name: PER_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PER_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PER_2" OWNER TO dev_epigraph;

--
-- Name: PER_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PER_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PER_3" OWNER TO dev_epigraph;

--
-- Name: PHL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PHL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PHL_0" OWNER TO dev_epigraph;

--
-- Name: PHL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PHL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PHL_1" OWNER TO dev_epigraph;

--
-- Name: PHL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PHL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PHL_2" OWNER TO dev_epigraph;

--
-- Name: PHL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PHL_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PHL_3" OWNER TO dev_epigraph;

--
-- Name: PLW_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PLW_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PLW_0" OWNER TO dev_epigraph;

--
-- Name: PLW_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PLW_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PLW_1" OWNER TO dev_epigraph;

--
-- Name: PNG_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PNG_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PNG_0" OWNER TO dev_epigraph;

--
-- Name: PNG_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PNG_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PNG_1" OWNER TO dev_epigraph;

--
-- Name: PNG_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PNG_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PNG_2" OWNER TO dev_epigraph;

--
-- Name: POL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."POL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."POL_0" OWNER TO dev_epigraph;

--
-- Name: POL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."POL_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."POL_1" OWNER TO dev_epigraph;

--
-- Name: POL_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."POL_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."POL_2" OWNER TO dev_epigraph;

--
-- Name: POL_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."POL_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."POL_3" OWNER TO dev_epigraph;

--
-- Name: PRI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRI_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRI_0" OWNER TO dev_epigraph;

--
-- Name: PRI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRI_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRI_1" OWNER TO dev_epigraph;

--
-- Name: PRK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRK_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRK_0" OWNER TO dev_epigraph;

--
-- Name: PRK_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRK_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRK_1" OWNER TO dev_epigraph;

--
-- Name: PRK_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRK_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRK_2" OWNER TO dev_epigraph;

--
-- Name: PRT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRT_0" OWNER TO dev_epigraph;

--
-- Name: PRT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRT_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRT_1" OWNER TO dev_epigraph;

--
-- Name: PRT_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRT_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRT_2" OWNER TO dev_epigraph;

--
-- Name: PRT_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRT_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRT_3" OWNER TO dev_epigraph;

--
-- Name: PRY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRY_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRY_0" OWNER TO dev_epigraph;

--
-- Name: PRY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRY_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRY_1" OWNER TO dev_epigraph;

--
-- Name: PRY_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PRY_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PRY_2" OWNER TO dev_epigraph;

--
-- Name: PSE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PSE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PSE_0" OWNER TO dev_epigraph;

--
-- Name: PSE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PSE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PSE_1" OWNER TO dev_epigraph;

--
-- Name: PSE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PSE_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PSE_2" OWNER TO dev_epigraph;

--
-- Name: PYF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PYF_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PYF_0" OWNER TO dev_epigraph;

--
-- Name: PYF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."PYF_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."PYF_1" OWNER TO dev_epigraph;

--
-- Name: QAT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."QAT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."QAT_0" OWNER TO dev_epigraph;

--
-- Name: QAT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."QAT_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."QAT_1" OWNER TO dev_epigraph;

--
-- Name: REU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."REU_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."REU_0" OWNER TO dev_epigraph;

--
-- Name: REU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."REU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."REU_1" OWNER TO dev_epigraph;

--
-- Name: REU_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."REU_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."REU_2" OWNER TO dev_epigraph;

--
-- Name: ROU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ROU_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ROU_0" OWNER TO dev_epigraph;

--
-- Name: ROU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ROU_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ROU_1" OWNER TO dev_epigraph;

--
-- Name: ROU_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ROU_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ROU_2" OWNER TO dev_epigraph;

--
-- Name: RUS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RUS_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RUS_0" OWNER TO dev_epigraph;

--
-- Name: RUS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RUS_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RUS_1" OWNER TO dev_epigraph;

--
-- Name: RUS_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RUS_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RUS_2" OWNER TO dev_epigraph;

--
-- Name: RUS_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RUS_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RUS_3" OWNER TO dev_epigraph;

--
-- Name: RWA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "GID_5" text,
    "NAME_5" text,
    "TYPE_5" text,
    "ENGTYPE_5" text,
    "CC_5" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_0" OWNER TO dev_epigraph;

--
-- Name: RWA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_1" OWNER TO dev_epigraph;

--
-- Name: RWA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_2" OWNER TO dev_epigraph;

--
-- Name: RWA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_3" OWNER TO dev_epigraph;

--
-- Name: RWA_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_4" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_4" OWNER TO dev_epigraph;

--
-- Name: RWA_5; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."RWA_5" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."RWA_5" OWNER TO dev_epigraph;

--
-- Name: SAU_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SAU_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SAU_0" OWNER TO dev_epigraph;

--
-- Name: SAU_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SAU_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SAU_1" OWNER TO dev_epigraph;

--
-- Name: SDN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SDN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SDN_0" OWNER TO dev_epigraph;

--
-- Name: SDN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SDN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SDN_1" OWNER TO dev_epigraph;

--
-- Name: SDN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SDN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SDN_2" OWNER TO dev_epigraph;

--
-- Name: SDN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SDN_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SDN_3" OWNER TO dev_epigraph;

--
-- Name: SEN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SEN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SEN_0" OWNER TO dev_epigraph;

--
-- Name: SEN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SEN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SEN_1" OWNER TO dev_epigraph;

--
-- Name: SEN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SEN_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SEN_2" OWNER TO dev_epigraph;

--
-- Name: SEN_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SEN_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SEN_3" OWNER TO dev_epigraph;

--
-- Name: SEN_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SEN_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SEN_4" OWNER TO dev_epigraph;

--
-- Name: SGP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SGP_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SGP_0" OWNER TO dev_epigraph;

--
-- Name: SGP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SGP_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SGP_1" OWNER TO dev_epigraph;

--
-- Name: SGS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SGS_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SGS_0" OWNER TO dev_epigraph;

--
-- Name: SHN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SHN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SHN_0" OWNER TO dev_epigraph;

--
-- Name: SHN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SHN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SHN_1" OWNER TO dev_epigraph;

--
-- Name: SHN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SHN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SHN_2" OWNER TO dev_epigraph;

--
-- Name: SJM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SJM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SJM_0" OWNER TO dev_epigraph;

--
-- Name: SJM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SJM_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SJM_1" OWNER TO dev_epigraph;

--
-- Name: SLB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLB_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLB_0" OWNER TO dev_epigraph;

--
-- Name: SLB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLB_1" OWNER TO dev_epigraph;

--
-- Name: SLB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLB_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLB_2" OWNER TO dev_epigraph;

--
-- Name: SLE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLE_0" OWNER TO dev_epigraph;

--
-- Name: SLE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLE_1" OWNER TO dev_epigraph;

--
-- Name: SLE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLE_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLE_2" OWNER TO dev_epigraph;

--
-- Name: SLE_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLE_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLE_3" OWNER TO dev_epigraph;

--
-- Name: SLV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLV_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLV_0" OWNER TO dev_epigraph;

--
-- Name: SLV_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLV_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLV_1" OWNER TO dev_epigraph;

--
-- Name: SLV_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SLV_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SLV_2" OWNER TO dev_epigraph;

--
-- Name: SMR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SMR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SMR_0" OWNER TO dev_epigraph;

--
-- Name: SMR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SMR_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SMR_1" OWNER TO dev_epigraph;

--
-- Name: SOM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SOM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SOM_0" OWNER TO dev_epigraph;

--
-- Name: SOM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SOM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SOM_1" OWNER TO dev_epigraph;

--
-- Name: SOM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SOM_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SOM_2" OWNER TO dev_epigraph;

--
-- Name: SPM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SPM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SPM_0" OWNER TO dev_epigraph;

--
-- Name: SPM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SPM_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SPM_1" OWNER TO dev_epigraph;

--
-- Name: SRB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SRB_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SRB_0" OWNER TO dev_epigraph;

--
-- Name: SRB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SRB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SRB_1" OWNER TO dev_epigraph;

--
-- Name: SRB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SRB_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SRB_2" OWNER TO dev_epigraph;

--
-- Name: STP_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."STP_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."STP_0" OWNER TO dev_epigraph;

--
-- Name: STP_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."STP_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."STP_1" OWNER TO dev_epigraph;

--
-- Name: STP_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."STP_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."STP_2" OWNER TO dev_epigraph;

--
-- Name: SUR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SUR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SUR_0" OWNER TO dev_epigraph;

--
-- Name: SUR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SUR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SUR_1" OWNER TO dev_epigraph;

--
-- Name: SUR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SUR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SUR_2" OWNER TO dev_epigraph;

--
-- Name: SVK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVK_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVK_0" OWNER TO dev_epigraph;

--
-- Name: SVK_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVK_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVK_1" OWNER TO dev_epigraph;

--
-- Name: SVK_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVK_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVK_2" OWNER TO dev_epigraph;

--
-- Name: SVN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVN_0" OWNER TO dev_epigraph;

--
-- Name: SVN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVN_1" OWNER TO dev_epigraph;

--
-- Name: SVN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SVN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SVN_2" OWNER TO dev_epigraph;

--
-- Name: SWE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWE_0" OWNER TO dev_epigraph;

--
-- Name: SWE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWE_1" OWNER TO dev_epigraph;

--
-- Name: SWE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWE_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWE_2" OWNER TO dev_epigraph;

--
-- Name: SWZ_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWZ_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWZ_0" OWNER TO dev_epigraph;

--
-- Name: SWZ_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWZ_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWZ_1" OWNER TO dev_epigraph;

--
-- Name: SWZ_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SWZ_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SWZ_2" OWNER TO dev_epigraph;

--
-- Name: SYC_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SYC_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SYC_0" OWNER TO dev_epigraph;

--
-- Name: SYC_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SYC_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SYC_1" OWNER TO dev_epigraph;

--
-- Name: SYR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SYR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SYR_0" OWNER TO dev_epigraph;

--
-- Name: SYR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SYR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SYR_1" OWNER TO dev_epigraph;

--
-- Name: SYR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."SYR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."SYR_2" OWNER TO dev_epigraph;

--
-- Name: TCA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCA_0" OWNER TO dev_epigraph;

--
-- Name: TCA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCA_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCA_1" OWNER TO dev_epigraph;

--
-- Name: TCD_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCD_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCD_0" OWNER TO dev_epigraph;

--
-- Name: TCD_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCD_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCD_1" OWNER TO dev_epigraph;

--
-- Name: TCD_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCD_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCD_2" OWNER TO dev_epigraph;

--
-- Name: TCD_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TCD_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TCD_3" OWNER TO dev_epigraph;

--
-- Name: TGO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TGO_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TGO_0" OWNER TO dev_epigraph;

--
-- Name: TGO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TGO_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TGO_1" OWNER TO dev_epigraph;

--
-- Name: TGO_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TGO_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TGO_2" OWNER TO dev_epigraph;

--
-- Name: THA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."THA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."THA_0" OWNER TO dev_epigraph;

--
-- Name: THA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."THA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."THA_1" OWNER TO dev_epigraph;

--
-- Name: THA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."THA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."THA_2" OWNER TO dev_epigraph;

--
-- Name: THA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."THA_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."THA_3" OWNER TO dev_epigraph;

--
-- Name: TJK_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TJK_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TJK_0" OWNER TO dev_epigraph;

--
-- Name: TJK_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TJK_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TJK_1" OWNER TO dev_epigraph;

--
-- Name: TJK_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TJK_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TJK_2" OWNER TO dev_epigraph;

--
-- Name: TJK_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TJK_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TJK_3" OWNER TO dev_epigraph;

--
-- Name: TKL_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TKL_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TKL_0" OWNER TO dev_epigraph;

--
-- Name: TKL_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TKL_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TKL_1" OWNER TO dev_epigraph;

--
-- Name: TKM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TKM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TKM_0" OWNER TO dev_epigraph;

--
-- Name: TKM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TKM_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TKM_1" OWNER TO dev_epigraph;

--
-- Name: TLS_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TLS_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TLS_0" OWNER TO dev_epigraph;

--
-- Name: TLS_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TLS_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TLS_1" OWNER TO dev_epigraph;

--
-- Name: TLS_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TLS_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TLS_2" OWNER TO dev_epigraph;

--
-- Name: TLS_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TLS_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TLS_3" OWNER TO dev_epigraph;

--
-- Name: TON_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TON_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TON_0" OWNER TO dev_epigraph;

--
-- Name: TON_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TON_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TON_1" OWNER TO dev_epigraph;

--
-- Name: TTO_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TTO_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TTO_0" OWNER TO dev_epigraph;

--
-- Name: TTO_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TTO_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TTO_1" OWNER TO dev_epigraph;

--
-- Name: TUN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUN_0" OWNER TO dev_epigraph;

--
-- Name: TUN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUN_1" OWNER TO dev_epigraph;

--
-- Name: TUN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUN_2" OWNER TO dev_epigraph;

--
-- Name: TUR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUR_0" OWNER TO dev_epigraph;

--
-- Name: TUR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUR_1" OWNER TO dev_epigraph;

--
-- Name: TUR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUR_2" OWNER TO dev_epigraph;

--
-- Name: TUV_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUV_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUV_0" OWNER TO dev_epigraph;

--
-- Name: TUV_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TUV_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TUV_1" OWNER TO dev_epigraph;

--
-- Name: TWN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TWN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TWN_0" OWNER TO dev_epigraph;

--
-- Name: TWN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TWN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TWN_1" OWNER TO dev_epigraph;

--
-- Name: TWN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TWN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TWN_2" OWNER TO dev_epigraph;

--
-- Name: TZA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TZA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TZA_0" OWNER TO dev_epigraph;

--
-- Name: TZA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TZA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TZA_1" OWNER TO dev_epigraph;

--
-- Name: TZA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TZA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TZA_2" OWNER TO dev_epigraph;

--
-- Name: TZA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."TZA_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."TZA_3" OWNER TO dev_epigraph;

--
-- Name: UGA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UGA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UGA_0" OWNER TO dev_epigraph;

--
-- Name: UGA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UGA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UGA_1" OWNER TO dev_epigraph;

--
-- Name: UGA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UGA_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UGA_2" OWNER TO dev_epigraph;

--
-- Name: UGA_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UGA_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UGA_3" OWNER TO dev_epigraph;

--
-- Name: UGA_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UGA_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UGA_4" OWNER TO dev_epigraph;

--
-- Name: UKR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UKR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UKR_0" OWNER TO dev_epigraph;

--
-- Name: UKR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UKR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UKR_1" OWNER TO dev_epigraph;

--
-- Name: UKR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UKR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UKR_2" OWNER TO dev_epigraph;

--
-- Name: UMI_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UMI_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UMI_0" OWNER TO dev_epigraph;

--
-- Name: UMI_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UMI_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UMI_1" OWNER TO dev_epigraph;

--
-- Name: URY_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."URY_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."URY_0" OWNER TO dev_epigraph;

--
-- Name: URY_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."URY_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."URY_1" OWNER TO dev_epigraph;

--
-- Name: URY_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."URY_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."URY_2" OWNER TO dev_epigraph;

--
-- Name: USA_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."USA_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."USA_0" OWNER TO dev_epigraph;

--
-- Name: USA_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."USA_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."USA_1" OWNER TO dev_epigraph;

--
-- Name: USA_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."USA_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."USA_2" OWNER TO dev_epigraph;

--
-- Name: UZB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UZB_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UZB_0" OWNER TO dev_epigraph;

--
-- Name: UZB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UZB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UZB_1" OWNER TO dev_epigraph;

--
-- Name: UZB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."UZB_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."UZB_2" OWNER TO dev_epigraph;

--
-- Name: VAT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VAT_0" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VAT_0" OWNER TO dev_epigraph;

--
-- Name: VCT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VCT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VCT_0" OWNER TO dev_epigraph;

--
-- Name: VCT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VCT_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VCT_1" OWNER TO dev_epigraph;

--
-- Name: VEN_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VEN_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VEN_0" OWNER TO dev_epigraph;

--
-- Name: VEN_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VEN_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VEN_1" OWNER TO dev_epigraph;

--
-- Name: VEN_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VEN_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VEN_2" OWNER TO dev_epigraph;

--
-- Name: VGB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VGB_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VGB_0" OWNER TO dev_epigraph;

--
-- Name: VGB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VGB_1" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VGB_1" OWNER TO dev_epigraph;

--
-- Name: VIR_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VIR_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VIR_0" OWNER TO dev_epigraph;

--
-- Name: VIR_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VIR_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VIR_1" OWNER TO dev_epigraph;

--
-- Name: VIR_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VIR_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VIR_2" OWNER TO dev_epigraph;

--
-- Name: VNM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VNM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VNM_0" OWNER TO dev_epigraph;

--
-- Name: VNM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VNM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VNM_1" OWNER TO dev_epigraph;

--
-- Name: VNM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VNM_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VNM_2" OWNER TO dev_epigraph;

--
-- Name: VNM_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VNM_3" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VNM_3" OWNER TO dev_epigraph;

--
-- Name: VUT_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VUT_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VUT_0" OWNER TO dev_epigraph;

--
-- Name: VUT_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VUT_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VUT_1" OWNER TO dev_epigraph;

--
-- Name: VUT_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."VUT_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."VUT_2" OWNER TO dev_epigraph;

--
-- Name: WLF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WLF_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WLF_0" OWNER TO dev_epigraph;

--
-- Name: WLF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WLF_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WLF_1" OWNER TO dev_epigraph;

--
-- Name: WLF_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WLF_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WLF_2" OWNER TO dev_epigraph;

--
-- Name: WSM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WSM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WSM_0" OWNER TO dev_epigraph;

--
-- Name: WSM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WSM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WSM_1" OWNER TO dev_epigraph;

--
-- Name: WSM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."WSM_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."WSM_2" OWNER TO dev_epigraph;

--
-- Name: YEM_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."YEM_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."YEM_0" OWNER TO dev_epigraph;

--
-- Name: YEM_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."YEM_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."YEM_1" OWNER TO dev_epigraph;

--
-- Name: YEM_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."YEM_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."YEM_2" OWNER TO dev_epigraph;

--
-- Name: ZAF_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZAF_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "GID_4" text,
    "NAME_4" text,
    "VARNAME_4" text,
    "TYPE_4" text,
    "ENGTYPE_4" text,
    "CC_4" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZAF_0" OWNER TO dev_epigraph;

--
-- Name: ZAF_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZAF_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "NL_NAME_2" text,
    "GID_3" text,
    "NAME_3" text,
    "VARNAME_3" text,
    "NL_NAME_3" text,
    "TYPE_3" text,
    "ENGTYPE_3" text,
    "CC_3" text,
    "HASC_3" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZAF_1" OWNER TO dev_epigraph;

--
-- Name: ZAF_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZAF_2" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZAF_2" OWNER TO dev_epigraph;

--
-- Name: ZAF_3; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZAF_3" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZAF_3" OWNER TO dev_epigraph;

--
-- Name: ZAF_4; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZAF_4" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZAF_4" OWNER TO dev_epigraph;

--
-- Name: ZMB_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZMB_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(MultiPolygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZMB_0" OWNER TO dev_epigraph;

--
-- Name: ZMB_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZMB_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZMB_1" OWNER TO dev_epigraph;

--
-- Name: ZMB_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZMB_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZMB_2" OWNER TO dev_epigraph;

--
-- Name: ZWE_0; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZWE_0" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZWE_0" OWNER TO dev_epigraph;

--
-- Name: ZWE_1; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZWE_1" (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZWE_1" OWNER TO dev_epigraph;

--
-- Name: ZWE_2; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public."ZWE_2" (
    "GID_0" text,
    "NAME_0" text,
    geometry public.geometry(Polygon,4326),
    json text,
    "Latitude" double precision,
    "Longitude" double precision
);


ALTER TABLE public."ZWE_2" OWNER TO dev_epigraph;

--
-- Name: gadm36; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public.gadm36 (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "NL_NAME_1" text,
    "GID_2" text,
    "NAME_2" text,
    "VARNAME_2" text,
    "NL_NAME_2" text,
    "TYPE_2" text,
    "ENGTYPE_2" text,
    "CC_2" text,
    "HASC_2" text,
    geometry public.geometry(Polygon,4326)
);


ALTER TABLE public.gadm36 OWNER TO dev_epigraph;

--
-- Name: iso_alpha3_country_codes; Type: TABLE; Schema: public; Owner: dev_admin
--

CREATE TABLE public.iso_alpha3_country_codes (
    iso_code text,
    country_name text
);


ALTER TABLE public.iso_alpha3_country_codes OWNER TO dev_admin;

--
-- Name: owid_covid; Type: TABLE; Schema: public; Owner: dev_epigraph
--

CREATE TABLE public.owid_covid (
    iso_code text,
    continent text,
    location text,
    date timestamp without time zone,
    total_cases bigint,
    new_cases bigint,
    new_cases_smoothed double precision,
    total_deaths bigint,
    new_deaths bigint,
    new_deaths_smoothed double precision,
    total_cases_per_million double precision,
    new_cases_per_million double precision,
    new_cases_smoothed_per_million double precision,
    total_deaths_per_million double precision,
    new_deaths_per_million double precision,
    new_deaths_smoothed_per_million double precision,
    reproduction_rate double precision,
    icu_patients bigint,
    icu_patients_per_million double precision,
    hosp_patients bigint,
    hosp_patients_per_million double precision,
    weekly_icu_admissions bigint,
    weekly_icu_admissions_per_million double precision,
    weekly_hosp_admissions bigint,
    weekly_hosp_admissions_per_million double precision,
    new_tests bigint,
    total_tests bigint,
    total_tests_per_thousand double precision,
    new_tests_per_thousand double precision,
    new_tests_smoothed bigint,
    new_tests_smoothed_per_thousand double precision,
    positive_rate double precision,
    tests_per_case double precision,
    tests_units text,
    total_vaccinations bigint,
    people_vaccinated bigint,
    people_fully_vaccinated bigint,
    total_boosters bigint,
    new_vaccinations bigint,
    new_vaccinations_smoothed bigint,
    total_vaccinations_per_hundred double precision,
    people_vaccinated_per_hundred double precision,
    people_fully_vaccinated_per_hundred double precision,
    total_boosters_per_hundred double precision,
    new_vaccinations_smoothed_per_million bigint,
    new_people_vaccinated_smoothed bigint,
    new_people_vaccinated_smoothed_per_hundred double precision,
    stringency_index double precision,
    population bigint,
    population_density double precision,
    median_age double precision,
    aged_65_older double precision,
    aged_70_older double precision,
    gdp_per_capita double precision,
    extreme_poverty double precision,
    cardiovasc_death_rate double precision,
    diabetes_prevalence double precision,
    female_smokers double precision,
    male_smokers double precision,
    handwashing_facilities double precision,
    hospital_beds_per_thousand double precision,
    life_expectancy double precision,
    human_development_index double precision,
    excess_mortality_cumulative_absolute double precision,
    excess_mortality_cumulative double precision,
    excess_mortality double precision,
    excess_mortality_cumulative_per_million double precision
);


ALTER TABLE public.owid_covid OWNER TO dev_epigraph;

--
-- Name: df_val_hosp_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.df_val_hosp_cantons (
    index bigint,
    target double precision,
    date text,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.df_val_hosp_cantons OWNER TO dev_epigraph;

--
-- Name: foph_cases; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_cases (
    id_ bigint NOT NULL,
    "geoRegion" text,
    datum text,
    entries bigint,
    "sumTotal" bigint,
    timeframe_7d boolean,
    offset_last7d bigint,
    "sumTotal_last7d" bigint,
    timeframe_14d boolean,
    offset_last14d bigint,
    "sumTotal_last14d" bigint,
    timeframe_28d boolean,
    offset_last28d bigint,
    "sumTotal_last28d" bigint,
    timeframe_phase2 boolean,
    "offset_Phase2" bigint,
    "sumTotal_Phase2" bigint,
    timeframe_phase2b boolean,
    "offset_Phase2b" bigint,
    "sumTotal_Phase2b" bigint,
    timeframe_phase3 boolean,
    "offset_Phase3" bigint,
    "sumTotal_Phase3" bigint,
    timeframe_vacc_info boolean,
    offset_vacc_info bigint,
    "sumTotal_vacc_info" bigint,
    timeframe_phase4 boolean,
    "offset_Phase4" bigint,
    "sumTotal_Phase4" bigint,
    timeframe_phase5 boolean,
    "offset_Phase5" bigint,
    "sumTotal_Phase5" bigint,
    sum7d double precision,
    sum14d double precision,
    mean7d double precision,
    mean14d double precision,
    timeframe_all boolean,
    entries_diff_last_age bigint,
    pop bigint,
    inz_entries double precision,
    inzmean7d double precision,
    inzmean14d double precision,
    "inzsumTotal" double precision,
    "inzsumTotal_last7d" double precision,
    "inzsumTotal_last14d" double precision,
    "inzsumTotal_last28d" double precision,
    "inzsumTotal_Phase2" double precision,
    "inzsumTotal_Phase2b" double precision,
    "inzsumTotal_Phase3" double precision,
    "inzsumTotal_Phase4" double precision,
    "inzsumTotal_Phase5" double precision,
    inzsum7d double precision,
    inzsum14d double precision,
    sumdelta7d double precision,
    inzdelta7d double precision,
    type text,
    type_variant double precision,
    version text,
    datum_unit text,
    entries_letzter_stand bigint,
    entries_neu_gemeldet bigint,
    entries_diff_last bigint,
    date timestamp without time zone,
    timeframe_phase6 boolean,
    "offset_Phase6" bigint,
    "sumTotal_Phase6" bigint,
    "inzsumTotal_Phase6" double precision
);


ALTER TABLE switzerland.foph_cases OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_cases_d ( LIKE switzerland.foph_cases INCLUDING DEFAULTS );

--
-- Name: foph_cases_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_cases_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_cases_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_cases_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_cases_id__seq OWNED BY switzerland.foph_cases.id_;


--
-- Name: foph_casesvaccpersons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_casesvaccpersons (
    id_ bigint NOT NULL,
    date timestamp without time zone,
    vaccine text,
    vaccination_status text,
    entries bigint,
    "sumTotal" bigint,
    pop double precision,
    inz_entries double precision,
    "inzsumTotal" double precision,
    mean7d double precision,
    inzmean7d double precision,
    prct double precision,
    "prctSumTotal" double precision,
    prct_mean7d double precision,
    "geoRegion" text,
    type text,
    type_variant text,
    data_completeness text,
    version text
);


ALTER TABLE switzerland.foph_casesvaccpersons OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_casesvaccpersons_d ( LIKE switzerland.foph_casesvaccpersons INCLUDING DEFAULTS );

--
-- Name: foph_casesvaccpersons_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_casesvaccpersons_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_casesvaccpersons_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_casesvaccpersons_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_casesvaccpersons_id__seq OWNED BY switzerland.foph_casesvaccpersons.id_;


--
-- Name: foph_covidcertificates; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_covidcertificates (
    id_ bigint NOT NULL,
    date timestamp without time zone,
    type text,
    "geoRegion" text,
    type_variant text,
    entries bigint,
    "sumTotal" bigint,
    version text
);


ALTER TABLE switzerland.foph_covidcertificates OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_covidcertificates_d ( LIKE switzerland.foph_covidcertificates INCLUDING DEFAULTS );

--
-- Name: foph_covidcertificates_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_covidcertificates_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_covidcertificates_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_covidcertificates_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_covidcertificates_id__seq OWNED BY switzerland.foph_covidcertificates.id_;


--
-- Name: foph_death; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_death (
    id_ bigint NOT NULL,
    "geoRegion" text,
    datum text,
    entries bigint,
    "sumTotal" bigint,
    timeframe_7d boolean,
    offset_last7d bigint,
    "sumTotal_last7d" bigint,
    timeframe_14d boolean,
    offset_last14d bigint,
    "sumTotal_last14d" bigint,
    timeframe_28d boolean,
    offset_last28d bigint,
    "sumTotal_last28d" bigint,
    timeframe_phase2 boolean,
    "offset_Phase2" bigint,
    "sumTotal_Phase2" bigint,
    timeframe_phase2b boolean,
    "offset_Phase2b" bigint,
    "sumTotal_Phase2b" bigint,
    timeframe_phase3 boolean,
    "offset_Phase3" bigint,
    "sumTotal_Phase3" bigint,
    timeframe_vacc_info boolean,
    offset_vacc_info bigint,
    "sumTotal_vacc_info" bigint,
    timeframe_phase4 boolean,
    "offset_Phase4" bigint,
    "sumTotal_Phase4" bigint,
    timeframe_phase5 boolean,
    "offset_Phase5" bigint,
    "sumTotal_Phase5" bigint,
    sum7d double precision,
    sum14d double precision,
    mean7d double precision,
    mean14d double precision,
    timeframe_all boolean,
    entries_diff_last_age bigint,
    pop bigint,
    inz_entries double precision,
    inzmean7d double precision,
    inzmean14d double precision,
    "inzsumTotal" double precision,
    "inzsumTotal_last7d" double precision,
    "inzsumTotal_last14d" double precision,
    "inzsumTotal_last28d" double precision,
    "inzsumTotal_Phase2" double precision,
    "inzsumTotal_Phase2b" double precision,
    "inzsumTotal_Phase3" double precision,
    "inzsumTotal_Phase4" double precision,
    "inzsumTotal_Phase5" double precision,
    inzsum7d double precision,
    inzsum14d double precision,
    sumdelta7d double precision,
    inzdelta7d double precision,
    type text,
    type_variant double precision,
    version text,
    datum_unit text,
    entries_letzter_stand bigint,
    entries_neu_gemeldet bigint,
    entries_diff_last bigint,
    date timestamp without time zone,
    timeframe_phase6 boolean,
    "offset_Phase6" bigint,
    "sumTotal_Phase6" bigint,
    "inzsumTotal_Phase6" double precision
);


ALTER TABLE switzerland.foph_death OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_death_d ( LIKE switzerland.foph_death INCLUDING DEFAULTS );

--
-- Name: foph_death_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_death_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_death_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_death_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_death_id__seq OWNED BY switzerland.foph_death.id_;


--
-- Name: foph_deathvaccpersons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_deathvaccpersons (
    id_ bigint NOT NULL,
    date timestamp without time zone,
    vaccine text,
    vaccination_status text,
    entries bigint,
    "sumTotal" bigint,
    pop double precision,
    inz_entries double precision,
    "inzsumTotal" double precision,
    mean7d double precision,
    inzmean7d double precision,
    prct double precision,
    "prctSumTotal" double precision,
    prct_mean7d double precision,
    "geoRegion" text,
    type text,
    type_variant text,
    data_completeness text,
    version text
);


ALTER TABLE switzerland.foph_deathvaccpersons OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_deathvaccpersons_d ( LIKE switzerland.foph_deathvaccpersons INCLUDING DEFAULTS );

--
-- Name: foph_deathvaccpersons_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_deathvaccpersons_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_deathvaccpersons_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_deathvaccpersons_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_deathvaccpersons_id__seq OWNED BY switzerland.foph_deathvaccpersons.id_;


--
-- Name: foph_hosp; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_hosp (
    id_ bigint NOT NULL,
    "geoRegion" text,
    datum text,
    entries bigint,
    "sumTotal" bigint,
    timeframe_7d boolean,
    offset_last7d bigint,
    "sumTotal_last7d" bigint,
    timeframe_14d boolean,
    offset_last14d bigint,
    "sumTotal_last14d" bigint,
    timeframe_28d boolean,
    offset_last28d bigint,
    "sumTotal_last28d" bigint,
    timeframe_phase2 boolean,
    "offset_Phase2" bigint,
    "sumTotal_Phase2" bigint,
    timeframe_phase2b boolean,
    "offset_Phase2b" bigint,
    "sumTotal_Phase2b" bigint,
    timeframe_phase3 boolean,
    "offset_Phase3" bigint,
    "sumTotal_Phase3" bigint,
    timeframe_vacc_info boolean,
    offset_vacc_info bigint,
    "sumTotal_vacc_info" bigint,
    timeframe_phase4 boolean,
    "offset_Phase4" bigint,
    "sumTotal_Phase4" bigint,
    timeframe_phase5 boolean,
    "offset_Phase5" bigint,
    "sumTotal_Phase5" bigint,
    sum7d double precision,
    sum14d double precision,
    mean7d double precision,
    mean14d double precision,
    timeframe_all boolean,
    entries_diff_last_age bigint,
    pop bigint,
    inz_entries double precision,
    inzmean7d double precision,
    inzmean14d double precision,
    "inzsumTotal" double precision,
    "inzsumTotal_last7d" double precision,
    "inzsumTotal_last14d" double precision,
    "inzsumTotal_last28d" double precision,
    "inzsumTotal_Phase2" double precision,
    "inzsumTotal_Phase2b" double precision,
    "inzsumTotal_Phase3" double precision,
    "inzsumTotal_Phase4" double precision,
    "inzsumTotal_Phase5" double precision,
    inzsum7d double precision,
    inzsum14d double precision,
    sumdelta7d double precision,
    inzdelta7d double precision,
    type text,
    type_variant double precision,
    version text,
    datum_unit text,
    entries_letzter_stand bigint,
    entries_neu_gemeldet bigint,
    entries_diff_last bigint,
    date timestamp without time zone,
    timeframe_phase6 boolean,
    "offset_Phase6" bigint,
    "sumTotal_Phase6" bigint,
    "inzsumTotal_Phase6" double precision
);


ALTER TABLE switzerland.foph_hosp OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_hosp_d ( LIKE switzerland.foph_hosp INCLUDING DEFAULTS );

--
-- Name: foph_hosp_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_hosp_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_hosp_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_hosp_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_hosp_id__seq OWNED BY switzerland.foph_hosp.id_;


--
-- Name: foph_hospcapacity; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_hospcapacity (
    id_ bigint NOT NULL,
    date timestamp without time zone,
    "geoRegion" text,
    "ICU_AllPatients" double precision,
    "ICU_Covid19Patients" double precision,
    "ICU_Capacity" double precision,
    "Total_AllPatients" double precision,
    "Total_Covid19Patients" double precision,
    "Total_Capacity" double precision,
    "ICU_NonCovid19Patients" double precision,
    "ICU_FreeCapacity" double precision,
    "Total_NonCovid19Patients" double precision,
    "Total_FreeCapacity" double precision,
    timeframe_14d boolean,
    timeframe_28d boolean,
    timeframe_phase2 boolean,
    timeframe_phase2b boolean,
    timeframe_phase3 boolean,
    timeframe_phase4 boolean,
    timeframe_phase5 boolean,
    timeframe_all boolean,
    "Total_Capacity_mean15d" double precision,
    "Total_AllPatients_mean15d" double precision,
    "Total_Covid19Patients_mean15d" double precision,
    "Total_NonCovid19Patients_mean15d" double precision,
    "Total_FreeCapacity_mean15d" double precision,
    "ICU_Capacity_mean15d" double precision,
    "ICU_AllPatients_mean15d" double precision,
    "ICU_Covid19Patients_mean15d" double precision,
    "ICU_NonCovid19Patients_mean15d" double precision,
    "ICU_FreeCapacity_mean15d" double precision,
    type_variant text,
    "ICUPercent_AllPatients" double precision,
    "ICUPercent_NonCovid19Patients" double precision,
    "ICUPercent_Covid19Patients" double precision,
    "ICUPercent_FreeCapacity" double precision,
    "ICUPercent_Capacity" double precision,
    "TotalPercent_AllPatients" double precision,
    "TotalPercent_NonCovid19Patients" double precision,
    "TotalPercent_Covid19Patients" double precision,
    "TotalPercent_FreeCapacity" double precision,
    "TotalPercent_Capacity" double precision,
    "ICU_exists" boolean,
    "Total_exists" boolean,
    type text,
    version text,
    timeframe_phase6 boolean
);


ALTER TABLE switzerland.foph_hospcapacity OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_hospcapacity_d ( LIKE switzerland.foph_hospcapacity INCLUDING DEFAULTS );

--
-- Name: foph_hospcapacity_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_hospcapacity_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_hospcapacity_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_hospcapacity_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_hospcapacity_id__seq OWNED BY switzerland.foph_hospcapacity.id_;


--
-- Name: foph_hospvaccpersons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_hospvaccpersons (
    id_ bigint NOT NULL,
    date timestamp without time zone,
    vaccine text,
    vaccination_status text,
    entries bigint,
    "sumTotal" bigint,
    pop double precision,
    inz_entries double precision,
    "inzsumTotal" double precision,
    mean7d double precision,
    inzmean7d double precision,
    prct double precision,
    "prctSumTotal" double precision,
    prct_mean7d double precision,
    "geoRegion" text,
    type text,
    type_variant text,
    data_completeness text,
    version text
);


ALTER TABLE switzerland.foph_hospvaccpersons OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_hospvaccpersons_d ( LIKE switzerland.foph_hospvaccpersons INCLUDING DEFAULTS );

--
-- Name: foph_hospvaccpersons_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_hospvaccpersons_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_hospvaccpersons_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_hospvaccpersons_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_hospvaccpersons_id__seq OWNED BY switzerland.foph_hospvaccpersons.id_;


--
-- Name: foph_intcases; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_intcases (
    id_ bigint NOT NULL,
    "geoRegion" text,
    "geoRegionName" text,
    date timestamp without time zone,
    entries double precision,
    population double precision,
    source text,
    sum14d double precision,
    "sumTotal" bigint,
    inz_entries double precision,
    inzsum14d double precision,
    "inzsumTotal" double precision,
    timeframe_14d boolean,
    timeframe_28d boolean,
    timeframe_phase2 boolean,
    timeframe_phase2b boolean,
    timeframe_phase3 boolean,
    timeframe_phase4 boolean,
    timeframe_phase5 boolean,
    timeframe_all boolean,
    type text,
    "geoLevel" text,
    version text,
    timeframe_phase6 boolean
);


ALTER TABLE switzerland.foph_intcases OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_intcases_d ( LIKE switzerland.foph_intcases INCLUDING DEFAULTS );

--
-- Name: foph_intcases_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_intcases_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_intcases_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_intcases_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_intcases_id__seq OWNED BY switzerland.foph_intcases.id_;


--
-- Name: foph_re; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_re (
    id_ bigint NOT NULL,
    "geoRegion" text,
    date timestamp without time zone,
    "median_R_mean" double precision,
    "median_R_highHPD" double precision,
    "median_R_lowHPD" double precision,
    timeframe_14d boolean,
    timeframe_28d boolean,
    timeframe_phase2 boolean,
    timeframe_phase2b boolean,
    timeframe_phase3 boolean,
    timeframe_phase4 boolean,
    timeframe_phase5 boolean,
    timeframe_all boolean,
    type text,
    version text,
    "median_R_mean_mean7d" double precision,
    timeframe_phase6 boolean
);


ALTER TABLE switzerland.foph_re OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_re_d ( LIKE switzerland.foph_re INCLUDING DEFAULTS );

--
-- Name: foph_re_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_re_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_re_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_re_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_re_id__seq OWNED BY switzerland.foph_re.id_;


--
-- Name: foph_test; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_test (
    id_ bigint NOT NULL,
    datum text,
    entries double precision,
    entries_pos double precision,
    entries_neg double precision,
    "sumTotal" double precision,
    timeframe_7d boolean,
    "sumTotal_last7d" double precision,
    timeframe_14d boolean,
    "sumTotal_last14d" double precision,
    timeframe_28d boolean,
    "sumTotal_last28d" double precision,
    timeframe_phase2 boolean,
    "sumTotal_Phase2" double precision,
    timeframe_phase2b boolean,
    "sumTotal_Phase2b" double precision,
    timeframe_phase3 boolean,
    "sumTotal_Phase3" double precision,
    timeframe_phase4 boolean,
    "sumTotal_Phase4" double precision,
    timeframe_phase5 boolean,
    "sumTotal_Phase5" double precision,
    sum7d double precision,
    sum14d double precision,
    mean7d double precision,
    mean14d double precision,
    pos_anteil double precision,
    pos_anteil_mean7d double precision,
    timeframe_all boolean,
    anteil_pos_all double precision,
    anteil_pos_14 double precision,
    anteil_pos_28 double precision,
    anteil_pos_phase2 double precision,
    anteil_pos_phase2b double precision,
    anteil_pos_phase3 double precision,
    anteil_pos_phase4 double precision,
    anteil_pos_phase5 double precision,
    pop double precision,
    inz_entries double precision,
    inzmean7d double precision,
    inzmean14d double precision,
    "inzsumTotal" double precision,
    "inzsumTotal_last7d" double precision,
    "inzsumTotal_last14d" double precision,
    "inzsumTotal_last28d" double precision,
    "inzsumTotal_Phase2" double precision,
    "inzsumTotal_Phase2b" double precision,
    "inzsumTotal_Phase3" double precision,
    "inzsumTotal_Phase4" double precision,
    "inzsumTotal_Phase5" double precision,
    inzsum7d double precision,
    inzsum14d double precision,
    type text,
    version text,
    datum_unit text,
    nachweismethode text,
    "geoRegion" text,
    entries_diff_last_age bigint,
    entries_diff_last bigint,
    date timestamp without time zone,
    timeframe_phase6 boolean,
    "sumTotal_Phase6" double precision,
    anteil_pos_phase6 double precision,
    "inzsumTotal_Phase6" double precision
);


ALTER TABLE switzerland.foph_test OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_test_d ( LIKE switzerland.foph_test INCLUDING DEFAULTS );

--
-- Name: foph_test_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_test_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_test_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_test_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_test_id__seq OWNED BY switzerland.foph_test.id_;


--
-- Name: foph_testpcrantigen; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_testpcrantigen (
    id_ bigint NOT NULL,
    datum text,
    entries double precision,
    entries_pos double precision,
    entries_neg double precision,
    "sumTotal" double precision,
    timeframe_7d boolean,
    "sumTotal_last7d" double precision,
    timeframe_14d boolean,
    "sumTotal_last14d" double precision,
    timeframe_28d boolean,
    "sumTotal_last28d" double precision,
    timeframe_phase2 boolean,
    "sumTotal_Phase2" double precision,
    timeframe_phase2b boolean,
    "sumTotal_Phase2b" double precision,
    timeframe_phase3 boolean,
    "sumTotal_Phase3" double precision,
    timeframe_phase4 boolean,
    "sumTotal_Phase4" double precision,
    timeframe_phase5 boolean,
    "sumTotal_Phase5" double precision,
    sum7d double precision,
    sum14d double precision,
    mean7d double precision,
    mean14d double precision,
    pos_anteil double precision,
    pos_anteil_mean7d double precision,
    timeframe_all boolean,
    anteil_pos_all double precision,
    anteil_pos_14 double precision,
    anteil_pos_28 double precision,
    anteil_pos_phase2 double precision,
    anteil_pos_phase2b double precision,
    anteil_pos_phase3 double precision,
    anteil_pos_phase4 double precision,
    anteil_pos_phase5 double precision,
    pop double precision,
    inz_entries double precision,
    inzmean7d double precision,
    inzmean14d double precision,
    "inzsumTotal" double precision,
    "inzsumTotal_last7d" double precision,
    "inzsumTotal_last14d" double precision,
    "inzsumTotal_last28d" double precision,
    "inzsumTotal_Phase2" double precision,
    "inzsumTotal_Phase2b" double precision,
    "inzsumTotal_Phase3" double precision,
    "inzsumTotal_Phase4" double precision,
    "inzsumTotal_Phase5" double precision,
    inzsum7d double precision,
    inzsum14d double precision,
    type text,
    version text,
    datum_unit text,
    nachweismethode text,
    "geoRegion" text,
    entries_diff_last_age bigint,
    entries_diff_last bigint,
    date timestamp without time zone,
    timeframe_phase6 boolean,
    "sumTotal_Phase6" double precision,
    anteil_pos_phase6 double precision,
    "inzsumTotal_Phase6" double precision
);


ALTER TABLE switzerland.foph_testpcrantigen OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_testpcrantigen_d ( LIKE switzerland.foph_testpcrantigen INCLUDING DEFAULTS );

--
-- Name: foph_testpcrantigen_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_testpcrantigen_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_testpcrantigen_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_testpcrantigen_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_testpcrantigen_id__seq OWNED BY switzerland.foph_testpcrantigen.id_;


--
-- Name: foph_virusvariantswgs; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.foph_virusvariantswgs (
    id_ bigint NOT NULL,
    "geoRegion" text,
    variant_type text,
    date timestamp without time zone,
    entries bigint,
    "sumTotal" bigint,
    freq double precision,
    prct double precision,
    prct_lower_ci double precision,
    prct_upper_ci double precision,
    prct_mean7d double precision,
    timeframe_all boolean,
    type text,
    version text,
    classification text,
    data_source text
);


ALTER TABLE switzerland.foph_virusvariantswgs OWNER TO dev_epigraph;

CREATE TABLE switzerland.foph_virusvariantswgs_d ( LIKE switzerland.foph_virusvariantswgs INCLUDING DEFAULTS );

--
-- Name: foph_virusvariantswgs_id__seq; Type: SEQUENCE; Schema: switzerland; Owner: dev_epigraph
--

CREATE SEQUENCE switzerland.foph_virusvariantswgs_id__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE switzerland.foph_virusvariantswgs_id__seq OWNER TO dev_epigraph;

--
-- Name: foph_virusvariantswgs_id__seq; Type: SEQUENCE OWNED BY; Schema: switzerland; Owner: dev_epigraph
--

ALTER SEQUENCE switzerland.foph_virusvariantswgs_id__seq OWNED BY switzerland.foph_virusvariantswgs.id_;


--
-- Name: janne_scenario_1; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.janne_scenario_1 (
    "Date" timestamp without time zone,
    "Unnamed: 0" bigint,
    "Infections_children" bigint,
    "Infections_adults" bigint,
    "Infetions_senior" bigint,
    "New_hospitalisations_adult" bigint,
    "New_hospitalisations_senior" bigint,
    "Deaths_adult" bigint,
    "Deaths_senior" bigint,
    "In_normalward_adult" bigint,
    "In_ICU_adult" bigint,
    "In_normalward_senior" bigint,
    "In_ICU_senior" bigint,
    "New_hospitalisations" bigint,
    "Total_hospitalisations" bigint,
    "Total_ICU" bigint
);


ALTER TABLE switzerland.janne_scenario_1 OWNER TO dev_epigraph;

--
-- Name: janne_scenario_2; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.janne_scenario_2 (
    "Date" timestamp without time zone,
    "Infections_children" bigint,
    "Infections_adults" bigint,
    "Infetions_senior" bigint,
    "New_hospitalisations_adult" bigint,
    "New_hospitalisations_senior" bigint,
    "Deaths_adult" bigint,
    "Deaths_senior" bigint,
    "In_normalward_adult" bigint,
    "In_ICU_adult" bigint,
    "In_normalward_senior" bigint,
    "In_ICU_senior" bigint,
    "New_hospitalisations" bigint,
    "Total_hospitalisations" bigint,
    "Total_ICU" bigint
);


ALTER TABLE switzerland.janne_scenario_2 OWNER TO dev_epigraph;

--
-- Name: janne_scenario_3; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.janne_scenario_3 (
    "Date" timestamp without time zone,
    "Infections_children" bigint,
    "Infections_adults" bigint,
    "Infetions_senior" bigint,
    "New_hospitalisations_adult" bigint,
    "New_hospitalisations_senior" bigint,
    "Deaths_adult" bigint,
    "Deaths_senior" bigint,
    "In_normalward_adult" bigint,
    "In_ICU_adult" bigint,
    "In_normalward_senior" bigint,
    "In_ICU_senior" bigint,
    "New_hospitalisations" bigint,
    "Total_hospitalisations" bigint,
    "Total_ICU" bigint
);


ALTER TABLE switzerland.janne_scenario_3 OWNER TO dev_epigraph;

--
-- Name: janne_scenario_4; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.janne_scenario_4 (
    "Date" timestamp without time zone,
    "Infections_children" bigint,
    "Infections_adults" bigint,
    "Infetions_senior" bigint,
    "New_hospitalisations_adult" bigint,
    "New_hospitalisations_senior" bigint,
    "Deaths_adult" bigint,
    "Deaths_senior" bigint,
    "In_normalward_adult" bigint,
    "In_ICU_adult" bigint,
    "In_normalward_senior" bigint,
    "In_ICU_senior" bigint,
    "New_hospitalisations" bigint,
    "Total_hospitalisations" bigint,
    "Total_ICU" bigint
);


ALTER TABLE switzerland.janne_scenario_4 OWNER TO dev_epigraph;

--
-- Name: map_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.map_cantons (
    "GID_0" text,
    "NAME_0" text,
    "GID_1" text,
    "NAME_1" text,
    "VARNAME_1" text,
    "NL_NAME_1" text,
    "TYPE_1" text,
    "ENGTYPE_1" text,
    "CC_1" text,
    "HASC_1" text,
    geometry public.geometry(MultiPolygon,4326)
);


ALTER TABLE switzerland.map_cantons OWNER TO dev_epigraph;

--
-- Name: ml_for_hosp_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_for_hosp_all_cantons (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_for_hosp_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_for_icu_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_for_icu_all_cantons (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_for_icu_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_for_total_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_for_total_all_cantons (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_for_total_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_forecast; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision
);


ALTER TABLE switzerland.ml_forecast OWNER TO dev_epigraph;

--
-- Name: ml_forecast_hosp; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast_hosp (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_forecast_hosp OWNER TO dev_epigraph;

--
-- Name: ml_forecast_hosp_up; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast_hosp_up (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_forecast_hosp_up OWNER TO dev_epigraph;

--
-- Name: ml_forecast_icu; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast_icu (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_forecast_icu OWNER TO dev_epigraph;

--
-- Name: ml_forecast_icu_up; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast_icu_up (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision
);


ALTER TABLE switzerland.ml_forecast_icu_up OWNER TO dev_epigraph;

--
-- Name: ml_forecast_total; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_forecast_total (
    index bigint,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    canton text
);


ALTER TABLE switzerland.ml_forecast_total OWNER TO dev_epigraph;

--
-- Name: ml_val_hosp_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_val_hosp_all_cantons (
    index bigint,
    target double precision,
    date text,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.ml_val_hosp_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_val_icu_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_val_icu_all_cantons (
    index bigint,
    target double precision,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.ml_val_icu_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_val_total_all_cantons; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_val_total_all_cantons (
    index bigint,
    target double precision,
    date text,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.ml_val_total_all_cantons OWNER TO dev_epigraph;

--
-- Name: ml_validation; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_validation (
    index timestamp without time zone,
    target double precision,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint
);


ALTER TABLE switzerland.ml_validation OWNER TO dev_epigraph;

--
-- Name: ml_validation_hosp_up; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_validation_hosp_up (
    index timestamp without time zone,
    target double precision,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint
);


ALTER TABLE switzerland.ml_validation_hosp_up OWNER TO dev_epigraph;

--
-- Name: ml_validation_icu; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_validation_icu (
    index bigint,
    target double precision,
    date text,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.ml_validation_icu OWNER TO dev_epigraph;

--
-- Name: ml_validation_icu_up; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_validation_icu_up (
    index timestamp without time zone,
    target double precision,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint
);


ALTER TABLE switzerland.ml_validation_icu_up OWNER TO dev_epigraph;

--
-- Name: ml_validation_total; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.ml_validation_total (
    index timestamp without time zone,
    target double precision,
    date timestamp without time zone,
    lower double precision,
    median double precision,
    upper double precision,
    train_size bigint,
    canton text
);


ALTER TABLE switzerland.ml_validation_total OWNER TO dev_epigraph;

--
-- Name: phosp_post; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.phosp_post (
    datum timestamp without time zone,
    median double precision,
    lower double precision,
    upper double precision
);


ALTER TABLE switzerland.phosp_post OWNER TO dev_epigraph;

--
-- Name: prev_post; Type: TABLE; Schema: switzerland; Owner: dev_epigraph
--

CREATE TABLE switzerland.prev_post (
    datum timestamp without time zone,
    median double precision,
    lower double precision,
    upper double precision
);


ALTER TABLE switzerland.prev_post OWNER TO dev_epigraph;

--
-- Name: foph_cases id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_cases ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_cases_id__seq'::regclass);


--
-- Name: foph_casesvaccpersons id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_casesvaccpersons ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_casesvaccpersons_id__seq'::regclass);


--
-- Name: foph_covidcertificates id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_covidcertificates ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_covidcertificates_id__seq'::regclass);


--
-- Name: foph_death id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_death ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_death_id__seq'::regclass);


--
-- Name: foph_deathvaccpersons id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_deathvaccpersons ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_deathvaccpersons_id__seq'::regclass);


--
-- Name: foph_hosp id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hosp ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_hosp_id__seq'::regclass);


--
-- Name: foph_hospcapacity id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hospcapacity ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_hospcapacity_id__seq'::regclass);


--
-- Name: foph_hospvaccpersons id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hospvaccpersons ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_hospvaccpersons_id__seq'::regclass);


--
-- Name: foph_intcases id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_intcases ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_intcases_id__seq'::regclass);


--
-- Name: foph_re id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_re ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_re_id__seq'::regclass);


--
-- Name: foph_test id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_test ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_test_id__seq'::regclass);


--
-- Name: foph_testpcrantigen id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_testpcrantigen ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_testpcrantigen_id__seq'::regclass);


--
-- Name: foph_virusvariantswgs id_; Type: DEFAULT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_virusvariantswgs ALTER COLUMN id_ SET DEFAULT nextval('switzerland.foph_virusvariantswgs_id__seq'::regclass);


--
-- Name: foph_cases foph_cases_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_cases
    ADD CONSTRAINT foph_cases_pkey PRIMARY KEY (id_);


--
-- Name: foph_casesvaccpersons foph_casesvaccpersons_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_casesvaccpersons
    ADD CONSTRAINT foph_casesvaccpersons_pkey PRIMARY KEY (id_);


--
-- Name: foph_covidcertificates foph_covidcertificates_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_covidcertificates
    ADD CONSTRAINT foph_covidcertificates_pkey PRIMARY KEY (id_);


--
-- Name: foph_death foph_death_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_death
    ADD CONSTRAINT foph_death_pkey PRIMARY KEY (id_);


--
-- Name: foph_deathvaccpersons foph_deathvaccpersons_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_deathvaccpersons
    ADD CONSTRAINT foph_deathvaccpersons_pkey PRIMARY KEY (id_);


--
-- Name: foph_hosp foph_hosp_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hosp
    ADD CONSTRAINT foph_hosp_pkey PRIMARY KEY (id_);


--
-- Name: foph_hospcapacity foph_hospcapacity_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hospcapacity
    ADD CONSTRAINT foph_hospcapacity_pkey PRIMARY KEY (id_);


--
-- Name: foph_hospvaccpersons foph_hospvaccpersons_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_hospvaccpersons
    ADD CONSTRAINT foph_hospvaccpersons_pkey PRIMARY KEY (id_);


--
-- Name: foph_intcases foph_intcases_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_intcases
    ADD CONSTRAINT foph_intcases_pkey PRIMARY KEY (id_);


--
-- Name: foph_re foph_re_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_re
    ADD CONSTRAINT foph_re_pkey PRIMARY KEY (id_);


--
-- Name: foph_test foph_test_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_test
    ADD CONSTRAINT foph_test_pkey PRIMARY KEY (id_);


--
-- Name: foph_testpcrantigen foph_testpcrantigen_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_testpcrantigen
    ADD CONSTRAINT foph_testpcrantigen_pkey PRIMARY KEY (id_);


--
-- Name: foph_virusvariantswgs foph_virusvariantswgs_pkey; Type: CONSTRAINT; Schema: switzerland; Owner: dev_epigraph
--

ALTER TABLE ONLY switzerland.foph_virusvariantswgs
    ADD CONSTRAINT foph_virusvariantswgs_pkey PRIMARY KEY (id_);


--
-- Name: ix_brasil_caso_full_index; Type: INDEX; Schema: brasil; Owner: dev_epigraph
--

CREATE INDEX ix_brasil_caso_full_index ON brasil.caso_full USING btree (index);


--
-- Name: ix_brasil_data_SARI_16_08_21.csv_index; Type: INDEX; Schema: brasil; Owner: dev_epigraph
--

CREATE INDEX "ix_brasil_data_SARI_16_08_21.csv_index" ON brasil."data_SARI_16_08_21.csv" USING btree (index);


--
-- Name: ix_colombia_casos_positivos_covid_index; Type: INDEX; Schema: colombia; Owner: dev_epigraph
--

CREATE INDEX ix_colombia_casos_positivos_covid_index ON colombia.casos_positivos_covid USING btree (index);


--
-- Name: country_idx; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX country_idx ON public.owid_covid USING btree (location);


--
-- Name: date_idx; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX date_idx ON public.owid_covid USING btree (date);


--
-- Name: idx_ABW_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ABW_0_geometry" ON public."ABW_0" USING gist (geometry);


--
-- Name: idx_AFG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AFG_0_geometry" ON public."AFG_0" USING gist (geometry);


--
-- Name: idx_AFG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AFG_1_geometry" ON public."AFG_1" USING gist (geometry);


--
-- Name: idx_AFG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AFG_2_geometry" ON public."AFG_2" USING gist (geometry);


--
-- Name: idx_AGO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AGO_0_geometry" ON public."AGO_0" USING gist (geometry);


--
-- Name: idx_AGO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AGO_1_geometry" ON public."AGO_1" USING gist (geometry);


--
-- Name: idx_AGO_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AGO_2_geometry" ON public."AGO_2" USING gist (geometry);


--
-- Name: idx_AGO_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AGO_3_geometry" ON public."AGO_3" USING gist (geometry);


--
-- Name: idx_AIA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AIA_0_geometry" ON public."AIA_0" USING gist (geometry);


--
-- Name: idx_ALA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALA_0_geometry" ON public."ALA_0" USING gist (geometry);


--
-- Name: idx_ALA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALA_1_geometry" ON public."ALA_1" USING gist (geometry);


--
-- Name: idx_ALB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALB_0_geometry" ON public."ALB_0" USING gist (geometry);


--
-- Name: idx_ALB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALB_1_geometry" ON public."ALB_1" USING gist (geometry);


--
-- Name: idx_ALB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALB_2_geometry" ON public."ALB_2" USING gist (geometry);


--
-- Name: idx_ALB_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ALB_3_geometry" ON public."ALB_3" USING gist (geometry);


--
-- Name: idx_AND_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AND_0_geometry" ON public."AND_0" USING gist (geometry);


--
-- Name: idx_AND_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AND_1_geometry" ON public."AND_1" USING gist (geometry);


--
-- Name: idx_ARE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARE_0_geometry" ON public."ARE_0" USING gist (geometry);


--
-- Name: idx_ARE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARE_1_geometry" ON public."ARE_1" USING gist (geometry);


--
-- Name: idx_ARE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARE_2_geometry" ON public."ARE_2" USING gist (geometry);


--
-- Name: idx_ARE_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARE_3_geometry" ON public."ARE_3" USING gist (geometry);


--
-- Name: idx_ARG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARG_0_geometry" ON public."ARG_0" USING gist (geometry);


--
-- Name: idx_ARG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARG_1_geometry" ON public."ARG_1" USING gist (geometry);


--
-- Name: idx_ARG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARG_2_geometry" ON public."ARG_2" USING gist (geometry);


--
-- Name: idx_ARM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARM_0_geometry" ON public."ARM_0" USING gist (geometry);


--
-- Name: idx_ARM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ARM_1_geometry" ON public."ARM_1" USING gist (geometry);


--
-- Name: idx_ASM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ASM_0_geometry" ON public."ASM_0" USING gist (geometry);


--
-- Name: idx_ASM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ASM_1_geometry" ON public."ASM_1" USING gist (geometry);


--
-- Name: idx_ASM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ASM_2_geometry" ON public."ASM_2" USING gist (geometry);


--
-- Name: idx_ASM_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ASM_3_geometry" ON public."ASM_3" USING gist (geometry);


--
-- Name: idx_ATA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ATA_0_geometry" ON public."ATA_0" USING gist (geometry);


--
-- Name: idx_ATF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ATF_0_geometry" ON public."ATF_0" USING gist (geometry);


--
-- Name: idx_ATF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ATF_1_geometry" ON public."ATF_1" USING gist (geometry);


--
-- Name: idx_ATG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ATG_0_geometry" ON public."ATG_0" USING gist (geometry);


--
-- Name: idx_ATG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ATG_1_geometry" ON public."ATG_1" USING gist (geometry);


--
-- Name: idx_AUS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUS_0_geometry" ON public."AUS_0" USING gist (geometry);


--
-- Name: idx_AUS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUS_1_geometry" ON public."AUS_1" USING gist (geometry);


--
-- Name: idx_AUS_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUS_2_geometry" ON public."AUS_2" USING gist (geometry);


--
-- Name: idx_AUT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUT_0_geometry" ON public."AUT_0" USING gist (geometry);


--
-- Name: idx_AUT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUT_1_geometry" ON public."AUT_1" USING gist (geometry);


--
-- Name: idx_AUT_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUT_2_geometry" ON public."AUT_2" USING gist (geometry);


--
-- Name: idx_AUT_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AUT_3_geometry" ON public."AUT_3" USING gist (geometry);


--
-- Name: idx_AZE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AZE_0_geometry" ON public."AZE_0" USING gist (geometry);


--
-- Name: idx_AZE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AZE_1_geometry" ON public."AZE_1" USING gist (geometry);


--
-- Name: idx_AZE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_AZE_2_geometry" ON public."AZE_2" USING gist (geometry);


--
-- Name: idx_BDI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BDI_0_geometry" ON public."BDI_0" USING gist (geometry);


--
-- Name: idx_BDI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BDI_1_geometry" ON public."BDI_1" USING gist (geometry);


--
-- Name: idx_BDI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BDI_2_geometry" ON public."BDI_2" USING gist (geometry);


--
-- Name: idx_BDI_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BDI_3_geometry" ON public."BDI_3" USING gist (geometry);


--
-- Name: idx_BDI_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BDI_4_geometry" ON public."BDI_4" USING gist (geometry);


--
-- Name: idx_BEL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEL_0_geometry" ON public."BEL_0" USING gist (geometry);


--
-- Name: idx_BEL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEL_1_geometry" ON public."BEL_1" USING gist (geometry);


--
-- Name: idx_BEL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEL_2_geometry" ON public."BEL_2" USING gist (geometry);


--
-- Name: idx_BEL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEL_3_geometry" ON public."BEL_3" USING gist (geometry);


--
-- Name: idx_BEL_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEL_4_geometry" ON public."BEL_4" USING gist (geometry);


--
-- Name: idx_BEN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEN_0_geometry" ON public."BEN_0" USING gist (geometry);


--
-- Name: idx_BEN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEN_1_geometry" ON public."BEN_1" USING gist (geometry);


--
-- Name: idx_BEN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BEN_2_geometry" ON public."BEN_2" USING gist (geometry);


--
-- Name: idx_BFA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BFA_0_geometry" ON public."BFA_0" USING gist (geometry);


--
-- Name: idx_BFA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BFA_1_geometry" ON public."BFA_1" USING gist (geometry);


--
-- Name: idx_BFA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BFA_2_geometry" ON public."BFA_2" USING gist (geometry);


--
-- Name: idx_BFA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BFA_3_geometry" ON public."BFA_3" USING gist (geometry);


--
-- Name: idx_BGD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGD_0_geometry" ON public."BGD_0" USING gist (geometry);


--
-- Name: idx_BGD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGD_1_geometry" ON public."BGD_1" USING gist (geometry);


--
-- Name: idx_BGD_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGD_2_geometry" ON public."BGD_2" USING gist (geometry);


--
-- Name: idx_BGD_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGD_3_geometry" ON public."BGD_3" USING gist (geometry);


--
-- Name: idx_BGD_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGD_4_geometry" ON public."BGD_4" USING gist (geometry);


--
-- Name: idx_BGR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGR_0_geometry" ON public."BGR_0" USING gist (geometry);


--
-- Name: idx_BGR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGR_1_geometry" ON public."BGR_1" USING gist (geometry);


--
-- Name: idx_BGR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BGR_2_geometry" ON public."BGR_2" USING gist (geometry);


--
-- Name: idx_BHR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BHR_0_geometry" ON public."BHR_0" USING gist (geometry);


--
-- Name: idx_BHR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BHR_1_geometry" ON public."BHR_1" USING gist (geometry);


--
-- Name: idx_BHS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BHS_0_geometry" ON public."BHS_0" USING gist (geometry);


--
-- Name: idx_BHS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BHS_1_geometry" ON public."BHS_1" USING gist (geometry);


--
-- Name: idx_BIH_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BIH_0_geometry" ON public."BIH_0" USING gist (geometry);


--
-- Name: idx_BIH_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BIH_1_geometry" ON public."BIH_1" USING gist (geometry);


--
-- Name: idx_BIH_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BIH_2_geometry" ON public."BIH_2" USING gist (geometry);


--
-- Name: idx_BIH_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BIH_3_geometry" ON public."BIH_3" USING gist (geometry);


--
-- Name: idx_BLM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLM_0_geometry" ON public."BLM_0" USING gist (geometry);


--
-- Name: idx_BLR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLR_0_geometry" ON public."BLR_0" USING gist (geometry);


--
-- Name: idx_BLR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLR_1_geometry" ON public."BLR_1" USING gist (geometry);


--
-- Name: idx_BLR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLR_2_geometry" ON public."BLR_2" USING gist (geometry);


--
-- Name: idx_BLZ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLZ_0_geometry" ON public."BLZ_0" USING gist (geometry);


--
-- Name: idx_BLZ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BLZ_1_geometry" ON public."BLZ_1" USING gist (geometry);


--
-- Name: idx_BMU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BMU_0_geometry" ON public."BMU_0" USING gist (geometry);


--
-- Name: idx_BMU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BMU_1_geometry" ON public."BMU_1" USING gist (geometry);


--
-- Name: idx_BOL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BOL_0_geometry" ON public."BOL_0" USING gist (geometry);


--
-- Name: idx_BOL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BOL_1_geometry" ON public."BOL_1" USING gist (geometry);


--
-- Name: idx_BOL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BOL_2_geometry" ON public."BOL_2" USING gist (geometry);


--
-- Name: idx_BOL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BOL_3_geometry" ON public."BOL_3" USING gist (geometry);


--
-- Name: idx_BRA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRA_0_geometry" ON public."BRA_0" USING gist (geometry);


--
-- Name: idx_BRA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRA_1_geometry" ON public."BRA_1" USING gist (geometry);


--
-- Name: idx_BRA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRA_2_geometry" ON public."BRA_2" USING gist (geometry);


--
-- Name: idx_BRA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRA_3_geometry" ON public."BRA_3" USING gist (geometry);


--
-- Name: idx_BRB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRB_0_geometry" ON public."BRB_0" USING gist (geometry);


--
-- Name: idx_BRB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRB_1_geometry" ON public."BRB_1" USING gist (geometry);


--
-- Name: idx_BRN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRN_0_geometry" ON public."BRN_0" USING gist (geometry);


--
-- Name: idx_BRN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRN_1_geometry" ON public."BRN_1" USING gist (geometry);


--
-- Name: idx_BRN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BRN_2_geometry" ON public."BRN_2" USING gist (geometry);


--
-- Name: idx_BTN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BTN_0_geometry" ON public."BTN_0" USING gist (geometry);


--
-- Name: idx_BTN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BTN_1_geometry" ON public."BTN_1" USING gist (geometry);


--
-- Name: idx_BTN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BTN_2_geometry" ON public."BTN_2" USING gist (geometry);


--
-- Name: idx_BVT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BVT_0_geometry" ON public."BVT_0" USING gist (geometry);


--
-- Name: idx_BWA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BWA_0_geometry" ON public."BWA_0" USING gist (geometry);


--
-- Name: idx_BWA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BWA_1_geometry" ON public."BWA_1" USING gist (geometry);


--
-- Name: idx_BWA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_BWA_2_geometry" ON public."BWA_2" USING gist (geometry);


--
-- Name: idx_CAF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAF_0_geometry" ON public."CAF_0" USING gist (geometry);


--
-- Name: idx_CAF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAF_1_geometry" ON public."CAF_1" USING gist (geometry);


--
-- Name: idx_CAF_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAF_2_geometry" ON public."CAF_2" USING gist (geometry);


--
-- Name: idx_CAN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAN_0_geometry" ON public."CAN_0" USING gist (geometry);


--
-- Name: idx_CAN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAN_1_geometry" ON public."CAN_1" USING gist (geometry);


--
-- Name: idx_CAN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAN_2_geometry" ON public."CAN_2" USING gist (geometry);


--
-- Name: idx_CAN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CAN_3_geometry" ON public."CAN_3" USING gist (geometry);


--
-- Name: idx_CCK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CCK_0_geometry" ON public."CCK_0" USING gist (geometry);


--
-- Name: idx_CHE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHE_0_geometry" ON public."CHE_0" USING gist (geometry);


--
-- Name: idx_CHE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHE_1_geometry" ON public."CHE_1" USING gist (geometry);


--
-- Name: idx_CHE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHE_2_geometry" ON public."CHE_2" USING gist (geometry);


--
-- Name: idx_CHE_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHE_3_geometry" ON public."CHE_3" USING gist (geometry);


--
-- Name: idx_CHL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHL_0_geometry" ON public."CHL_0" USING gist (geometry);


--
-- Name: idx_CHL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHL_1_geometry" ON public."CHL_1" USING gist (geometry);


--
-- Name: idx_CHL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHL_2_geometry" ON public."CHL_2" USING gist (geometry);


--
-- Name: idx_CHL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHL_3_geometry" ON public."CHL_3" USING gist (geometry);


--
-- Name: idx_CHN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHN_0_geometry" ON public."CHN_0" USING gist (geometry);


--
-- Name: idx_CHN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHN_1_geometry" ON public."CHN_1" USING gist (geometry);


--
-- Name: idx_CHN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHN_2_geometry" ON public."CHN_2" USING gist (geometry);


--
-- Name: idx_CHN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CHN_3_geometry" ON public."CHN_3" USING gist (geometry);


--
-- Name: idx_CIV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CIV_0_geometry" ON public."CIV_0" USING gist (geometry);


--
-- Name: idx_CIV_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CIV_1_geometry" ON public."CIV_1" USING gist (geometry);


--
-- Name: idx_CIV_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CIV_2_geometry" ON public."CIV_2" USING gist (geometry);


--
-- Name: idx_CIV_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CIV_3_geometry" ON public."CIV_3" USING gist (geometry);


--
-- Name: idx_CIV_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CIV_4_geometry" ON public."CIV_4" USING gist (geometry);


--
-- Name: idx_CMR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CMR_0_geometry" ON public."CMR_0" USING gist (geometry);


--
-- Name: idx_CMR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CMR_1_geometry" ON public."CMR_1" USING gist (geometry);


--
-- Name: idx_CMR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CMR_2_geometry" ON public."CMR_2" USING gist (geometry);


--
-- Name: idx_CMR_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CMR_3_geometry" ON public."CMR_3" USING gist (geometry);


--
-- Name: idx_COD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COD_0_geometry" ON public."COD_0" USING gist (geometry);


--
-- Name: idx_COD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COD_1_geometry" ON public."COD_1" USING gist (geometry);


--
-- Name: idx_COD_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COD_2_geometry" ON public."COD_2" USING gist (geometry);


--
-- Name: idx_COG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COG_0_geometry" ON public."COG_0" USING gist (geometry);


--
-- Name: idx_COG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COG_1_geometry" ON public."COG_1" USING gist (geometry);


--
-- Name: idx_COG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COG_2_geometry" ON public."COG_2" USING gist (geometry);


--
-- Name: idx_COK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COK_0_geometry" ON public."COK_0" USING gist (geometry);


--
-- Name: idx_COL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COL_0_geometry" ON public."COL_0" USING gist (geometry);


--
-- Name: idx_COL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COL_1_geometry" ON public."COL_1" USING gist (geometry);


--
-- Name: idx_COL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COL_2_geometry" ON public."COL_2" USING gist (geometry);


--
-- Name: idx_COM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COM_0_geometry" ON public."COM_0" USING gist (geometry);


--
-- Name: idx_COM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_COM_1_geometry" ON public."COM_1" USING gist (geometry);


--
-- Name: idx_CPV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CPV_0_geometry" ON public."CPV_0" USING gist (geometry);


--
-- Name: idx_CPV_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CPV_1_geometry" ON public."CPV_1" USING gist (geometry);


--
-- Name: idx_CRI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CRI_0_geometry" ON public."CRI_0" USING gist (geometry);


--
-- Name: idx_CRI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CRI_1_geometry" ON public."CRI_1" USING gist (geometry);


--
-- Name: idx_CRI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CRI_2_geometry" ON public."CRI_2" USING gist (geometry);


--
-- Name: idx_CUB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CUB_0_geometry" ON public."CUB_0" USING gist (geometry);


--
-- Name: idx_CUB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CUB_1_geometry" ON public."CUB_1" USING gist (geometry);


--
-- Name: idx_CUB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CUB_2_geometry" ON public."CUB_2" USING gist (geometry);


--
-- Name: idx_CXR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CXR_0_geometry" ON public."CXR_0" USING gist (geometry);


--
-- Name: idx_CYM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CYM_0_geometry" ON public."CYM_0" USING gist (geometry);


--
-- Name: idx_CYM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CYM_1_geometry" ON public."CYM_1" USING gist (geometry);


--
-- Name: idx_CYP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CYP_0_geometry" ON public."CYP_0" USING gist (geometry);


--
-- Name: idx_CYP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CYP_1_geometry" ON public."CYP_1" USING gist (geometry);


--
-- Name: idx_CZE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CZE_0_geometry" ON public."CZE_0" USING gist (geometry);


--
-- Name: idx_CZE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CZE_1_geometry" ON public."CZE_1" USING gist (geometry);


--
-- Name: idx_CZE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_CZE_2_geometry" ON public."CZE_2" USING gist (geometry);


--
-- Name: idx_DEU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DEU_0_geometry" ON public."DEU_0" USING gist (geometry);


--
-- Name: idx_DEU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DEU_1_geometry" ON public."DEU_1" USING gist (geometry);


--
-- Name: idx_DEU_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DEU_2_geometry" ON public."DEU_2" USING gist (geometry);


--
-- Name: idx_DEU_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DEU_3_geometry" ON public."DEU_3" USING gist (geometry);


--
-- Name: idx_DEU_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DEU_4_geometry" ON public."DEU_4" USING gist (geometry);


--
-- Name: idx_DJI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DJI_0_geometry" ON public."DJI_0" USING gist (geometry);


--
-- Name: idx_DJI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DJI_1_geometry" ON public."DJI_1" USING gist (geometry);


--
-- Name: idx_DJI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DJI_2_geometry" ON public."DJI_2" USING gist (geometry);


--
-- Name: idx_DMA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DMA_0_geometry" ON public."DMA_0" USING gist (geometry);


--
-- Name: idx_DMA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DMA_1_geometry" ON public."DMA_1" USING gist (geometry);


--
-- Name: idx_DNK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DNK_0_geometry" ON public."DNK_0" USING gist (geometry);


--
-- Name: idx_DNK_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DNK_1_geometry" ON public."DNK_1" USING gist (geometry);


--
-- Name: idx_DNK_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DNK_2_geometry" ON public."DNK_2" USING gist (geometry);


--
-- Name: idx_DOM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DOM_0_geometry" ON public."DOM_0" USING gist (geometry);


--
-- Name: idx_DOM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DOM_1_geometry" ON public."DOM_1" USING gist (geometry);


--
-- Name: idx_DOM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DOM_2_geometry" ON public."DOM_2" USING gist (geometry);


--
-- Name: idx_DZA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DZA_0_geometry" ON public."DZA_0" USING gist (geometry);


--
-- Name: idx_DZA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DZA_1_geometry" ON public."DZA_1" USING gist (geometry);


--
-- Name: idx_DZA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_DZA_2_geometry" ON public."DZA_2" USING gist (geometry);


--
-- Name: idx_ECU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ECU_0_geometry" ON public."ECU_0" USING gist (geometry);


--
-- Name: idx_ECU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ECU_1_geometry" ON public."ECU_1" USING gist (geometry);


--
-- Name: idx_ECU_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ECU_2_geometry" ON public."ECU_2" USING gist (geometry);


--
-- Name: idx_ECU_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ECU_3_geometry" ON public."ECU_3" USING gist (geometry);


--
-- Name: idx_EGY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EGY_0_geometry" ON public."EGY_0" USING gist (geometry);


--
-- Name: idx_EGY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EGY_1_geometry" ON public."EGY_1" USING gist (geometry);


--
-- Name: idx_EGY_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EGY_2_geometry" ON public."EGY_2" USING gist (geometry);


--
-- Name: idx_ERI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ERI_0_geometry" ON public."ERI_0" USING gist (geometry);


--
-- Name: idx_ERI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ERI_1_geometry" ON public."ERI_1" USING gist (geometry);


--
-- Name: idx_ERI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ERI_2_geometry" ON public."ERI_2" USING gist (geometry);


--
-- Name: idx_ESH_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESH_0_geometry" ON public."ESH_0" USING gist (geometry);


--
-- Name: idx_ESH_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESH_1_geometry" ON public."ESH_1" USING gist (geometry);


--
-- Name: idx_ESP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESP_0_geometry" ON public."ESP_0" USING gist (geometry);


--
-- Name: idx_ESP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESP_1_geometry" ON public."ESP_1" USING gist (geometry);


--
-- Name: idx_ESP_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESP_2_geometry" ON public."ESP_2" USING gist (geometry);


--
-- Name: idx_ESP_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESP_3_geometry" ON public."ESP_3" USING gist (geometry);


--
-- Name: idx_ESP_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ESP_4_geometry" ON public."ESP_4" USING gist (geometry);


--
-- Name: idx_EST_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EST_0_geometry" ON public."EST_0" USING gist (geometry);


--
-- Name: idx_EST_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EST_1_geometry" ON public."EST_1" USING gist (geometry);


--
-- Name: idx_EST_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EST_2_geometry" ON public."EST_2" USING gist (geometry);


--
-- Name: idx_EST_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_EST_3_geometry" ON public."EST_3" USING gist (geometry);


--
-- Name: idx_ETH_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ETH_0_geometry" ON public."ETH_0" USING gist (geometry);


--
-- Name: idx_ETH_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ETH_1_geometry" ON public."ETH_1" USING gist (geometry);


--
-- Name: idx_ETH_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ETH_2_geometry" ON public."ETH_2" USING gist (geometry);


--
-- Name: idx_ETH_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ETH_3_geometry" ON public."ETH_3" USING gist (geometry);


--
-- Name: idx_FIN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FIN_0_geometry" ON public."FIN_0" USING gist (geometry);


--
-- Name: idx_FIN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FIN_1_geometry" ON public."FIN_1" USING gist (geometry);


--
-- Name: idx_FIN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FIN_2_geometry" ON public."FIN_2" USING gist (geometry);


--
-- Name: idx_FIN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FIN_3_geometry" ON public."FIN_3" USING gist (geometry);


--
-- Name: idx_FIN_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FIN_4_geometry" ON public."FIN_4" USING gist (geometry);


--
-- Name: idx_FJI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FJI_0_geometry" ON public."FJI_0" USING gist (geometry);


--
-- Name: idx_FJI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FJI_1_geometry" ON public."FJI_1" USING gist (geometry);


--
-- Name: idx_FJI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FJI_2_geometry" ON public."FJI_2" USING gist (geometry);


--
-- Name: idx_FLK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FLK_0_geometry" ON public."FLK_0" USING gist (geometry);


--
-- Name: idx_FRA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_0_geometry" ON public."FRA_0" USING gist (geometry);


--
-- Name: idx_FRA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_1_geometry" ON public."FRA_1" USING gist (geometry);


--
-- Name: idx_FRA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_2_geometry" ON public."FRA_2" USING gist (geometry);


--
-- Name: idx_FRA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_3_geometry" ON public."FRA_3" USING gist (geometry);


--
-- Name: idx_FRA_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_4_geometry" ON public."FRA_4" USING gist (geometry);


--
-- Name: idx_FRA_5_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRA_5_geometry" ON public."FRA_5" USING gist (geometry);


--
-- Name: idx_FRO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRO_0_geometry" ON public."FRO_0" USING gist (geometry);


--
-- Name: idx_FRO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRO_1_geometry" ON public."FRO_1" USING gist (geometry);


--
-- Name: idx_FRO_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FRO_2_geometry" ON public."FRO_2" USING gist (geometry);


--
-- Name: idx_FSM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FSM_0_geometry" ON public."FSM_0" USING gist (geometry);


--
-- Name: idx_FSM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_FSM_1_geometry" ON public."FSM_1" USING gist (geometry);


--
-- Name: idx_GAB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GAB_0_geometry" ON public."GAB_0" USING gist (geometry);


--
-- Name: idx_GAB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GAB_1_geometry" ON public."GAB_1" USING gist (geometry);


--
-- Name: idx_GAB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GAB_2_geometry" ON public."GAB_2" USING gist (geometry);


--
-- Name: idx_GBR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GBR_0_geometry" ON public."GBR_0" USING gist (geometry);


--
-- Name: idx_GBR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GBR_1_geometry" ON public."GBR_1" USING gist (geometry);


--
-- Name: idx_GBR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GBR_2_geometry" ON public."GBR_2" USING gist (geometry);


--
-- Name: idx_GBR_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GBR_3_geometry" ON public."GBR_3" USING gist (geometry);


--
-- Name: idx_GEO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GEO_0_geometry" ON public."GEO_0" USING gist (geometry);


--
-- Name: idx_GEO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GEO_1_geometry" ON public."GEO_1" USING gist (geometry);


--
-- Name: idx_GEO_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GEO_2_geometry" ON public."GEO_2" USING gist (geometry);


--
-- Name: idx_GGY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GGY_0_geometry" ON public."GGY_0" USING gist (geometry);


--
-- Name: idx_GGY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GGY_1_geometry" ON public."GGY_1" USING gist (geometry);


--
-- Name: idx_GHA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GHA_0_geometry" ON public."GHA_0" USING gist (geometry);


--
-- Name: idx_GHA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GHA_1_geometry" ON public."GHA_1" USING gist (geometry);


--
-- Name: idx_GHA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GHA_2_geometry" ON public."GHA_2" USING gist (geometry);


--
-- Name: idx_GIB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GIB_0_geometry" ON public."GIB_0" USING gist (geometry);


--
-- Name: idx_GIN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GIN_0_geometry" ON public."GIN_0" USING gist (geometry);


--
-- Name: idx_GIN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GIN_1_geometry" ON public."GIN_1" USING gist (geometry);


--
-- Name: idx_GIN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GIN_2_geometry" ON public."GIN_2" USING gist (geometry);


--
-- Name: idx_GIN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GIN_3_geometry" ON public."GIN_3" USING gist (geometry);


--
-- Name: idx_GLP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GLP_0_geometry" ON public."GLP_0" USING gist (geometry);


--
-- Name: idx_GLP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GLP_1_geometry" ON public."GLP_1" USING gist (geometry);


--
-- Name: idx_GLP_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GLP_2_geometry" ON public."GLP_2" USING gist (geometry);


--
-- Name: idx_GMB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GMB_0_geometry" ON public."GMB_0" USING gist (geometry);


--
-- Name: idx_GMB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GMB_1_geometry" ON public."GMB_1" USING gist (geometry);


--
-- Name: idx_GMB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GMB_2_geometry" ON public."GMB_2" USING gist (geometry);


--
-- Name: idx_GNB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNB_0_geometry" ON public."GNB_0" USING gist (geometry);


--
-- Name: idx_GNB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNB_1_geometry" ON public."GNB_1" USING gist (geometry);


--
-- Name: idx_GNB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNB_2_geometry" ON public."GNB_2" USING gist (geometry);


--
-- Name: idx_GNQ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNQ_0_geometry" ON public."GNQ_0" USING gist (geometry);


--
-- Name: idx_GNQ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNQ_1_geometry" ON public."GNQ_1" USING gist (geometry);


--
-- Name: idx_GNQ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GNQ_2_geometry" ON public."GNQ_2" USING gist (geometry);


--
-- Name: idx_GRC_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRC_0_geometry" ON public."GRC_0" USING gist (geometry);


--
-- Name: idx_GRC_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRC_1_geometry" ON public."GRC_1" USING gist (geometry);


--
-- Name: idx_GRC_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRC_2_geometry" ON public."GRC_2" USING gist (geometry);


--
-- Name: idx_GRC_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRC_3_geometry" ON public."GRC_3" USING gist (geometry);


--
-- Name: idx_GRD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRD_0_geometry" ON public."GRD_0" USING gist (geometry);


--
-- Name: idx_GRD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRD_1_geometry" ON public."GRD_1" USING gist (geometry);


--
-- Name: idx_GRL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRL_0_geometry" ON public."GRL_0" USING gist (geometry);


--
-- Name: idx_GRL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GRL_1_geometry" ON public."GRL_1" USING gist (geometry);


--
-- Name: idx_GTM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GTM_0_geometry" ON public."GTM_0" USING gist (geometry);


--
-- Name: idx_GTM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GTM_1_geometry" ON public."GTM_1" USING gist (geometry);


--
-- Name: idx_GTM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GTM_2_geometry" ON public."GTM_2" USING gist (geometry);


--
-- Name: idx_GUF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUF_0_geometry" ON public."GUF_0" USING gist (geometry);


--
-- Name: idx_GUF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUF_1_geometry" ON public."GUF_1" USING gist (geometry);


--
-- Name: idx_GUF_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUF_2_geometry" ON public."GUF_2" USING gist (geometry);


--
-- Name: idx_GUM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUM_0_geometry" ON public."GUM_0" USING gist (geometry);


--
-- Name: idx_GUM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUM_1_geometry" ON public."GUM_1" USING gist (geometry);


--
-- Name: idx_GUY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUY_0_geometry" ON public."GUY_0" USING gist (geometry);


--
-- Name: idx_GUY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUY_1_geometry" ON public."GUY_1" USING gist (geometry);


--
-- Name: idx_GUY_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_GUY_2_geometry" ON public."GUY_2" USING gist (geometry);


--
-- Name: idx_HKG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HKG_0_geometry" ON public."HKG_0" USING gist (geometry);


--
-- Name: idx_HKG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HKG_1_geometry" ON public."HKG_1" USING gist (geometry);


--
-- Name: idx_HMD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HMD_0_geometry" ON public."HMD_0" USING gist (geometry);


--
-- Name: idx_HND_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HND_0_geometry" ON public."HND_0" USING gist (geometry);


--
-- Name: idx_HND_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HND_1_geometry" ON public."HND_1" USING gist (geometry);


--
-- Name: idx_HND_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HND_2_geometry" ON public."HND_2" USING gist (geometry);


--
-- Name: idx_HRV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HRV_0_geometry" ON public."HRV_0" USING gist (geometry);


--
-- Name: idx_HRV_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HRV_1_geometry" ON public."HRV_1" USING gist (geometry);


--
-- Name: idx_HRV_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HRV_2_geometry" ON public."HRV_2" USING gist (geometry);


--
-- Name: idx_HTI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HTI_0_geometry" ON public."HTI_0" USING gist (geometry);


--
-- Name: idx_HTI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HTI_1_geometry" ON public."HTI_1" USING gist (geometry);


--
-- Name: idx_HTI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HTI_2_geometry" ON public."HTI_2" USING gist (geometry);


--
-- Name: idx_HTI_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HTI_3_geometry" ON public."HTI_3" USING gist (geometry);


--
-- Name: idx_HTI_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HTI_4_geometry" ON public."HTI_4" USING gist (geometry);


--
-- Name: idx_HUN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HUN_0_geometry" ON public."HUN_0" USING gist (geometry);


--
-- Name: idx_HUN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HUN_1_geometry" ON public."HUN_1" USING gist (geometry);


--
-- Name: idx_HUN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_HUN_2_geometry" ON public."HUN_2" USING gist (geometry);


--
-- Name: idx_IDN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IDN_0_geometry" ON public."IDN_0" USING gist (geometry);


--
-- Name: idx_IDN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IDN_1_geometry" ON public."IDN_1" USING gist (geometry);


--
-- Name: idx_IDN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IDN_2_geometry" ON public."IDN_2" USING gist (geometry);


--
-- Name: idx_IDN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IDN_3_geometry" ON public."IDN_3" USING gist (geometry);


--
-- Name: idx_IDN_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IDN_4_geometry" ON public."IDN_4" USING gist (geometry);


--
-- Name: idx_IMN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IMN_0_geometry" ON public."IMN_0" USING gist (geometry);


--
-- Name: idx_IMN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IMN_1_geometry" ON public."IMN_1" USING gist (geometry);


--
-- Name: idx_IMN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IMN_2_geometry" ON public."IMN_2" USING gist (geometry);


--
-- Name: idx_IND_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IND_0_geometry" ON public."IND_0" USING gist (geometry);


--
-- Name: idx_IND_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IND_1_geometry" ON public."IND_1" USING gist (geometry);


--
-- Name: idx_IND_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IND_2_geometry" ON public."IND_2" USING gist (geometry);


--
-- Name: idx_IND_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IND_3_geometry" ON public."IND_3" USING gist (geometry);


--
-- Name: idx_IOT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IOT_0_geometry" ON public."IOT_0" USING gist (geometry);


--
-- Name: idx_IRL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRL_0_geometry" ON public."IRL_0" USING gist (geometry);


--
-- Name: idx_IRL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRL_1_geometry" ON public."IRL_1" USING gist (geometry);


--
-- Name: idx_IRN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRN_0_geometry" ON public."IRN_0" USING gist (geometry);


--
-- Name: idx_IRN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRN_1_geometry" ON public."IRN_1" USING gist (geometry);


--
-- Name: idx_IRN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRN_2_geometry" ON public."IRN_2" USING gist (geometry);


--
-- Name: idx_IRQ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRQ_0_geometry" ON public."IRQ_0" USING gist (geometry);


--
-- Name: idx_IRQ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRQ_1_geometry" ON public."IRQ_1" USING gist (geometry);


--
-- Name: idx_IRQ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_IRQ_2_geometry" ON public."IRQ_2" USING gist (geometry);


--
-- Name: idx_ISL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ISL_0_geometry" ON public."ISL_0" USING gist (geometry);


--
-- Name: idx_ISL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ISL_1_geometry" ON public."ISL_1" USING gist (geometry);


--
-- Name: idx_ISL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ISL_2_geometry" ON public."ISL_2" USING gist (geometry);


--
-- Name: idx_ISR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ISR_0_geometry" ON public."ISR_0" USING gist (geometry);


--
-- Name: idx_ISR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ISR_1_geometry" ON public."ISR_1" USING gist (geometry);


--
-- Name: idx_ITA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ITA_0_geometry" ON public."ITA_0" USING gist (geometry);


--
-- Name: idx_ITA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ITA_1_geometry" ON public."ITA_1" USING gist (geometry);


--
-- Name: idx_ITA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ITA_2_geometry" ON public."ITA_2" USING gist (geometry);


--
-- Name: idx_ITA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ITA_3_geometry" ON public."ITA_3" USING gist (geometry);


--
-- Name: idx_JAM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JAM_0_geometry" ON public."JAM_0" USING gist (geometry);


--
-- Name: idx_JAM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JAM_1_geometry" ON public."JAM_1" USING gist (geometry);


--
-- Name: idx_JEY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JEY_0_geometry" ON public."JEY_0" USING gist (geometry);


--
-- Name: idx_JEY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JEY_1_geometry" ON public."JEY_1" USING gist (geometry);


--
-- Name: idx_JOR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JOR_0_geometry" ON public."JOR_0" USING gist (geometry);


--
-- Name: idx_JOR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JOR_1_geometry" ON public."JOR_1" USING gist (geometry);


--
-- Name: idx_JOR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JOR_2_geometry" ON public."JOR_2" USING gist (geometry);


--
-- Name: idx_JPN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JPN_0_geometry" ON public."JPN_0" USING gist (geometry);


--
-- Name: idx_JPN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JPN_1_geometry" ON public."JPN_1" USING gist (geometry);


--
-- Name: idx_JPN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_JPN_2_geometry" ON public."JPN_2" USING gist (geometry);


--
-- Name: idx_KAZ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KAZ_0_geometry" ON public."KAZ_0" USING gist (geometry);


--
-- Name: idx_KAZ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KAZ_1_geometry" ON public."KAZ_1" USING gist (geometry);


--
-- Name: idx_KAZ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KAZ_2_geometry" ON public."KAZ_2" USING gist (geometry);


--
-- Name: idx_KEN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KEN_0_geometry" ON public."KEN_0" USING gist (geometry);


--
-- Name: idx_KEN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KEN_1_geometry" ON public."KEN_1" USING gist (geometry);


--
-- Name: idx_KEN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KEN_2_geometry" ON public."KEN_2" USING gist (geometry);


--
-- Name: idx_KEN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KEN_3_geometry" ON public."KEN_3" USING gist (geometry);


--
-- Name: idx_KGZ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KGZ_0_geometry" ON public."KGZ_0" USING gist (geometry);


--
-- Name: idx_KGZ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KGZ_1_geometry" ON public."KGZ_1" USING gist (geometry);


--
-- Name: idx_KGZ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KGZ_2_geometry" ON public."KGZ_2" USING gist (geometry);


--
-- Name: idx_KHM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KHM_0_geometry" ON public."KHM_0" USING gist (geometry);


--
-- Name: idx_KHM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KHM_1_geometry" ON public."KHM_1" USING gist (geometry);


--
-- Name: idx_KHM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KHM_2_geometry" ON public."KHM_2" USING gist (geometry);


--
-- Name: idx_KHM_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KHM_3_geometry" ON public."KHM_3" USING gist (geometry);


--
-- Name: idx_KHM_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KHM_4_geometry" ON public."KHM_4" USING gist (geometry);


--
-- Name: idx_KIR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KIR_0_geometry" ON public."KIR_0" USING gist (geometry);


--
-- Name: idx_KNA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KNA_0_geometry" ON public."KNA_0" USING gist (geometry);


--
-- Name: idx_KNA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KNA_1_geometry" ON public."KNA_1" USING gist (geometry);


--
-- Name: idx_KOR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KOR_0_geometry" ON public."KOR_0" USING gist (geometry);


--
-- Name: idx_KOR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KOR_1_geometry" ON public."KOR_1" USING gist (geometry);


--
-- Name: idx_KOR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KOR_2_geometry" ON public."KOR_2" USING gist (geometry);


--
-- Name: idx_KWT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KWT_0_geometry" ON public."KWT_0" USING gist (geometry);


--
-- Name: idx_KWT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_KWT_1_geometry" ON public."KWT_1" USING gist (geometry);


--
-- Name: idx_LAO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LAO_0_geometry" ON public."LAO_0" USING gist (geometry);


--
-- Name: idx_LAO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LAO_1_geometry" ON public."LAO_1" USING gist (geometry);


--
-- Name: idx_LAO_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LAO_2_geometry" ON public."LAO_2" USING gist (geometry);


--
-- Name: idx_LBN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBN_0_geometry" ON public."LBN_0" USING gist (geometry);


--
-- Name: idx_LBN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBN_1_geometry" ON public."LBN_1" USING gist (geometry);


--
-- Name: idx_LBN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBN_2_geometry" ON public."LBN_2" USING gist (geometry);


--
-- Name: idx_LBN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBN_3_geometry" ON public."LBN_3" USING gist (geometry);


--
-- Name: idx_LBR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBR_0_geometry" ON public."LBR_0" USING gist (geometry);


--
-- Name: idx_LBR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBR_1_geometry" ON public."LBR_1" USING gist (geometry);


--
-- Name: idx_LBR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBR_2_geometry" ON public."LBR_2" USING gist (geometry);


--
-- Name: idx_LBR_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBR_3_geometry" ON public."LBR_3" USING gist (geometry);


--
-- Name: idx_LBY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBY_0_geometry" ON public."LBY_0" USING gist (geometry);


--
-- Name: idx_LBY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LBY_1_geometry" ON public."LBY_1" USING gist (geometry);


--
-- Name: idx_LCA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LCA_0_geometry" ON public."LCA_0" USING gist (geometry);


--
-- Name: idx_LCA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LCA_1_geometry" ON public."LCA_1" USING gist (geometry);


--
-- Name: idx_LIE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LIE_0_geometry" ON public."LIE_0" USING gist (geometry);


--
-- Name: idx_LIE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LIE_1_geometry" ON public."LIE_1" USING gist (geometry);


--
-- Name: idx_LKA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LKA_0_geometry" ON public."LKA_0" USING gist (geometry);


--
-- Name: idx_LKA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LKA_1_geometry" ON public."LKA_1" USING gist (geometry);


--
-- Name: idx_LKA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LKA_2_geometry" ON public."LKA_2" USING gist (geometry);


--
-- Name: idx_LSO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LSO_0_geometry" ON public."LSO_0" USING gist (geometry);


--
-- Name: idx_LSO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LSO_1_geometry" ON public."LSO_1" USING gist (geometry);


--
-- Name: idx_LTU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LTU_0_geometry" ON public."LTU_0" USING gist (geometry);


--
-- Name: idx_LTU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LTU_1_geometry" ON public."LTU_1" USING gist (geometry);


--
-- Name: idx_LTU_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LTU_2_geometry" ON public."LTU_2" USING gist (geometry);


--
-- Name: idx_LUX_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LUX_0_geometry" ON public."LUX_0" USING gist (geometry);


--
-- Name: idx_LUX_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LUX_1_geometry" ON public."LUX_1" USING gist (geometry);


--
-- Name: idx_LUX_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LUX_2_geometry" ON public."LUX_2" USING gist (geometry);


--
-- Name: idx_LUX_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LUX_3_geometry" ON public."LUX_3" USING gist (geometry);


--
-- Name: idx_LUX_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LUX_4_geometry" ON public."LUX_4" USING gist (geometry);


--
-- Name: idx_LVA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LVA_0_geometry" ON public."LVA_0" USING gist (geometry);


--
-- Name: idx_LVA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LVA_1_geometry" ON public."LVA_1" USING gist (geometry);


--
-- Name: idx_LVA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_LVA_2_geometry" ON public."LVA_2" USING gist (geometry);


--
-- Name: idx_MAC_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAC_0_geometry" ON public."MAC_0" USING gist (geometry);


--
-- Name: idx_MAC_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAC_1_geometry" ON public."MAC_1" USING gist (geometry);


--
-- Name: idx_MAC_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAC_2_geometry" ON public."MAC_2" USING gist (geometry);


--
-- Name: idx_MAF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAF_0_geometry" ON public."MAF_0" USING gist (geometry);


--
-- Name: idx_MAR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAR_0_geometry" ON public."MAR_0" USING gist (geometry);


--
-- Name: idx_MAR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAR_1_geometry" ON public."MAR_1" USING gist (geometry);


--
-- Name: idx_MAR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAR_2_geometry" ON public."MAR_2" USING gist (geometry);


--
-- Name: idx_MAR_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAR_3_geometry" ON public."MAR_3" USING gist (geometry);


--
-- Name: idx_MAR_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MAR_4_geometry" ON public."MAR_4" USING gist (geometry);


--
-- Name: idx_MCO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MCO_0_geometry" ON public."MCO_0" USING gist (geometry);


--
-- Name: idx_MDA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDA_0_geometry" ON public."MDA_0" USING gist (geometry);


--
-- Name: idx_MDA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDA_1_geometry" ON public."MDA_1" USING gist (geometry);


--
-- Name: idx_MDG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDG_0_geometry" ON public."MDG_0" USING gist (geometry);


--
-- Name: idx_MDG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDG_1_geometry" ON public."MDG_1" USING gist (geometry);


--
-- Name: idx_MDG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDG_2_geometry" ON public."MDG_2" USING gist (geometry);


--
-- Name: idx_MDG_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDG_3_geometry" ON public."MDG_3" USING gist (geometry);


--
-- Name: idx_MDG_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDG_4_geometry" ON public."MDG_4" USING gist (geometry);


--
-- Name: idx_MDV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MDV_0_geometry" ON public."MDV_0" USING gist (geometry);


--
-- Name: idx_MEX_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MEX_0_geometry" ON public."MEX_0" USING gist (geometry);


--
-- Name: idx_MEX_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MEX_1_geometry" ON public."MEX_1" USING gist (geometry);


--
-- Name: idx_MEX_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MEX_2_geometry" ON public."MEX_2" USING gist (geometry);


--
-- Name: idx_MHL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MHL_0_geometry" ON public."MHL_0" USING gist (geometry);


--
-- Name: idx_MKD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MKD_0_geometry" ON public."MKD_0" USING gist (geometry);


--
-- Name: idx_MKD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MKD_1_geometry" ON public."MKD_1" USING gist (geometry);


--
-- Name: idx_MLI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLI_0_geometry" ON public."MLI_0" USING gist (geometry);


--
-- Name: idx_MLI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLI_1_geometry" ON public."MLI_1" USING gist (geometry);


--
-- Name: idx_MLI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLI_2_geometry" ON public."MLI_2" USING gist (geometry);


--
-- Name: idx_MLI_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLI_3_geometry" ON public."MLI_3" USING gist (geometry);


--
-- Name: idx_MLI_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLI_4_geometry" ON public."MLI_4" USING gist (geometry);


--
-- Name: idx_MLT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLT_0_geometry" ON public."MLT_0" USING gist (geometry);


--
-- Name: idx_MLT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLT_1_geometry" ON public."MLT_1" USING gist (geometry);


--
-- Name: idx_MLT_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MLT_2_geometry" ON public."MLT_2" USING gist (geometry);


--
-- Name: idx_MMR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MMR_0_geometry" ON public."MMR_0" USING gist (geometry);


--
-- Name: idx_MMR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MMR_1_geometry" ON public."MMR_1" USING gist (geometry);


--
-- Name: idx_MMR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MMR_2_geometry" ON public."MMR_2" USING gist (geometry);


--
-- Name: idx_MMR_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MMR_3_geometry" ON public."MMR_3" USING gist (geometry);


--
-- Name: idx_MNE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNE_0_geometry" ON public."MNE_0" USING gist (geometry);


--
-- Name: idx_MNE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNE_1_geometry" ON public."MNE_1" USING gist (geometry);


--
-- Name: idx_MNG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNG_0_geometry" ON public."MNG_0" USING gist (geometry);


--
-- Name: idx_MNG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNG_1_geometry" ON public."MNG_1" USING gist (geometry);


--
-- Name: idx_MNG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNG_2_geometry" ON public."MNG_2" USING gist (geometry);


--
-- Name: idx_MNP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNP_0_geometry" ON public."MNP_0" USING gist (geometry);


--
-- Name: idx_MNP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MNP_1_geometry" ON public."MNP_1" USING gist (geometry);


--
-- Name: idx_MOZ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MOZ_0_geometry" ON public."MOZ_0" USING gist (geometry);


--
-- Name: idx_MOZ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MOZ_1_geometry" ON public."MOZ_1" USING gist (geometry);


--
-- Name: idx_MOZ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MOZ_2_geometry" ON public."MOZ_2" USING gist (geometry);


--
-- Name: idx_MOZ_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MOZ_3_geometry" ON public."MOZ_3" USING gist (geometry);


--
-- Name: idx_MRT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MRT_0_geometry" ON public."MRT_0" USING gist (geometry);


--
-- Name: idx_MRT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MRT_1_geometry" ON public."MRT_1" USING gist (geometry);


--
-- Name: idx_MRT_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MRT_2_geometry" ON public."MRT_2" USING gist (geometry);


--
-- Name: idx_MSR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MSR_0_geometry" ON public."MSR_0" USING gist (geometry);


--
-- Name: idx_MSR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MSR_1_geometry" ON public."MSR_1" USING gist (geometry);


--
-- Name: idx_MTQ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MTQ_0_geometry" ON public."MTQ_0" USING gist (geometry);


--
-- Name: idx_MTQ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MTQ_1_geometry" ON public."MTQ_1" USING gist (geometry);


--
-- Name: idx_MTQ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MTQ_2_geometry" ON public."MTQ_2" USING gist (geometry);


--
-- Name: idx_MUS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MUS_0_geometry" ON public."MUS_0" USING gist (geometry);


--
-- Name: idx_MUS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MUS_1_geometry" ON public."MUS_1" USING gist (geometry);


--
-- Name: idx_MWI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MWI_0_geometry" ON public."MWI_0" USING gist (geometry);


--
-- Name: idx_MWI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MWI_1_geometry" ON public."MWI_1" USING gist (geometry);


--
-- Name: idx_MWI_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MWI_2_geometry" ON public."MWI_2" USING gist (geometry);


--
-- Name: idx_MWI_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MWI_3_geometry" ON public."MWI_3" USING gist (geometry);


--
-- Name: idx_MYS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MYS_0_geometry" ON public."MYS_0" USING gist (geometry);


--
-- Name: idx_MYS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MYS_1_geometry" ON public."MYS_1" USING gist (geometry);


--
-- Name: idx_MYS_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MYS_2_geometry" ON public."MYS_2" USING gist (geometry);


--
-- Name: idx_MYT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MYT_0_geometry" ON public."MYT_0" USING gist (geometry);


--
-- Name: idx_MYT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_MYT_1_geometry" ON public."MYT_1" USING gist (geometry);


--
-- Name: idx_NAM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NAM_0_geometry" ON public."NAM_0" USING gist (geometry);


--
-- Name: idx_NAM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NAM_1_geometry" ON public."NAM_1" USING gist (geometry);


--
-- Name: idx_NAM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NAM_2_geometry" ON public."NAM_2" USING gist (geometry);


--
-- Name: idx_NCL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NCL_0_geometry" ON public."NCL_0" USING gist (geometry);


--
-- Name: idx_NCL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NCL_1_geometry" ON public."NCL_1" USING gist (geometry);


--
-- Name: idx_NCL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NCL_2_geometry" ON public."NCL_2" USING gist (geometry);


--
-- Name: idx_NER_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NER_0_geometry" ON public."NER_0" USING gist (geometry);


--
-- Name: idx_NER_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NER_1_geometry" ON public."NER_1" USING gist (geometry);


--
-- Name: idx_NER_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NER_2_geometry" ON public."NER_2" USING gist (geometry);


--
-- Name: idx_NER_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NER_3_geometry" ON public."NER_3" USING gist (geometry);


--
-- Name: idx_NFK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NFK_0_geometry" ON public."NFK_0" USING gist (geometry);


--
-- Name: idx_NGA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NGA_0_geometry" ON public."NGA_0" USING gist (geometry);


--
-- Name: idx_NGA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NGA_1_geometry" ON public."NGA_1" USING gist (geometry);


--
-- Name: idx_NGA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NGA_2_geometry" ON public."NGA_2" USING gist (geometry);


--
-- Name: idx_NIC_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NIC_0_geometry" ON public."NIC_0" USING gist (geometry);


--
-- Name: idx_NIC_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NIC_1_geometry" ON public."NIC_1" USING gist (geometry);


--
-- Name: idx_NIC_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NIC_2_geometry" ON public."NIC_2" USING gist (geometry);


--
-- Name: idx_NIU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NIU_0_geometry" ON public."NIU_0" USING gist (geometry);


--
-- Name: idx_NLD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NLD_0_geometry" ON public."NLD_0" USING gist (geometry);


--
-- Name: idx_NLD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NLD_1_geometry" ON public."NLD_1" USING gist (geometry);


--
-- Name: idx_NLD_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NLD_2_geometry" ON public."NLD_2" USING gist (geometry);


--
-- Name: idx_NOR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NOR_0_geometry" ON public."NOR_0" USING gist (geometry);


--
-- Name: idx_NOR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NOR_1_geometry" ON public."NOR_1" USING gist (geometry);


--
-- Name: idx_NOR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NOR_2_geometry" ON public."NOR_2" USING gist (geometry);


--
-- Name: idx_NPL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NPL_0_geometry" ON public."NPL_0" USING gist (geometry);


--
-- Name: idx_NPL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NPL_1_geometry" ON public."NPL_1" USING gist (geometry);


--
-- Name: idx_NPL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NPL_2_geometry" ON public."NPL_2" USING gist (geometry);


--
-- Name: idx_NPL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NPL_3_geometry" ON public."NPL_3" USING gist (geometry);


--
-- Name: idx_NPL_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NPL_4_geometry" ON public."NPL_4" USING gist (geometry);


--
-- Name: idx_NRU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NRU_0_geometry" ON public."NRU_0" USING gist (geometry);


--
-- Name: idx_NRU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NRU_1_geometry" ON public."NRU_1" USING gist (geometry);


--
-- Name: idx_NZL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NZL_0_geometry" ON public."NZL_0" USING gist (geometry);


--
-- Name: idx_NZL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NZL_1_geometry" ON public."NZL_1" USING gist (geometry);


--
-- Name: idx_NZL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_NZL_2_geometry" ON public."NZL_2" USING gist (geometry);


--
-- Name: idx_OMN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_OMN_0_geometry" ON public."OMN_0" USING gist (geometry);


--
-- Name: idx_OMN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_OMN_1_geometry" ON public."OMN_1" USING gist (geometry);


--
-- Name: idx_OMN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_OMN_2_geometry" ON public."OMN_2" USING gist (geometry);


--
-- Name: idx_PAK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAK_0_geometry" ON public."PAK_0" USING gist (geometry);


--
-- Name: idx_PAK_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAK_1_geometry" ON public."PAK_1" USING gist (geometry);


--
-- Name: idx_PAK_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAK_2_geometry" ON public."PAK_2" USING gist (geometry);


--
-- Name: idx_PAK_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAK_3_geometry" ON public."PAK_3" USING gist (geometry);


--
-- Name: idx_PAN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAN_0_geometry" ON public."PAN_0" USING gist (geometry);


--
-- Name: idx_PAN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAN_1_geometry" ON public."PAN_1" USING gist (geometry);


--
-- Name: idx_PAN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAN_2_geometry" ON public."PAN_2" USING gist (geometry);


--
-- Name: idx_PAN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PAN_3_geometry" ON public."PAN_3" USING gist (geometry);


--
-- Name: idx_PCN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PCN_0_geometry" ON public."PCN_0" USING gist (geometry);


--
-- Name: idx_PER_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PER_0_geometry" ON public."PER_0" USING gist (geometry);


--
-- Name: idx_PER_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PER_1_geometry" ON public."PER_1" USING gist (geometry);


--
-- Name: idx_PER_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PER_2_geometry" ON public."PER_2" USING gist (geometry);


--
-- Name: idx_PER_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PER_3_geometry" ON public."PER_3" USING gist (geometry);


--
-- Name: idx_PHL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PHL_0_geometry" ON public."PHL_0" USING gist (geometry);


--
-- Name: idx_PHL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PHL_1_geometry" ON public."PHL_1" USING gist (geometry);


--
-- Name: idx_PHL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PHL_2_geometry" ON public."PHL_2" USING gist (geometry);


--
-- Name: idx_PHL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PHL_3_geometry" ON public."PHL_3" USING gist (geometry);


--
-- Name: idx_PLW_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PLW_0_geometry" ON public."PLW_0" USING gist (geometry);


--
-- Name: idx_PLW_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PLW_1_geometry" ON public."PLW_1" USING gist (geometry);


--
-- Name: idx_PNG_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PNG_0_geometry" ON public."PNG_0" USING gist (geometry);


--
-- Name: idx_PNG_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PNG_1_geometry" ON public."PNG_1" USING gist (geometry);


--
-- Name: idx_PNG_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PNG_2_geometry" ON public."PNG_2" USING gist (geometry);


--
-- Name: idx_POL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_POL_0_geometry" ON public."POL_0" USING gist (geometry);


--
-- Name: idx_POL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_POL_1_geometry" ON public."POL_1" USING gist (geometry);


--
-- Name: idx_POL_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_POL_2_geometry" ON public."POL_2" USING gist (geometry);


--
-- Name: idx_POL_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_POL_3_geometry" ON public."POL_3" USING gist (geometry);


--
-- Name: idx_PRI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRI_0_geometry" ON public."PRI_0" USING gist (geometry);


--
-- Name: idx_PRI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRI_1_geometry" ON public."PRI_1" USING gist (geometry);


--
-- Name: idx_PRK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRK_0_geometry" ON public."PRK_0" USING gist (geometry);


--
-- Name: idx_PRK_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRK_1_geometry" ON public."PRK_1" USING gist (geometry);


--
-- Name: idx_PRK_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRK_2_geometry" ON public."PRK_2" USING gist (geometry);


--
-- Name: idx_PRT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRT_0_geometry" ON public."PRT_0" USING gist (geometry);


--
-- Name: idx_PRT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRT_1_geometry" ON public."PRT_1" USING gist (geometry);


--
-- Name: idx_PRT_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRT_2_geometry" ON public."PRT_2" USING gist (geometry);


--
-- Name: idx_PRT_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRT_3_geometry" ON public."PRT_3" USING gist (geometry);


--
-- Name: idx_PRY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRY_0_geometry" ON public."PRY_0" USING gist (geometry);


--
-- Name: idx_PRY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRY_1_geometry" ON public."PRY_1" USING gist (geometry);


--
-- Name: idx_PRY_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PRY_2_geometry" ON public."PRY_2" USING gist (geometry);


--
-- Name: idx_PSE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PSE_0_geometry" ON public."PSE_0" USING gist (geometry);


--
-- Name: idx_PSE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PSE_1_geometry" ON public."PSE_1" USING gist (geometry);


--
-- Name: idx_PSE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PSE_2_geometry" ON public."PSE_2" USING gist (geometry);


--
-- Name: idx_PYF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PYF_0_geometry" ON public."PYF_0" USING gist (geometry);


--
-- Name: idx_PYF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_PYF_1_geometry" ON public."PYF_1" USING gist (geometry);


--
-- Name: idx_QAT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_QAT_0_geometry" ON public."QAT_0" USING gist (geometry);


--
-- Name: idx_QAT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_QAT_1_geometry" ON public."QAT_1" USING gist (geometry);


--
-- Name: idx_REU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_REU_0_geometry" ON public."REU_0" USING gist (geometry);


--
-- Name: idx_REU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_REU_1_geometry" ON public."REU_1" USING gist (geometry);


--
-- Name: idx_REU_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_REU_2_geometry" ON public."REU_2" USING gist (geometry);


--
-- Name: idx_ROU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ROU_0_geometry" ON public."ROU_0" USING gist (geometry);


--
-- Name: idx_ROU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ROU_1_geometry" ON public."ROU_1" USING gist (geometry);


--
-- Name: idx_ROU_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ROU_2_geometry" ON public."ROU_2" USING gist (geometry);


--
-- Name: idx_RUS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RUS_0_geometry" ON public."RUS_0" USING gist (geometry);


--
-- Name: idx_RUS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RUS_1_geometry" ON public."RUS_1" USING gist (geometry);


--
-- Name: idx_RUS_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RUS_2_geometry" ON public."RUS_2" USING gist (geometry);


--
-- Name: idx_RUS_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RUS_3_geometry" ON public."RUS_3" USING gist (geometry);


--
-- Name: idx_RWA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_0_geometry" ON public."RWA_0" USING gist (geometry);


--
-- Name: idx_RWA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_1_geometry" ON public."RWA_1" USING gist (geometry);


--
-- Name: idx_RWA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_2_geometry" ON public."RWA_2" USING gist (geometry);


--
-- Name: idx_RWA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_3_geometry" ON public."RWA_3" USING gist (geometry);


--
-- Name: idx_RWA_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_4_geometry" ON public."RWA_4" USING gist (geometry);


--
-- Name: idx_RWA_5_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_RWA_5_geometry" ON public."RWA_5" USING gist (geometry);


--
-- Name: idx_SAU_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SAU_0_geometry" ON public."SAU_0" USING gist (geometry);


--
-- Name: idx_SAU_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SAU_1_geometry" ON public."SAU_1" USING gist (geometry);


--
-- Name: idx_SDN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SDN_0_geometry" ON public."SDN_0" USING gist (geometry);


--
-- Name: idx_SDN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SDN_1_geometry" ON public."SDN_1" USING gist (geometry);


--
-- Name: idx_SDN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SDN_2_geometry" ON public."SDN_2" USING gist (geometry);


--
-- Name: idx_SDN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SDN_3_geometry" ON public."SDN_3" USING gist (geometry);


--
-- Name: idx_SEN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SEN_0_geometry" ON public."SEN_0" USING gist (geometry);


--
-- Name: idx_SEN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SEN_1_geometry" ON public."SEN_1" USING gist (geometry);


--
-- Name: idx_SEN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SEN_2_geometry" ON public."SEN_2" USING gist (geometry);


--
-- Name: idx_SEN_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SEN_3_geometry" ON public."SEN_3" USING gist (geometry);


--
-- Name: idx_SEN_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SEN_4_geometry" ON public."SEN_4" USING gist (geometry);


--
-- Name: idx_SGP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SGP_0_geometry" ON public."SGP_0" USING gist (geometry);


--
-- Name: idx_SGP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SGP_1_geometry" ON public."SGP_1" USING gist (geometry);


--
-- Name: idx_SGS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SGS_0_geometry" ON public."SGS_0" USING gist (geometry);


--
-- Name: idx_SHN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SHN_0_geometry" ON public."SHN_0" USING gist (geometry);


--
-- Name: idx_SHN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SHN_1_geometry" ON public."SHN_1" USING gist (geometry);


--
-- Name: idx_SHN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SHN_2_geometry" ON public."SHN_2" USING gist (geometry);


--
-- Name: idx_SJM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SJM_0_geometry" ON public."SJM_0" USING gist (geometry);


--
-- Name: idx_SJM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SJM_1_geometry" ON public."SJM_1" USING gist (geometry);


--
-- Name: idx_SLB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLB_0_geometry" ON public."SLB_0" USING gist (geometry);


--
-- Name: idx_SLB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLB_1_geometry" ON public."SLB_1" USING gist (geometry);


--
-- Name: idx_SLB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLB_2_geometry" ON public."SLB_2" USING gist (geometry);


--
-- Name: idx_SLE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLE_0_geometry" ON public."SLE_0" USING gist (geometry);


--
-- Name: idx_SLE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLE_1_geometry" ON public."SLE_1" USING gist (geometry);


--
-- Name: idx_SLE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLE_2_geometry" ON public."SLE_2" USING gist (geometry);


--
-- Name: idx_SLE_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLE_3_geometry" ON public."SLE_3" USING gist (geometry);


--
-- Name: idx_SLV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLV_0_geometry" ON public."SLV_0" USING gist (geometry);


--
-- Name: idx_SLV_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLV_1_geometry" ON public."SLV_1" USING gist (geometry);


--
-- Name: idx_SLV_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SLV_2_geometry" ON public."SLV_2" USING gist (geometry);


--
-- Name: idx_SMR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SMR_0_geometry" ON public."SMR_0" USING gist (geometry);


--
-- Name: idx_SMR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SMR_1_geometry" ON public."SMR_1" USING gist (geometry);


--
-- Name: idx_SOM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SOM_0_geometry" ON public."SOM_0" USING gist (geometry);


--
-- Name: idx_SOM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SOM_1_geometry" ON public."SOM_1" USING gist (geometry);


--
-- Name: idx_SOM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SOM_2_geometry" ON public."SOM_2" USING gist (geometry);


--
-- Name: idx_SPM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SPM_0_geometry" ON public."SPM_0" USING gist (geometry);


--
-- Name: idx_SPM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SPM_1_geometry" ON public."SPM_1" USING gist (geometry);


--
-- Name: idx_SRB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SRB_0_geometry" ON public."SRB_0" USING gist (geometry);


--
-- Name: idx_SRB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SRB_1_geometry" ON public."SRB_1" USING gist (geometry);


--
-- Name: idx_SRB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SRB_2_geometry" ON public."SRB_2" USING gist (geometry);


--
-- Name: idx_STP_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_STP_0_geometry" ON public."STP_0" USING gist (geometry);


--
-- Name: idx_STP_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_STP_1_geometry" ON public."STP_1" USING gist (geometry);


--
-- Name: idx_STP_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_STP_2_geometry" ON public."STP_2" USING gist (geometry);


--
-- Name: idx_SUR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SUR_0_geometry" ON public."SUR_0" USING gist (geometry);


--
-- Name: idx_SUR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SUR_1_geometry" ON public."SUR_1" USING gist (geometry);


--
-- Name: idx_SUR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SUR_2_geometry" ON public."SUR_2" USING gist (geometry);


--
-- Name: idx_SVK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVK_0_geometry" ON public."SVK_0" USING gist (geometry);


--
-- Name: idx_SVK_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVK_1_geometry" ON public."SVK_1" USING gist (geometry);


--
-- Name: idx_SVK_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVK_2_geometry" ON public."SVK_2" USING gist (geometry);


--
-- Name: idx_SVN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVN_0_geometry" ON public."SVN_0" USING gist (geometry);


--
-- Name: idx_SVN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVN_1_geometry" ON public."SVN_1" USING gist (geometry);


--
-- Name: idx_SVN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SVN_2_geometry" ON public."SVN_2" USING gist (geometry);


--
-- Name: idx_SWE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWE_0_geometry" ON public."SWE_0" USING gist (geometry);


--
-- Name: idx_SWE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWE_1_geometry" ON public."SWE_1" USING gist (geometry);


--
-- Name: idx_SWE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWE_2_geometry" ON public."SWE_2" USING gist (geometry);


--
-- Name: idx_SWZ_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWZ_0_geometry" ON public."SWZ_0" USING gist (geometry);


--
-- Name: idx_SWZ_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWZ_1_geometry" ON public."SWZ_1" USING gist (geometry);


--
-- Name: idx_SWZ_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SWZ_2_geometry" ON public."SWZ_2" USING gist (geometry);


--
-- Name: idx_SYC_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SYC_0_geometry" ON public."SYC_0" USING gist (geometry);


--
-- Name: idx_SYC_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SYC_1_geometry" ON public."SYC_1" USING gist (geometry);


--
-- Name: idx_SYR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SYR_0_geometry" ON public."SYR_0" USING gist (geometry);


--
-- Name: idx_SYR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SYR_1_geometry" ON public."SYR_1" USING gist (geometry);


--
-- Name: idx_SYR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_SYR_2_geometry" ON public."SYR_2" USING gist (geometry);


--
-- Name: idx_TCA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCA_0_geometry" ON public."TCA_0" USING gist (geometry);


--
-- Name: idx_TCA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCA_1_geometry" ON public."TCA_1" USING gist (geometry);


--
-- Name: idx_TCD_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCD_0_geometry" ON public."TCD_0" USING gist (geometry);


--
-- Name: idx_TCD_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCD_1_geometry" ON public."TCD_1" USING gist (geometry);


--
-- Name: idx_TCD_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCD_2_geometry" ON public."TCD_2" USING gist (geometry);


--
-- Name: idx_TCD_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TCD_3_geometry" ON public."TCD_3" USING gist (geometry);


--
-- Name: idx_TGO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TGO_0_geometry" ON public."TGO_0" USING gist (geometry);


--
-- Name: idx_TGO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TGO_1_geometry" ON public."TGO_1" USING gist (geometry);


--
-- Name: idx_TGO_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TGO_2_geometry" ON public."TGO_2" USING gist (geometry);


--
-- Name: idx_THA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_THA_0_geometry" ON public."THA_0" USING gist (geometry);


--
-- Name: idx_THA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_THA_1_geometry" ON public."THA_1" USING gist (geometry);


--
-- Name: idx_THA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_THA_2_geometry" ON public."THA_2" USING gist (geometry);


--
-- Name: idx_THA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_THA_3_geometry" ON public."THA_3" USING gist (geometry);


--
-- Name: idx_TJK_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TJK_0_geometry" ON public."TJK_0" USING gist (geometry);


--
-- Name: idx_TJK_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TJK_1_geometry" ON public."TJK_1" USING gist (geometry);


--
-- Name: idx_TJK_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TJK_2_geometry" ON public."TJK_2" USING gist (geometry);


--
-- Name: idx_TJK_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TJK_3_geometry" ON public."TJK_3" USING gist (geometry);


--
-- Name: idx_TKL_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TKL_0_geometry" ON public."TKL_0" USING gist (geometry);


--
-- Name: idx_TKL_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TKL_1_geometry" ON public."TKL_1" USING gist (geometry);


--
-- Name: idx_TKM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TKM_0_geometry" ON public."TKM_0" USING gist (geometry);


--
-- Name: idx_TKM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TKM_1_geometry" ON public."TKM_1" USING gist (geometry);


--
-- Name: idx_TLS_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TLS_0_geometry" ON public."TLS_0" USING gist (geometry);


--
-- Name: idx_TLS_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TLS_1_geometry" ON public."TLS_1" USING gist (geometry);


--
-- Name: idx_TLS_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TLS_2_geometry" ON public."TLS_2" USING gist (geometry);


--
-- Name: idx_TLS_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TLS_3_geometry" ON public."TLS_3" USING gist (geometry);


--
-- Name: idx_TON_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TON_0_geometry" ON public."TON_0" USING gist (geometry);


--
-- Name: idx_TON_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TON_1_geometry" ON public."TON_1" USING gist (geometry);


--
-- Name: idx_TTO_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TTO_0_geometry" ON public."TTO_0" USING gist (geometry);


--
-- Name: idx_TTO_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TTO_1_geometry" ON public."TTO_1" USING gist (geometry);


--
-- Name: idx_TUN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUN_0_geometry" ON public."TUN_0" USING gist (geometry);


--
-- Name: idx_TUN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUN_1_geometry" ON public."TUN_1" USING gist (geometry);


--
-- Name: idx_TUN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUN_2_geometry" ON public."TUN_2" USING gist (geometry);


--
-- Name: idx_TUR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUR_0_geometry" ON public."TUR_0" USING gist (geometry);


--
-- Name: idx_TUR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUR_1_geometry" ON public."TUR_1" USING gist (geometry);


--
-- Name: idx_TUR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUR_2_geometry" ON public."TUR_2" USING gist (geometry);


--
-- Name: idx_TUV_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUV_0_geometry" ON public."TUV_0" USING gist (geometry);


--
-- Name: idx_TUV_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TUV_1_geometry" ON public."TUV_1" USING gist (geometry);


--
-- Name: idx_TWN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TWN_0_geometry" ON public."TWN_0" USING gist (geometry);


--
-- Name: idx_TWN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TWN_1_geometry" ON public."TWN_1" USING gist (geometry);


--
-- Name: idx_TWN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TWN_2_geometry" ON public."TWN_2" USING gist (geometry);


--
-- Name: idx_TZA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TZA_0_geometry" ON public."TZA_0" USING gist (geometry);


--
-- Name: idx_TZA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TZA_1_geometry" ON public."TZA_1" USING gist (geometry);


--
-- Name: idx_TZA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TZA_2_geometry" ON public."TZA_2" USING gist (geometry);


--
-- Name: idx_TZA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_TZA_3_geometry" ON public."TZA_3" USING gist (geometry);


--
-- Name: idx_UGA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UGA_0_geometry" ON public."UGA_0" USING gist (geometry);


--
-- Name: idx_UGA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UGA_1_geometry" ON public."UGA_1" USING gist (geometry);


--
-- Name: idx_UGA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UGA_2_geometry" ON public."UGA_2" USING gist (geometry);


--
-- Name: idx_UGA_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UGA_3_geometry" ON public."UGA_3" USING gist (geometry);


--
-- Name: idx_UGA_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UGA_4_geometry" ON public."UGA_4" USING gist (geometry);


--
-- Name: idx_UKR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UKR_0_geometry" ON public."UKR_0" USING gist (geometry);


--
-- Name: idx_UKR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UKR_1_geometry" ON public."UKR_1" USING gist (geometry);


--
-- Name: idx_UKR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UKR_2_geometry" ON public."UKR_2" USING gist (geometry);


--
-- Name: idx_UMI_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UMI_0_geometry" ON public."UMI_0" USING gist (geometry);


--
-- Name: idx_UMI_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UMI_1_geometry" ON public."UMI_1" USING gist (geometry);


--
-- Name: idx_URY_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_URY_0_geometry" ON public."URY_0" USING gist (geometry);


--
-- Name: idx_URY_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_URY_1_geometry" ON public."URY_1" USING gist (geometry);


--
-- Name: idx_URY_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_URY_2_geometry" ON public."URY_2" USING gist (geometry);


--
-- Name: idx_USA_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_USA_0_geometry" ON public."USA_0" USING gist (geometry);


--
-- Name: idx_USA_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_USA_1_geometry" ON public."USA_1" USING gist (geometry);


--
-- Name: idx_USA_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_USA_2_geometry" ON public."USA_2" USING gist (geometry);


--
-- Name: idx_UZB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UZB_0_geometry" ON public."UZB_0" USING gist (geometry);


--
-- Name: idx_UZB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UZB_1_geometry" ON public."UZB_1" USING gist (geometry);


--
-- Name: idx_UZB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_UZB_2_geometry" ON public."UZB_2" USING gist (geometry);


--
-- Name: idx_VAT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VAT_0_geometry" ON public."VAT_0" USING gist (geometry);


--
-- Name: idx_VCT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VCT_0_geometry" ON public."VCT_0" USING gist (geometry);


--
-- Name: idx_VCT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VCT_1_geometry" ON public."VCT_1" USING gist (geometry);


--
-- Name: idx_VEN_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VEN_0_geometry" ON public."VEN_0" USING gist (geometry);


--
-- Name: idx_VEN_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VEN_1_geometry" ON public."VEN_1" USING gist (geometry);


--
-- Name: idx_VEN_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VEN_2_geometry" ON public."VEN_2" USING gist (geometry);


--
-- Name: idx_VGB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VGB_0_geometry" ON public."VGB_0" USING gist (geometry);


--
-- Name: idx_VGB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VGB_1_geometry" ON public."VGB_1" USING gist (geometry);


--
-- Name: idx_VIR_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VIR_0_geometry" ON public."VIR_0" USING gist (geometry);


--
-- Name: idx_VIR_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VIR_1_geometry" ON public."VIR_1" USING gist (geometry);


--
-- Name: idx_VIR_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VIR_2_geometry" ON public."VIR_2" USING gist (geometry);


--
-- Name: idx_VNM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VNM_0_geometry" ON public."VNM_0" USING gist (geometry);


--
-- Name: idx_VNM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VNM_1_geometry" ON public."VNM_1" USING gist (geometry);


--
-- Name: idx_VNM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VNM_2_geometry" ON public."VNM_2" USING gist (geometry);


--
-- Name: idx_VNM_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VNM_3_geometry" ON public."VNM_3" USING gist (geometry);


--
-- Name: idx_VUT_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VUT_0_geometry" ON public."VUT_0" USING gist (geometry);


--
-- Name: idx_VUT_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VUT_1_geometry" ON public."VUT_1" USING gist (geometry);


--
-- Name: idx_VUT_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_VUT_2_geometry" ON public."VUT_2" USING gist (geometry);


--
-- Name: idx_WLF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WLF_0_geometry" ON public."WLF_0" USING gist (geometry);


--
-- Name: idx_WLF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WLF_1_geometry" ON public."WLF_1" USING gist (geometry);


--
-- Name: idx_WLF_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WLF_2_geometry" ON public."WLF_2" USING gist (geometry);


--
-- Name: idx_WSM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WSM_0_geometry" ON public."WSM_0" USING gist (geometry);


--
-- Name: idx_WSM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WSM_1_geometry" ON public."WSM_1" USING gist (geometry);


--
-- Name: idx_WSM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_WSM_2_geometry" ON public."WSM_2" USING gist (geometry);


--
-- Name: idx_YEM_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_YEM_0_geometry" ON public."YEM_0" USING gist (geometry);


--
-- Name: idx_YEM_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_YEM_1_geometry" ON public."YEM_1" USING gist (geometry);


--
-- Name: idx_YEM_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_YEM_2_geometry" ON public."YEM_2" USING gist (geometry);


--
-- Name: idx_ZAF_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZAF_0_geometry" ON public."ZAF_0" USING gist (geometry);


--
-- Name: idx_ZAF_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZAF_1_geometry" ON public."ZAF_1" USING gist (geometry);


--
-- Name: idx_ZAF_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZAF_2_geometry" ON public."ZAF_2" USING gist (geometry);


--
-- Name: idx_ZAF_3_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZAF_3_geometry" ON public."ZAF_3" USING gist (geometry);


--
-- Name: idx_ZAF_4_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZAF_4_geometry" ON public."ZAF_4" USING gist (geometry);


--
-- Name: idx_ZMB_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZMB_0_geometry" ON public."ZMB_0" USING gist (geometry);


--
-- Name: idx_ZMB_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZMB_1_geometry" ON public."ZMB_1" USING gist (geometry);


--
-- Name: idx_ZMB_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZMB_2_geometry" ON public."ZMB_2" USING gist (geometry);


--
-- Name: idx_ZWE_0_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZWE_0_geometry" ON public."ZWE_0" USING gist (geometry);


--
-- Name: idx_ZWE_1_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZWE_1_geometry" ON public."ZWE_1" USING gist (geometry);


--
-- Name: idx_ZWE_2_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX "idx_ZWE_2_geometry" ON public."ZWE_2" USING gist (geometry);


--
-- Name: idx_gadm36_geometry; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX idx_gadm36_geometry ON public.gadm36 USING gist (geometry);


--
-- Name: iso_idx; Type: INDEX; Schema: public; Owner: dev_epigraph
--

CREATE INDEX iso_idx ON public.owid_covid USING btree (iso_code);


--
-- Name: date_idx; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX date_idx ON switzerland.foph_cases USING btree (date);


--
-- Name: idx_map_cantons_geometry; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX idx_map_cantons_geometry ON switzerland.map_cantons USING gist (geometry);


--
-- Name: ix_switzerland_df_val_hosp_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_df_val_hosp_cantons_index ON switzerland.df_val_hosp_cantons USING btree (index);


--
-- Name: ix_switzerland_foph_cases_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_cases_id_ ON switzerland.foph_cases USING btree (id_);


--
-- Name: ix_switzerland_foph_casesvaccpersons_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_casesvaccpersons_id_ ON switzerland.foph_casesvaccpersons USING btree (id_);


--
-- Name: ix_switzerland_foph_covidcertificates_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_covidcertificates_id_ ON switzerland.foph_covidcertificates USING btree (id_);


--
-- Name: ix_switzerland_foph_death_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_death_id_ ON switzerland.foph_death USING btree (id_);


--
-- Name: ix_switzerland_foph_deathvaccpersons_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_deathvaccpersons_id_ ON switzerland.foph_deathvaccpersons USING btree (id_);


--
-- Name: ix_switzerland_foph_hosp_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_hosp_id_ ON switzerland.foph_hosp USING btree (id_);


--
-- Name: ix_switzerland_foph_hospcapacity_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_hospcapacity_id_ ON switzerland.foph_hospcapacity USING btree (id_);


--
-- Name: ix_switzerland_foph_hospvaccpersons_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_hospvaccpersons_id_ ON switzerland.foph_hospvaccpersons USING btree (id_);


--
-- Name: ix_switzerland_foph_intcases_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_intcases_id_ ON switzerland.foph_intcases USING btree (id_);


--
-- Name: ix_switzerland_foph_re_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_re_id_ ON switzerland.foph_re USING btree (id_);


--
-- Name: ix_switzerland_foph_test_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_test_id_ ON switzerland.foph_test USING btree (id_);


--
-- Name: ix_switzerland_foph_testpcrantigen_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_testpcrantigen_id_ ON switzerland.foph_testpcrantigen USING btree (id_);


--
-- Name: ix_switzerland_foph_virusvariantswgs_id_; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_foph_virusvariantswgs_id_ ON switzerland.foph_virusvariantswgs USING btree (id_);


--
-- Name: ix_switzerland_janne_scenario_1_Date; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX "ix_switzerland_janne_scenario_1_Date" ON switzerland.janne_scenario_1 USING btree ("Date");


--
-- Name: ix_switzerland_janne_scenario_2_Date; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX "ix_switzerland_janne_scenario_2_Date" ON switzerland.janne_scenario_2 USING btree ("Date");


--
-- Name: ix_switzerland_janne_scenario_3_Date; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX "ix_switzerland_janne_scenario_3_Date" ON switzerland.janne_scenario_3 USING btree ("Date");


--
-- Name: ix_switzerland_janne_scenario_4_Date; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX "ix_switzerland_janne_scenario_4_Date" ON switzerland.janne_scenario_4 USING btree ("Date");


--
-- Name: ix_switzerland_ml_for_hosp_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_for_hosp_all_cantons_index ON switzerland.ml_for_hosp_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_for_icu_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_for_icu_all_cantons_index ON switzerland.ml_for_icu_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_for_total_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_for_total_all_cantons_index ON switzerland.ml_for_total_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_hosp_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_hosp_index ON switzerland.ml_forecast_hosp USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_hosp_up_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_hosp_up_index ON switzerland.ml_forecast_hosp_up USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_icu_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_icu_index ON switzerland.ml_forecast_icu USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_icu_up_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_icu_up_index ON switzerland.ml_forecast_icu_up USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_index ON switzerland.ml_forecast USING btree (index);


--
-- Name: ix_switzerland_ml_forecast_total_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_forecast_total_index ON switzerland.ml_forecast_total USING btree (index);


--
-- Name: ix_switzerland_ml_val_hosp_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_val_hosp_all_cantons_index ON switzerland.ml_val_hosp_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_val_icu_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_val_icu_all_cantons_index ON switzerland.ml_val_icu_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_val_total_all_cantons_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_val_total_all_cantons_index ON switzerland.ml_val_total_all_cantons USING btree (index);


--
-- Name: ix_switzerland_ml_validation_hosp_up_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_validation_hosp_up_index ON switzerland.ml_validation_hosp_up USING btree (index);


--
-- Name: ix_switzerland_ml_validation_icu_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_validation_icu_index ON switzerland.ml_validation_icu USING btree (index);


--
-- Name: ix_switzerland_ml_validation_icu_up_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_validation_icu_up_index ON switzerland.ml_validation_icu_up USING btree (index);


--
-- Name: ix_switzerland_ml_validation_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_validation_index ON switzerland.ml_validation USING btree (index);


--
-- Name: ix_switzerland_ml_validation_total_index; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_ml_validation_total_index ON switzerland.ml_validation_total USING btree (index);


--
-- Name: ix_switzerland_phosp_post_datum; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_phosp_post_datum ON switzerland.phosp_post USING btree (datum);


--
-- Name: ix_switzerland_prev_post_datum; Type: INDEX; Schema: switzerland; Owner: dev_epigraph
--

CREATE INDEX ix_switzerland_prev_post_datum ON switzerland.prev_post USING btree (datum);


--
-- Name: SCHEMA brasil; Type: ACL; Schema: -; Owner: dev_admin
--

GRANT ALL ON SCHEMA brasil TO dev_epigraph;


--
-- Name: SCHEMA colombia; Type: ACL; Schema: -; Owner: dev_admin
--

GRANT ALL ON SCHEMA colombia TO dev_epigraph;
GRANT ALL ON SCHEMA colombia TO dev_epigraph;


--
-- Name: SCHEMA switzerland; Type: ACL; Schema: -; Owner: dev_admin
--

GRANT USAGE ON SCHEMA switzerland TO dev_epigraph;
GRANT USAGE ON  SCHEMA switzerland TO dev_epigraph;
GRANT ALL ON SCHEMA switzerland TO dev_epigraph;
GRANT ALL ON ALL TABLES IN SCHEMA switzerland TO dev_epigraph;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA switzerland TO dev_epigraph;
GRANT ALL ON ALL SEQUENCES IN SCHEMA switzerland TO dev_epigraph;


--
-- Name: TABLE "ABW_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ABW_0" TO dev_external;


--
-- Name: TABLE "AFG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AFG_0" TO dev_external;


--
-- Name: TABLE "AFG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AFG_1" TO dev_external;


--
-- Name: TABLE "AFG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AFG_2" TO dev_external;


--
-- Name: TABLE "AGO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AGO_0" TO dev_external;


--
-- Name: TABLE "AGO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AGO_1" TO dev_external;


--
-- Name: TABLE "AGO_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AGO_2" TO dev_external;


--
-- Name: TABLE "AGO_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AGO_3" TO dev_external;


--
-- Name: TABLE "AIA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AIA_0" TO dev_external;


--
-- Name: TABLE "ALA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALA_0" TO dev_external;


--
-- Name: TABLE "ALA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALA_1" TO dev_external;


--
-- Name: TABLE "ALB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALB_0" TO dev_external;


--
-- Name: TABLE "ALB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALB_1" TO dev_external;


--
-- Name: TABLE "ALB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALB_2" TO dev_external;


--
-- Name: TABLE "ALB_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ALB_3" TO dev_external;


--
-- Name: TABLE "AND_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AND_0" TO dev_external;


--
-- Name: TABLE "AND_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AND_1" TO dev_external;


--
-- Name: TABLE "ARE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARE_0" TO dev_external;


--
-- Name: TABLE "ARE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARE_1" TO dev_external;


--
-- Name: TABLE "ARE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARE_2" TO dev_external;


--
-- Name: TABLE "ARE_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARE_3" TO dev_external;


--
-- Name: TABLE "ARG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARG_0" TO dev_external;


--
-- Name: TABLE "ARG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARG_1" TO dev_external;


--
-- Name: TABLE "ARG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARG_2" TO dev_external;


--
-- Name: TABLE "ARM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARM_0" TO dev_external;


--
-- Name: TABLE "ARM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ARM_1" TO dev_external;


--
-- Name: TABLE "ASM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ASM_0" TO dev_external;


--
-- Name: TABLE "ASM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ASM_1" TO dev_external;


--
-- Name: TABLE "ASM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ASM_2" TO dev_external;


--
-- Name: TABLE "ASM_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ASM_3" TO dev_external;


--
-- Name: TABLE "ATA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ATA_0" TO dev_external;


--
-- Name: TABLE "ATF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ATF_0" TO dev_external;


--
-- Name: TABLE "ATF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ATF_1" TO dev_external;


--
-- Name: TABLE "ATG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ATG_0" TO dev_external;


--
-- Name: TABLE "ATG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ATG_1" TO dev_external;


--
-- Name: TABLE "AUS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUS_0" TO dev_external;


--
-- Name: TABLE "AUS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUS_1" TO dev_external;


--
-- Name: TABLE "AUS_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUS_2" TO dev_external;


--
-- Name: TABLE "AUT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUT_0" TO dev_external;


--
-- Name: TABLE "AUT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUT_1" TO dev_external;


--
-- Name: TABLE "AUT_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUT_2" TO dev_external;


--
-- Name: TABLE "AUT_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AUT_3" TO dev_external;


--
-- Name: TABLE "AZE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AZE_0" TO dev_external;


--
-- Name: TABLE "AZE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AZE_1" TO dev_external;


--
-- Name: TABLE "AZE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."AZE_2" TO dev_external;


--
-- Name: TABLE "BDI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BDI_0" TO dev_external;


--
-- Name: TABLE "BDI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BDI_1" TO dev_external;


--
-- Name: TABLE "BDI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BDI_2" TO dev_external;


--
-- Name: TABLE "BDI_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BDI_3" TO dev_external;


--
-- Name: TABLE "BDI_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BDI_4" TO dev_external;


--
-- Name: TABLE "BEL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEL_0" TO dev_external;


--
-- Name: TABLE "BEL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEL_1" TO dev_external;


--
-- Name: TABLE "BEL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEL_2" TO dev_external;


--
-- Name: TABLE "BEL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEL_3" TO dev_external;


--
-- Name: TABLE "BEL_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEL_4" TO dev_external;


--
-- Name: TABLE "BEN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEN_0" TO dev_external;


--
-- Name: TABLE "BEN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEN_1" TO dev_external;


--
-- Name: TABLE "BEN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BEN_2" TO dev_external;


--
-- Name: TABLE "BFA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BFA_0" TO dev_external;


--
-- Name: TABLE "BFA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BFA_1" TO dev_external;


--
-- Name: TABLE "BFA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BFA_2" TO dev_external;


--
-- Name: TABLE "BFA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BFA_3" TO dev_external;


--
-- Name: TABLE "BGD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGD_0" TO dev_external;


--
-- Name: TABLE "BGD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGD_1" TO dev_external;


--
-- Name: TABLE "BGD_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGD_2" TO dev_external;


--
-- Name: TABLE "BGD_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGD_3" TO dev_external;


--
-- Name: TABLE "BGD_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGD_4" TO dev_external;


--
-- Name: TABLE "BGR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGR_0" TO dev_external;


--
-- Name: TABLE "BGR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGR_1" TO dev_external;


--
-- Name: TABLE "BGR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BGR_2" TO dev_external;


--
-- Name: TABLE "BHR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BHR_0" TO dev_external;


--
-- Name: TABLE "BHR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BHR_1" TO dev_external;


--
-- Name: TABLE "BHS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BHS_0" TO dev_external;


--
-- Name: TABLE "BHS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BHS_1" TO dev_external;


--
-- Name: TABLE "BIH_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BIH_0" TO dev_external;


--
-- Name: TABLE "BIH_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BIH_1" TO dev_external;


--
-- Name: TABLE "BIH_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BIH_2" TO dev_external;


--
-- Name: TABLE "BIH_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BIH_3" TO dev_external;


--
-- Name: TABLE "BLM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLM_0" TO dev_external;


--
-- Name: TABLE "BLR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLR_0" TO dev_external;


--
-- Name: TABLE "BLR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLR_1" TO dev_external;


--
-- Name: TABLE "BLR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLR_2" TO dev_external;


--
-- Name: TABLE "BLZ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLZ_0" TO dev_external;


--
-- Name: TABLE "BLZ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BLZ_1" TO dev_external;


--
-- Name: TABLE "BMU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BMU_0" TO dev_external;


--
-- Name: TABLE "BMU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BMU_1" TO dev_external;


--
-- Name: TABLE "BOL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BOL_0" TO dev_external;


--
-- Name: TABLE "BOL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BOL_1" TO dev_external;


--
-- Name: TABLE "BOL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BOL_2" TO dev_external;


--
-- Name: TABLE "BOL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BOL_3" TO dev_external;


--
-- Name: TABLE "BRA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRA_0" TO dev_external;


--
-- Name: TABLE "BRA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRA_1" TO dev_external;


--
-- Name: TABLE "BRA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRA_2" TO dev_external;


--
-- Name: TABLE "BRA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRA_3" TO dev_external;


--
-- Name: TABLE "BRB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRB_0" TO dev_external;


--
-- Name: TABLE "BRB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRB_1" TO dev_external;


--
-- Name: TABLE "BRN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRN_0" TO dev_external;


--
-- Name: TABLE "BRN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRN_1" TO dev_external;


--
-- Name: TABLE "BRN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BRN_2" TO dev_external;


--
-- Name: TABLE "BTN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BTN_0" TO dev_external;


--
-- Name: TABLE "BTN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BTN_1" TO dev_external;


--
-- Name: TABLE "BTN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BTN_2" TO dev_external;


--
-- Name: TABLE "BVT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BVT_0" TO dev_external;


--
-- Name: TABLE "BWA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BWA_0" TO dev_external;


--
-- Name: TABLE "BWA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BWA_1" TO dev_external;


--
-- Name: TABLE "BWA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."BWA_2" TO dev_external;


--
-- Name: TABLE "CAF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAF_0" TO dev_external;


--
-- Name: TABLE "CAF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAF_1" TO dev_external;


--
-- Name: TABLE "CAF_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAF_2" TO dev_external;


--
-- Name: TABLE "CAN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAN_0" TO dev_external;


--
-- Name: TABLE "CAN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAN_1" TO dev_external;


--
-- Name: TABLE "CAN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAN_2" TO dev_external;


--
-- Name: TABLE "CAN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CAN_3" TO dev_external;


--
-- Name: TABLE "CCK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CCK_0" TO dev_external;


--
-- Name: TABLE "CHE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHE_0" TO dev_external;


--
-- Name: TABLE "CHE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHE_1" TO dev_external;


--
-- Name: TABLE "CHE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHE_2" TO dev_external;


--
-- Name: TABLE "CHE_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHE_3" TO dev_external;


--
-- Name: TABLE "CHL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHL_0" TO dev_external;


--
-- Name: TABLE "CHL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHL_1" TO dev_external;


--
-- Name: TABLE "CHL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHL_2" TO dev_external;


--
-- Name: TABLE "CHL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHL_3" TO dev_external;


--
-- Name: TABLE "CHN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHN_0" TO dev_external;


--
-- Name: TABLE "CHN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHN_1" TO dev_external;


--
-- Name: TABLE "CHN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHN_2" TO dev_external;


--
-- Name: TABLE "CHN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CHN_3" TO dev_external;


--
-- Name: TABLE "CIV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CIV_0" TO dev_external;


--
-- Name: TABLE "CIV_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CIV_1" TO dev_external;


--
-- Name: TABLE "CIV_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CIV_2" TO dev_external;


--
-- Name: TABLE "CIV_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CIV_3" TO dev_external;


--
-- Name: TABLE "CIV_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CIV_4" TO dev_external;


--
-- Name: TABLE "CMR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CMR_0" TO dev_external;


--
-- Name: TABLE "CMR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CMR_1" TO dev_external;


--
-- Name: TABLE "CMR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CMR_2" TO dev_external;


--
-- Name: TABLE "CMR_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CMR_3" TO dev_external;


--
-- Name: TABLE "COD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COD_0" TO dev_external;


--
-- Name: TABLE "COD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COD_1" TO dev_external;


--
-- Name: TABLE "COD_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COD_2" TO dev_external;


--
-- Name: TABLE "COG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COG_0" TO dev_external;


--
-- Name: TABLE "COG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COG_1" TO dev_external;


--
-- Name: TABLE "COG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COG_2" TO dev_external;


--
-- Name: TABLE "COK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COK_0" TO dev_external;


--
-- Name: TABLE "COL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COL_0" TO dev_external;


--
-- Name: TABLE "COL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COL_1" TO dev_external;


--
-- Name: TABLE "COL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COL_2" TO dev_external;


--
-- Name: TABLE "COM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COM_0" TO dev_external;


--
-- Name: TABLE "COM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."COM_1" TO dev_external;


--
-- Name: TABLE "CPV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CPV_0" TO dev_external;


--
-- Name: TABLE "CPV_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CPV_1" TO dev_external;


--
-- Name: TABLE "CRI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CRI_0" TO dev_external;


--
-- Name: TABLE "CRI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CRI_1" TO dev_external;


--
-- Name: TABLE "CRI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CRI_2" TO dev_external;


--
-- Name: TABLE "CUB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CUB_0" TO dev_external;


--
-- Name: TABLE "CUB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CUB_1" TO dev_external;


--
-- Name: TABLE "CUB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CUB_2" TO dev_external;


--
-- Name: TABLE "CXR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CXR_0" TO dev_external;


--
-- Name: TABLE "CYM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CYM_0" TO dev_external;


--
-- Name: TABLE "CYM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CYM_1" TO dev_external;


--
-- Name: TABLE "CYP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CYP_0" TO dev_external;


--
-- Name: TABLE "CYP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CYP_1" TO dev_external;


--
-- Name: TABLE "CZE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CZE_0" TO dev_external;


--
-- Name: TABLE "CZE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CZE_1" TO dev_external;


--
-- Name: TABLE "CZE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."CZE_2" TO dev_external;


--
-- Name: TABLE "DEU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DEU_0" TO dev_external;


--
-- Name: TABLE "DEU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DEU_1" TO dev_external;


--
-- Name: TABLE "DEU_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DEU_2" TO dev_external;


--
-- Name: TABLE "DEU_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DEU_3" TO dev_external;


--
-- Name: TABLE "DEU_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DEU_4" TO dev_external;


--
-- Name: TABLE "DJI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DJI_0" TO dev_external;


--
-- Name: TABLE "DJI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DJI_1" TO dev_external;


--
-- Name: TABLE "DJI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DJI_2" TO dev_external;


--
-- Name: TABLE "DMA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DMA_0" TO dev_external;


--
-- Name: TABLE "DMA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DMA_1" TO dev_external;


--
-- Name: TABLE "DNK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DNK_0" TO dev_external;


--
-- Name: TABLE "DNK_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DNK_1" TO dev_external;


--
-- Name: TABLE "DNK_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DNK_2" TO dev_external;


--
-- Name: TABLE "DOM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DOM_0" TO dev_external;


--
-- Name: TABLE "DOM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DOM_1" TO dev_external;


--
-- Name: TABLE "DOM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DOM_2" TO dev_external;


--
-- Name: TABLE "DZA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DZA_0" TO dev_external;


--
-- Name: TABLE "DZA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DZA_1" TO dev_external;


--
-- Name: TABLE "DZA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."DZA_2" TO dev_external;


--
-- Name: TABLE "ECU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ECU_0" TO dev_external;


--
-- Name: TABLE "ECU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ECU_1" TO dev_external;


--
-- Name: TABLE "ECU_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ECU_2" TO dev_external;


--
-- Name: TABLE "ECU_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ECU_3" TO dev_external;


--
-- Name: TABLE "EGY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EGY_0" TO dev_external;


--
-- Name: TABLE "EGY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EGY_1" TO dev_external;


--
-- Name: TABLE "EGY_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EGY_2" TO dev_external;


--
-- Name: TABLE "ERI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ERI_0" TO dev_external;


--
-- Name: TABLE "ERI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ERI_1" TO dev_external;


--
-- Name: TABLE "ERI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ERI_2" TO dev_external;


--
-- Name: TABLE "ESH_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESH_0" TO dev_external;


--
-- Name: TABLE "ESH_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESH_1" TO dev_external;


--
-- Name: TABLE "ESP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESP_0" TO dev_external;


--
-- Name: TABLE "ESP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESP_1" TO dev_external;


--
-- Name: TABLE "ESP_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESP_2" TO dev_external;


--
-- Name: TABLE "ESP_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESP_3" TO dev_external;


--
-- Name: TABLE "ESP_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ESP_4" TO dev_external;


--
-- Name: TABLE "EST_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EST_0" TO dev_external;


--
-- Name: TABLE "EST_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EST_1" TO dev_external;


--
-- Name: TABLE "EST_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EST_2" TO dev_external;


--
-- Name: TABLE "EST_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."EST_3" TO dev_external;


--
-- Name: TABLE "ETH_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ETH_0" TO dev_external;


--
-- Name: TABLE "ETH_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ETH_1" TO dev_external;


--
-- Name: TABLE "ETH_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ETH_2" TO dev_external;


--
-- Name: TABLE "ETH_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ETH_3" TO dev_external;


--
-- Name: TABLE "FIN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FIN_0" TO dev_external;


--
-- Name: TABLE "FIN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FIN_1" TO dev_external;


--
-- Name: TABLE "FIN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FIN_2" TO dev_external;


--
-- Name: TABLE "FIN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FIN_3" TO dev_external;


--
-- Name: TABLE "FIN_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FIN_4" TO dev_external;


--
-- Name: TABLE "FJI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FJI_0" TO dev_external;


--
-- Name: TABLE "FJI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FJI_1" TO dev_external;


--
-- Name: TABLE "FJI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FJI_2" TO dev_external;


--
-- Name: TABLE "FLK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FLK_0" TO dev_external;


--
-- Name: TABLE "FRA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_0" TO dev_external;


--
-- Name: TABLE "FRA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_1" TO dev_external;


--
-- Name: TABLE "FRA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_2" TO dev_external;


--
-- Name: TABLE "FRA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_3" TO dev_external;


--
-- Name: TABLE "FRA_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_4" TO dev_external;


--
-- Name: TABLE "FRA_5"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRA_5" TO dev_external;


--
-- Name: TABLE "FRO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRO_0" TO dev_external;


--
-- Name: TABLE "FRO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRO_1" TO dev_external;


--
-- Name: TABLE "FRO_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FRO_2" TO dev_external;


--
-- Name: TABLE "FSM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FSM_0" TO dev_external;


--
-- Name: TABLE "FSM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."FSM_1" TO dev_external;


--
-- Name: TABLE "GAB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GAB_0" TO dev_external;


--
-- Name: TABLE "GAB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GAB_1" TO dev_external;


--
-- Name: TABLE "GAB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GAB_2" TO dev_external;


--
-- Name: TABLE "GBR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GBR_0" TO dev_external;


--
-- Name: TABLE "GBR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GBR_1" TO dev_external;


--
-- Name: TABLE "GBR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GBR_2" TO dev_external;


--
-- Name: TABLE "GBR_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GBR_3" TO dev_external;


--
-- Name: TABLE "GEO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GEO_0" TO dev_external;


--
-- Name: TABLE "GEO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GEO_1" TO dev_external;


--
-- Name: TABLE "GEO_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GEO_2" TO dev_external;


--
-- Name: TABLE "GGY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GGY_0" TO dev_external;


--
-- Name: TABLE "GGY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GGY_1" TO dev_external;


--
-- Name: TABLE "GHA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GHA_0" TO dev_external;


--
-- Name: TABLE "GHA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GHA_1" TO dev_external;


--
-- Name: TABLE "GHA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GHA_2" TO dev_external;


--
-- Name: TABLE "GIB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GIB_0" TO dev_external;


--
-- Name: TABLE "GIN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GIN_0" TO dev_external;


--
-- Name: TABLE "GIN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GIN_1" TO dev_external;


--
-- Name: TABLE "GIN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GIN_2" TO dev_external;


--
-- Name: TABLE "GIN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GIN_3" TO dev_external;


--
-- Name: TABLE "GLP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GLP_0" TO dev_external;


--
-- Name: TABLE "GLP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GLP_1" TO dev_external;


--
-- Name: TABLE "GLP_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GLP_2" TO dev_external;


--
-- Name: TABLE "GMB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GMB_0" TO dev_external;


--
-- Name: TABLE "GMB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GMB_1" TO dev_external;


--
-- Name: TABLE "GMB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GMB_2" TO dev_external;


--
-- Name: TABLE "GNB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNB_0" TO dev_external;


--
-- Name: TABLE "GNB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNB_1" TO dev_external;


--
-- Name: TABLE "GNB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNB_2" TO dev_external;


--
-- Name: TABLE "GNQ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNQ_0" TO dev_external;


--
-- Name: TABLE "GNQ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNQ_1" TO dev_external;


--
-- Name: TABLE "GNQ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GNQ_2" TO dev_external;


--
-- Name: TABLE "GRC_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRC_0" TO dev_external;


--
-- Name: TABLE "GRC_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRC_1" TO dev_external;


--
-- Name: TABLE "GRC_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRC_2" TO dev_external;


--
-- Name: TABLE "GRC_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRC_3" TO dev_external;


--
-- Name: TABLE "GRD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRD_0" TO dev_external;


--
-- Name: TABLE "GRD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRD_1" TO dev_external;


--
-- Name: TABLE "GRL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRL_0" TO dev_external;


--
-- Name: TABLE "GRL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GRL_1" TO dev_external;


--
-- Name: TABLE "GTM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GTM_0" TO dev_external;


--
-- Name: TABLE "GTM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GTM_1" TO dev_external;


--
-- Name: TABLE "GTM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GTM_2" TO dev_external;


--
-- Name: TABLE "GUF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUF_0" TO dev_external;


--
-- Name: TABLE "GUF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUF_1" TO dev_external;


--
-- Name: TABLE "GUF_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUF_2" TO dev_external;


--
-- Name: TABLE "GUM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUM_0" TO dev_external;


--
-- Name: TABLE "GUM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUM_1" TO dev_external;


--
-- Name: TABLE "GUY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUY_0" TO dev_external;


--
-- Name: TABLE "GUY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUY_1" TO dev_external;


--
-- Name: TABLE "GUY_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."GUY_2" TO dev_external;


--
-- Name: TABLE "HKG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HKG_0" TO dev_external;


--
-- Name: TABLE "HKG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HKG_1" TO dev_external;


--
-- Name: TABLE "HMD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HMD_0" TO dev_external;


--
-- Name: TABLE "HND_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HND_0" TO dev_external;


--
-- Name: TABLE "HND_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HND_1" TO dev_external;


--
-- Name: TABLE "HND_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HND_2" TO dev_external;


--
-- Name: TABLE "HRV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HRV_0" TO dev_external;


--
-- Name: TABLE "HRV_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HRV_1" TO dev_external;


--
-- Name: TABLE "HRV_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HRV_2" TO dev_external;


--
-- Name: TABLE "HTI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HTI_0" TO dev_external;


--
-- Name: TABLE "HTI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HTI_1" TO dev_external;


--
-- Name: TABLE "HTI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HTI_2" TO dev_external;


--
-- Name: TABLE "HTI_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HTI_3" TO dev_external;


--
-- Name: TABLE "HTI_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HTI_4" TO dev_external;


--
-- Name: TABLE "HUN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HUN_0" TO dev_external;


--
-- Name: TABLE "HUN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HUN_1" TO dev_external;


--
-- Name: TABLE "HUN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."HUN_2" TO dev_external;


--
-- Name: TABLE "IDN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IDN_0" TO dev_external;


--
-- Name: TABLE "IDN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IDN_1" TO dev_external;


--
-- Name: TABLE "IDN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IDN_2" TO dev_external;


--
-- Name: TABLE "IDN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IDN_3" TO dev_external;


--
-- Name: TABLE "IDN_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IDN_4" TO dev_external;


--
-- Name: TABLE "IMN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IMN_0" TO dev_external;


--
-- Name: TABLE "IMN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IMN_1" TO dev_external;


--
-- Name: TABLE "IMN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IMN_2" TO dev_external;


--
-- Name: TABLE "IND_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IND_0" TO dev_external;


--
-- Name: TABLE "IND_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IND_1" TO dev_external;


--
-- Name: TABLE "IND_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IND_2" TO dev_external;


--
-- Name: TABLE "IND_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IND_3" TO dev_external;


--
-- Name: TABLE "IOT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IOT_0" TO dev_external;


--
-- Name: TABLE "IRL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRL_0" TO dev_external;


--
-- Name: TABLE "IRL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRL_1" TO dev_external;


--
-- Name: TABLE "IRN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRN_0" TO dev_external;


--
-- Name: TABLE "IRN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRN_1" TO dev_external;


--
-- Name: TABLE "IRN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRN_2" TO dev_external;


--
-- Name: TABLE "IRQ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRQ_0" TO dev_external;


--
-- Name: TABLE "IRQ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRQ_1" TO dev_external;


--
-- Name: TABLE "IRQ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."IRQ_2" TO dev_external;


--
-- Name: TABLE "ISL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ISL_0" TO dev_external;


--
-- Name: TABLE "ISL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ISL_1" TO dev_external;


--
-- Name: TABLE "ISL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ISL_2" TO dev_external;


--
-- Name: TABLE "ISR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ISR_0" TO dev_external;


--
-- Name: TABLE "ISR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ISR_1" TO dev_external;


--
-- Name: TABLE "ITA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ITA_0" TO dev_external;


--
-- Name: TABLE "ITA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ITA_1" TO dev_external;


--
-- Name: TABLE "ITA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ITA_2" TO dev_external;


--
-- Name: TABLE "ITA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ITA_3" TO dev_external;


--
-- Name: TABLE "JAM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JAM_0" TO dev_external;


--
-- Name: TABLE "JAM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JAM_1" TO dev_external;


--
-- Name: TABLE "JEY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JEY_0" TO dev_external;


--
-- Name: TABLE "JEY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JEY_1" TO dev_external;


--
-- Name: TABLE "JOR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JOR_0" TO dev_external;


--
-- Name: TABLE "JOR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JOR_1" TO dev_external;


--
-- Name: TABLE "JOR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JOR_2" TO dev_external;


--
-- Name: TABLE "JPN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JPN_0" TO dev_external;


--
-- Name: TABLE "JPN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JPN_1" TO dev_external;


--
-- Name: TABLE "JPN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."JPN_2" TO dev_external;


--
-- Name: TABLE "KAZ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KAZ_0" TO dev_external;


--
-- Name: TABLE "KAZ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KAZ_1" TO dev_external;


--
-- Name: TABLE "KAZ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KAZ_2" TO dev_external;


--
-- Name: TABLE "KEN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KEN_0" TO dev_external;


--
-- Name: TABLE "KEN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KEN_1" TO dev_external;


--
-- Name: TABLE "KEN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KEN_2" TO dev_external;


--
-- Name: TABLE "KEN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KEN_3" TO dev_external;


--
-- Name: TABLE "KGZ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KGZ_0" TO dev_external;


--
-- Name: TABLE "KGZ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KGZ_1" TO dev_external;


--
-- Name: TABLE "KGZ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KGZ_2" TO dev_external;


--
-- Name: TABLE "KHM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KHM_0" TO dev_external;


--
-- Name: TABLE "KHM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KHM_1" TO dev_external;


--
-- Name: TABLE "KHM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KHM_2" TO dev_external;


--
-- Name: TABLE "KHM_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KHM_3" TO dev_external;


--
-- Name: TABLE "KHM_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KHM_4" TO dev_external;


--
-- Name: TABLE "KIR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KIR_0" TO dev_external;


--
-- Name: TABLE "KNA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KNA_0" TO dev_external;


--
-- Name: TABLE "KNA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KNA_1" TO dev_external;


--
-- Name: TABLE "KOR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KOR_0" TO dev_external;


--
-- Name: TABLE "KOR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KOR_1" TO dev_external;


--
-- Name: TABLE "KOR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KOR_2" TO dev_external;


--
-- Name: TABLE "KWT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KWT_0" TO dev_external;


--
-- Name: TABLE "KWT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."KWT_1" TO dev_external;


--
-- Name: TABLE "LAO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LAO_0" TO dev_external;


--
-- Name: TABLE "LAO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LAO_1" TO dev_external;


--
-- Name: TABLE "LAO_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LAO_2" TO dev_external;


--
-- Name: TABLE "LBN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBN_0" TO dev_external;


--
-- Name: TABLE "LBN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBN_1" TO dev_external;


--
-- Name: TABLE "LBN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBN_2" TO dev_external;


--
-- Name: TABLE "LBN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBN_3" TO dev_external;


--
-- Name: TABLE "LBR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBR_0" TO dev_external;


--
-- Name: TABLE "LBR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBR_1" TO dev_external;


--
-- Name: TABLE "LBR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBR_2" TO dev_external;


--
-- Name: TABLE "LBR_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBR_3" TO dev_external;


--
-- Name: TABLE "LBY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBY_0" TO dev_external;


--
-- Name: TABLE "LBY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LBY_1" TO dev_external;


--
-- Name: TABLE "LCA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LCA_0" TO dev_external;


--
-- Name: TABLE "LCA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LCA_1" TO dev_external;


--
-- Name: TABLE "LIE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LIE_0" TO dev_external;


--
-- Name: TABLE "LIE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LIE_1" TO dev_external;


--
-- Name: TABLE "LKA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LKA_0" TO dev_external;


--
-- Name: TABLE "LKA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LKA_1" TO dev_external;


--
-- Name: TABLE "LKA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LKA_2" TO dev_external;


--
-- Name: TABLE "LSO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LSO_0" TO dev_external;


--
-- Name: TABLE "LSO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LSO_1" TO dev_external;


--
-- Name: TABLE "LTU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LTU_0" TO dev_external;


--
-- Name: TABLE "LTU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LTU_1" TO dev_external;


--
-- Name: TABLE "LTU_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LTU_2" TO dev_external;


--
-- Name: TABLE "LUX_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LUX_0" TO dev_external;


--
-- Name: TABLE "LUX_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LUX_1" TO dev_external;


--
-- Name: TABLE "LUX_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LUX_2" TO dev_external;


--
-- Name: TABLE "LUX_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LUX_3" TO dev_external;


--
-- Name: TABLE "LUX_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LUX_4" TO dev_external;


--
-- Name: TABLE "LVA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LVA_0" TO dev_external;


--
-- Name: TABLE "LVA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LVA_1" TO dev_external;


--
-- Name: TABLE "LVA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."LVA_2" TO dev_external;


--
-- Name: TABLE "MAC_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAC_0" TO dev_external;


--
-- Name: TABLE "MAC_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAC_1" TO dev_external;


--
-- Name: TABLE "MAC_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAC_2" TO dev_external;


--
-- Name: TABLE "MAF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAF_0" TO dev_external;


--
-- Name: TABLE "MAR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAR_0" TO dev_external;


--
-- Name: TABLE "MAR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAR_1" TO dev_external;


--
-- Name: TABLE "MAR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAR_2" TO dev_external;


--
-- Name: TABLE "MAR_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAR_3" TO dev_external;


--
-- Name: TABLE "MAR_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MAR_4" TO dev_external;


--
-- Name: TABLE "MCO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MCO_0" TO dev_external;


--
-- Name: TABLE "MDA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDA_0" TO dev_external;


--
-- Name: TABLE "MDA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDA_1" TO dev_external;


--
-- Name: TABLE "MDG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDG_0" TO dev_external;


--
-- Name: TABLE "MDG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDG_1" TO dev_external;


--
-- Name: TABLE "MDG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDG_2" TO dev_external;


--
-- Name: TABLE "MDG_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDG_3" TO dev_external;


--
-- Name: TABLE "MDG_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDG_4" TO dev_external;


--
-- Name: TABLE "MDV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MDV_0" TO dev_external;


--
-- Name: TABLE "MEX_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MEX_0" TO dev_external;


--
-- Name: TABLE "MEX_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MEX_1" TO dev_external;


--
-- Name: TABLE "MEX_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MEX_2" TO dev_external;


--
-- Name: TABLE "MHL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MHL_0" TO dev_external;


--
-- Name: TABLE "MKD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MKD_0" TO dev_external;


--
-- Name: TABLE "MKD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MKD_1" TO dev_external;


--
-- Name: TABLE "MLI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLI_0" TO dev_external;


--
-- Name: TABLE "MLI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLI_1" TO dev_external;


--
-- Name: TABLE "MLI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLI_2" TO dev_external;


--
-- Name: TABLE "MLI_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLI_3" TO dev_external;


--
-- Name: TABLE "MLI_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLI_4" TO dev_external;


--
-- Name: TABLE "MLT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLT_0" TO dev_external;


--
-- Name: TABLE "MLT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLT_1" TO dev_external;


--
-- Name: TABLE "MLT_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MLT_2" TO dev_external;


--
-- Name: TABLE "MMR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MMR_0" TO dev_external;


--
-- Name: TABLE "MMR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MMR_1" TO dev_external;


--
-- Name: TABLE "MMR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MMR_2" TO dev_external;


--
-- Name: TABLE "MMR_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MMR_3" TO dev_external;


--
-- Name: TABLE "MNE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNE_0" TO dev_external;


--
-- Name: TABLE "MNE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNE_1" TO dev_external;


--
-- Name: TABLE "MNG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNG_0" TO dev_external;


--
-- Name: TABLE "MNG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNG_1" TO dev_external;


--
-- Name: TABLE "MNG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNG_2" TO dev_external;


--
-- Name: TABLE "MNP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNP_0" TO dev_external;


--
-- Name: TABLE "MNP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MNP_1" TO dev_external;


--
-- Name: TABLE "MOZ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MOZ_0" TO dev_external;


--
-- Name: TABLE "MOZ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MOZ_1" TO dev_external;


--
-- Name: TABLE "MOZ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MOZ_2" TO dev_external;


--
-- Name: TABLE "MOZ_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MOZ_3" TO dev_external;


--
-- Name: TABLE "MRT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MRT_0" TO dev_external;


--
-- Name: TABLE "MRT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MRT_1" TO dev_external;


--
-- Name: TABLE "MRT_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MRT_2" TO dev_external;


--
-- Name: TABLE "MSR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MSR_0" TO dev_external;


--
-- Name: TABLE "MSR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MSR_1" TO dev_external;


--
-- Name: TABLE "MTQ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MTQ_0" TO dev_external;


--
-- Name: TABLE "MTQ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MTQ_1" TO dev_external;


--
-- Name: TABLE "MTQ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MTQ_2" TO dev_external;


--
-- Name: TABLE "MUS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MUS_0" TO dev_external;


--
-- Name: TABLE "MUS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MUS_1" TO dev_external;


--
-- Name: TABLE "MWI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MWI_0" TO dev_external;


--
-- Name: TABLE "MWI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MWI_1" TO dev_external;


--
-- Name: TABLE "MWI_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MWI_2" TO dev_external;


--
-- Name: TABLE "MWI_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MWI_3" TO dev_external;


--
-- Name: TABLE "MYS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MYS_0" TO dev_external;


--
-- Name: TABLE "MYS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MYS_1" TO dev_external;


--
-- Name: TABLE "MYS_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MYS_2" TO dev_external;


--
-- Name: TABLE "MYT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MYT_0" TO dev_external;


--
-- Name: TABLE "MYT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."MYT_1" TO dev_external;


--
-- Name: TABLE "NAM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NAM_0" TO dev_external;


--
-- Name: TABLE "NAM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NAM_1" TO dev_external;


--
-- Name: TABLE "NAM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NAM_2" TO dev_external;


--
-- Name: TABLE "NCL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NCL_0" TO dev_external;


--
-- Name: TABLE "NCL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NCL_1" TO dev_external;


--
-- Name: TABLE "NCL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NCL_2" TO dev_external;


--
-- Name: TABLE "NER_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NER_0" TO dev_external;


--
-- Name: TABLE "NER_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NER_1" TO dev_external;


--
-- Name: TABLE "NER_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NER_2" TO dev_external;


--
-- Name: TABLE "NER_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NER_3" TO dev_external;


--
-- Name: TABLE "NFK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NFK_0" TO dev_external;


--
-- Name: TABLE "NGA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NGA_0" TO dev_external;


--
-- Name: TABLE "NGA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NGA_1" TO dev_external;


--
-- Name: TABLE "NGA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NGA_2" TO dev_external;


--
-- Name: TABLE "NIC_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NIC_0" TO dev_external;


--
-- Name: TABLE "NIC_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NIC_1" TO dev_external;


--
-- Name: TABLE "NIC_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NIC_2" TO dev_external;


--
-- Name: TABLE "NIU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NIU_0" TO dev_external;


--
-- Name: TABLE "NLD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NLD_0" TO dev_external;


--
-- Name: TABLE "NLD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NLD_1" TO dev_external;


--
-- Name: TABLE "NLD_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NLD_2" TO dev_external;


--
-- Name: TABLE "NOR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NOR_0" TO dev_external;


--
-- Name: TABLE "NOR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NOR_1" TO dev_external;


--
-- Name: TABLE "NOR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NOR_2" TO dev_external;


--
-- Name: TABLE "NPL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NPL_0" TO dev_external;


--
-- Name: TABLE "NPL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NPL_1" TO dev_external;


--
-- Name: TABLE "NPL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NPL_2" TO dev_external;


--
-- Name: TABLE "NPL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NPL_3" TO dev_external;


--
-- Name: TABLE "NPL_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NPL_4" TO dev_external;


--
-- Name: TABLE "NRU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NRU_0" TO dev_external;


--
-- Name: TABLE "NRU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NRU_1" TO dev_external;


--
-- Name: TABLE "NZL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NZL_0" TO dev_external;


--
-- Name: TABLE "NZL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NZL_1" TO dev_external;


--
-- Name: TABLE "NZL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."NZL_2" TO dev_external;


--
-- Name: TABLE "OMN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."OMN_0" TO dev_external;


--
-- Name: TABLE "OMN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."OMN_1" TO dev_external;


--
-- Name: TABLE "OMN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."OMN_2" TO dev_external;


--
-- Name: TABLE "PAK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAK_0" TO dev_external;


--
-- Name: TABLE "PAK_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAK_1" TO dev_external;


--
-- Name: TABLE "PAK_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAK_2" TO dev_external;


--
-- Name: TABLE "PAK_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAK_3" TO dev_external;


--
-- Name: TABLE "PAN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAN_0" TO dev_external;


--
-- Name: TABLE "PAN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAN_1" TO dev_external;


--
-- Name: TABLE "PAN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAN_2" TO dev_external;


--
-- Name: TABLE "PAN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PAN_3" TO dev_external;


--
-- Name: TABLE "PCN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PCN_0" TO dev_external;


--
-- Name: TABLE "PER_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PER_0" TO dev_external;


--
-- Name: TABLE "PER_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PER_1" TO dev_external;


--
-- Name: TABLE "PER_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PER_2" TO dev_external;


--
-- Name: TABLE "PER_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PER_3" TO dev_external;


--
-- Name: TABLE "PHL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PHL_0" TO dev_external;


--
-- Name: TABLE "PHL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PHL_1" TO dev_external;


--
-- Name: TABLE "PHL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PHL_2" TO dev_external;


--
-- Name: TABLE "PHL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PHL_3" TO dev_external;


--
-- Name: TABLE "PLW_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PLW_0" TO dev_external;


--
-- Name: TABLE "PLW_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PLW_1" TO dev_external;


--
-- Name: TABLE "PNG_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PNG_0" TO dev_external;


--
-- Name: TABLE "PNG_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PNG_1" TO dev_external;


--
-- Name: TABLE "PNG_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PNG_2" TO dev_external;


--
-- Name: TABLE "POL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."POL_0" TO dev_external;


--
-- Name: TABLE "POL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."POL_1" TO dev_external;


--
-- Name: TABLE "POL_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."POL_2" TO dev_external;


--
-- Name: TABLE "POL_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."POL_3" TO dev_external;


--
-- Name: TABLE "PRI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRI_0" TO dev_external;


--
-- Name: TABLE "PRI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRI_1" TO dev_external;


--
-- Name: TABLE "PRK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRK_0" TO dev_external;


--
-- Name: TABLE "PRK_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRK_1" TO dev_external;


--
-- Name: TABLE "PRK_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRK_2" TO dev_external;


--
-- Name: TABLE "PRT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRT_0" TO dev_external;


--
-- Name: TABLE "PRT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRT_1" TO dev_external;


--
-- Name: TABLE "PRT_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRT_2" TO dev_external;


--
-- Name: TABLE "PRT_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRT_3" TO dev_external;


--
-- Name: TABLE "PRY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRY_0" TO dev_external;


--
-- Name: TABLE "PRY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRY_1" TO dev_external;


--
-- Name: TABLE "PRY_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PRY_2" TO dev_external;


--
-- Name: TABLE "PSE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PSE_0" TO dev_external;


--
-- Name: TABLE "PSE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PSE_1" TO dev_external;


--
-- Name: TABLE "PSE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PSE_2" TO dev_external;


--
-- Name: TABLE "PYF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PYF_0" TO dev_external;


--
-- Name: TABLE "PYF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."PYF_1" TO dev_external;


--
-- Name: TABLE "QAT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."QAT_0" TO dev_external;


--
-- Name: TABLE "QAT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."QAT_1" TO dev_external;


--
-- Name: TABLE "REU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."REU_0" TO dev_external;


--
-- Name: TABLE "REU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."REU_1" TO dev_external;


--
-- Name: TABLE "REU_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."REU_2" TO dev_external;


--
-- Name: TABLE "ROU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ROU_0" TO dev_external;


--
-- Name: TABLE "ROU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ROU_1" TO dev_external;


--
-- Name: TABLE "ROU_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ROU_2" TO dev_external;


--
-- Name: TABLE "RUS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RUS_0" TO dev_external;


--
-- Name: TABLE "RUS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RUS_1" TO dev_external;


--
-- Name: TABLE "RUS_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RUS_2" TO dev_external;


--
-- Name: TABLE "RUS_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RUS_3" TO dev_external;


--
-- Name: TABLE "RWA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_0" TO dev_external;


--
-- Name: TABLE "RWA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_1" TO dev_external;


--
-- Name: TABLE "RWA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_2" TO dev_external;


--
-- Name: TABLE "RWA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_3" TO dev_external;


--
-- Name: TABLE "RWA_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_4" TO dev_external;


--
-- Name: TABLE "RWA_5"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."RWA_5" TO dev_external;


--
-- Name: TABLE "SAU_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SAU_0" TO dev_external;


--
-- Name: TABLE "SAU_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SAU_1" TO dev_external;


--
-- Name: TABLE "SDN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SDN_0" TO dev_external;


--
-- Name: TABLE "SDN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SDN_1" TO dev_external;


--
-- Name: TABLE "SDN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SDN_2" TO dev_external;


--
-- Name: TABLE "SDN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SDN_3" TO dev_external;


--
-- Name: TABLE "SEN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SEN_0" TO dev_external;


--
-- Name: TABLE "SEN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SEN_1" TO dev_external;


--
-- Name: TABLE "SEN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SEN_2" TO dev_external;


--
-- Name: TABLE "SEN_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SEN_3" TO dev_external;


--
-- Name: TABLE "SEN_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SEN_4" TO dev_external;


--
-- Name: TABLE "SGP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SGP_0" TO dev_external;


--
-- Name: TABLE "SGP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SGP_1" TO dev_external;


--
-- Name: TABLE "SGS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SGS_0" TO dev_external;


--
-- Name: TABLE "SHN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SHN_0" TO dev_external;


--
-- Name: TABLE "SHN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SHN_1" TO dev_external;


--
-- Name: TABLE "SHN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SHN_2" TO dev_external;


--
-- Name: TABLE "SJM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SJM_0" TO dev_external;


--
-- Name: TABLE "SJM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SJM_1" TO dev_external;


--
-- Name: TABLE "SLB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLB_0" TO dev_external;


--
-- Name: TABLE "SLB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLB_1" TO dev_external;


--
-- Name: TABLE "SLB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLB_2" TO dev_external;


--
-- Name: TABLE "SLE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLE_0" TO dev_external;


--
-- Name: TABLE "SLE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLE_1" TO dev_external;


--
-- Name: TABLE "SLE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLE_2" TO dev_external;


--
-- Name: TABLE "SLE_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLE_3" TO dev_external;


--
-- Name: TABLE "SLV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLV_0" TO dev_external;


--
-- Name: TABLE "SLV_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLV_1" TO dev_external;


--
-- Name: TABLE "SLV_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SLV_2" TO dev_external;


--
-- Name: TABLE "SMR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SMR_0" TO dev_external;


--
-- Name: TABLE "SMR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SMR_1" TO dev_external;


--
-- Name: TABLE "SOM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SOM_0" TO dev_external;


--
-- Name: TABLE "SOM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SOM_1" TO dev_external;


--
-- Name: TABLE "SOM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SOM_2" TO dev_external;


--
-- Name: TABLE "SPM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SPM_0" TO dev_external;


--
-- Name: TABLE "SPM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SPM_1" TO dev_external;


--
-- Name: TABLE "SRB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SRB_0" TO dev_external;


--
-- Name: TABLE "SRB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SRB_1" TO dev_external;


--
-- Name: TABLE "SRB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SRB_2" TO dev_external;


--
-- Name: TABLE "STP_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."STP_0" TO dev_external;


--
-- Name: TABLE "STP_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."STP_1" TO dev_external;


--
-- Name: TABLE "STP_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."STP_2" TO dev_external;


--
-- Name: TABLE "SUR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SUR_0" TO dev_external;


--
-- Name: TABLE "SUR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SUR_1" TO dev_external;


--
-- Name: TABLE "SUR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SUR_2" TO dev_external;


--
-- Name: TABLE "SVK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVK_0" TO dev_external;


--
-- Name: TABLE "SVK_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVK_1" TO dev_external;


--
-- Name: TABLE "SVK_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVK_2" TO dev_external;


--
-- Name: TABLE "SVN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVN_0" TO dev_external;


--
-- Name: TABLE "SVN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVN_1" TO dev_external;


--
-- Name: TABLE "SVN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SVN_2" TO dev_external;


--
-- Name: TABLE "SWE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWE_0" TO dev_external;


--
-- Name: TABLE "SWE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWE_1" TO dev_external;


--
-- Name: TABLE "SWE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWE_2" TO dev_external;


--
-- Name: TABLE "SWZ_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWZ_0" TO dev_external;


--
-- Name: TABLE "SWZ_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWZ_1" TO dev_external;


--
-- Name: TABLE "SWZ_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SWZ_2" TO dev_external;


--
-- Name: TABLE "SYC_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SYC_0" TO dev_external;


--
-- Name: TABLE "SYC_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SYC_1" TO dev_external;


--
-- Name: TABLE "SYR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SYR_0" TO dev_external;


--
-- Name: TABLE "SYR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SYR_1" TO dev_external;


--
-- Name: TABLE "SYR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."SYR_2" TO dev_external;


--
-- Name: TABLE "TCA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCA_0" TO dev_external;


--
-- Name: TABLE "TCA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCA_1" TO dev_external;


--
-- Name: TABLE "TCD_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCD_0" TO dev_external;


--
-- Name: TABLE "TCD_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCD_1" TO dev_external;


--
-- Name: TABLE "TCD_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCD_2" TO dev_external;


--
-- Name: TABLE "TCD_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TCD_3" TO dev_external;


--
-- Name: TABLE "TGO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TGO_0" TO dev_external;


--
-- Name: TABLE "TGO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TGO_1" TO dev_external;


--
-- Name: TABLE "TGO_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TGO_2" TO dev_external;


--
-- Name: TABLE "THA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."THA_0" TO dev_external;


--
-- Name: TABLE "THA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."THA_1" TO dev_external;


--
-- Name: TABLE "THA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."THA_2" TO dev_external;


--
-- Name: TABLE "THA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."THA_3" TO dev_external;


--
-- Name: TABLE "TJK_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TJK_0" TO dev_external;


--
-- Name: TABLE "TJK_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TJK_1" TO dev_external;


--
-- Name: TABLE "TJK_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TJK_2" TO dev_external;


--
-- Name: TABLE "TJK_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TJK_3" TO dev_external;


--
-- Name: TABLE "TKL_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TKL_0" TO dev_external;


--
-- Name: TABLE "TKL_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TKL_1" TO dev_external;


--
-- Name: TABLE "TKM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TKM_0" TO dev_external;


--
-- Name: TABLE "TKM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TKM_1" TO dev_external;


--
-- Name: TABLE "TLS_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TLS_0" TO dev_external;


--
-- Name: TABLE "TLS_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TLS_1" TO dev_external;


--
-- Name: TABLE "TLS_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TLS_2" TO dev_external;


--
-- Name: TABLE "TLS_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TLS_3" TO dev_external;


--
-- Name: TABLE "TON_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TON_0" TO dev_external;


--
-- Name: TABLE "TON_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TON_1" TO dev_external;


--
-- Name: TABLE "TTO_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TTO_0" TO dev_external;


--
-- Name: TABLE "TTO_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TTO_1" TO dev_external;


--
-- Name: TABLE "TUN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUN_0" TO dev_external;


--
-- Name: TABLE "TUN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUN_1" TO dev_external;


--
-- Name: TABLE "TUN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUN_2" TO dev_external;


--
-- Name: TABLE "TUR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUR_0" TO dev_external;


--
-- Name: TABLE "TUR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUR_1" TO dev_external;


--
-- Name: TABLE "TUR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUR_2" TO dev_external;


--
-- Name: TABLE "TUV_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUV_0" TO dev_external;


--
-- Name: TABLE "TUV_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TUV_1" TO dev_external;


--
-- Name: TABLE "TWN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TWN_0" TO dev_external;


--
-- Name: TABLE "TWN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TWN_1" TO dev_external;


--
-- Name: TABLE "TWN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TWN_2" TO dev_external;


--
-- Name: TABLE "TZA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TZA_0" TO dev_external;


--
-- Name: TABLE "TZA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TZA_1" TO dev_external;


--
-- Name: TABLE "TZA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TZA_2" TO dev_external;


--
-- Name: TABLE "TZA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."TZA_3" TO dev_external;


--
-- Name: TABLE "UGA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UGA_0" TO dev_external;


--
-- Name: TABLE "UGA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UGA_1" TO dev_external;


--
-- Name: TABLE "UGA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UGA_2" TO dev_external;


--
-- Name: TABLE "UGA_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UGA_3" TO dev_external;


--
-- Name: TABLE "UGA_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UGA_4" TO dev_external;


--
-- Name: TABLE "UKR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UKR_0" TO dev_external;


--
-- Name: TABLE "UKR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UKR_1" TO dev_external;


--
-- Name: TABLE "UKR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UKR_2" TO dev_external;


--
-- Name: TABLE "UMI_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UMI_0" TO dev_external;


--
-- Name: TABLE "UMI_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UMI_1" TO dev_external;


--
-- Name: TABLE "URY_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."URY_0" TO dev_external;


--
-- Name: TABLE "URY_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."URY_1" TO dev_external;


--
-- Name: TABLE "URY_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."URY_2" TO dev_external;


--
-- Name: TABLE "USA_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."USA_0" TO dev_external;


--
-- Name: TABLE "USA_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."USA_1" TO dev_external;


--
-- Name: TABLE "USA_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."USA_2" TO dev_external;


--
-- Name: TABLE "UZB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UZB_0" TO dev_external;


--
-- Name: TABLE "UZB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UZB_1" TO dev_external;


--
-- Name: TABLE "UZB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."UZB_2" TO dev_external;


--
-- Name: TABLE "VAT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VAT_0" TO dev_external;


--
-- Name: TABLE "VCT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VCT_0" TO dev_external;


--
-- Name: TABLE "VCT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VCT_1" TO dev_external;


--
-- Name: TABLE "VEN_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VEN_0" TO dev_external;


--
-- Name: TABLE "VEN_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VEN_1" TO dev_external;


--
-- Name: TABLE "VEN_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VEN_2" TO dev_external;


--
-- Name: TABLE "VGB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VGB_0" TO dev_external;


--
-- Name: TABLE "VGB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VGB_1" TO dev_external;


--
-- Name: TABLE "VIR_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VIR_0" TO dev_external;


--
-- Name: TABLE "VIR_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VIR_1" TO dev_external;


--
-- Name: TABLE "VIR_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VIR_2" TO dev_external;


--
-- Name: TABLE "VNM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VNM_0" TO dev_external;


--
-- Name: TABLE "VNM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VNM_1" TO dev_external;


--
-- Name: TABLE "VNM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VNM_2" TO dev_external;


--
-- Name: TABLE "VNM_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VNM_3" TO dev_external;


--
-- Name: TABLE "VUT_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VUT_0" TO dev_external;


--
-- Name: TABLE "VUT_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VUT_1" TO dev_external;


--
-- Name: TABLE "VUT_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."VUT_2" TO dev_external;


--
-- Name: TABLE "WLF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WLF_0" TO dev_external;


--
-- Name: TABLE "WLF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WLF_1" TO dev_external;


--
-- Name: TABLE "WLF_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WLF_2" TO dev_external;


--
-- Name: TABLE "WSM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WSM_0" TO dev_external;


--
-- Name: TABLE "WSM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WSM_1" TO dev_external;


--
-- Name: TABLE "WSM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."WSM_2" TO dev_external;


--
-- Name: TABLE "YEM_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."YEM_0" TO dev_external;


--
-- Name: TABLE "YEM_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."YEM_1" TO dev_external;


--
-- Name: TABLE "YEM_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."YEM_2" TO dev_external;


--
-- Name: TABLE "ZAF_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZAF_0" TO dev_external;


--
-- Name: TABLE "ZAF_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZAF_1" TO dev_external;


--
-- Name: TABLE "ZAF_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZAF_2" TO dev_external;


--
-- Name: TABLE "ZAF_3"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZAF_3" TO dev_external;


--
-- Name: TABLE "ZAF_4"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZAF_4" TO dev_external;


--
-- Name: TABLE "ZMB_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZMB_0" TO dev_external;


--
-- Name: TABLE "ZMB_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZMB_1" TO dev_external;


--
-- Name: TABLE "ZMB_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZMB_2" TO dev_external;


--
-- Name: TABLE "ZWE_0"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZWE_0" TO dev_external;


--
-- Name: TABLE "ZWE_1"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZWE_1" TO dev_external;


--
-- Name: TABLE "ZWE_2"; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public."ZWE_2" TO dev_external;


--
-- Name: TABLE gadm36; Type: ACL; Schema: public; Owner: dev_epigraph
--

GRANT SELECT ON TABLE public.gadm36 TO dev_admin;
GRANT SELECT ON TABLE public.gadm36 TO dev_external;


--
-- Name: TABLE geography_columns; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.geography_columns TO dev_external;


--
-- Name: TABLE geometry_columns; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.geometry_columns TO dev_external;


--
-- Name: TABLE iso_alpha3_country_codes; Type: ACL; Schema: public; Owner: dev_admin
--

GRANT SELECT ON TABLE public.iso_alpha3_country_codes TO dev_external;


--
-- Name: TABLE raster_columns; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.raster_columns TO dev_external;

--
-- Name: TABLE raster_overviews; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.raster_overviews TO dev_external;


--
-- Name: TABLE spatial_ref_sys; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.spatial_ref_sys TO dev_external;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: switzerland; Owner: dev_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin IN SCHEMA switzerland GRANT ALL ON SEQUENCES  TO dev_epigraph;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: switzerland; Owner: dev_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin IN SCHEMA switzerland GRANT ALL ON TYPES  TO dev_epigraph;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: switzerland; Owner: dev_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin IN SCHEMA switzerland GRANT ALL ON FUNCTIONS  TO dev_epigraph;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: switzerland; Owner: dev_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin IN SCHEMA switzerland GRANT ALL ON TABLES  TO dev_epigraph;
ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin IN SCHEMA switzerland GRANT ALL ON TABLES  TO dev_epigraph;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: dev_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE dev_admin GRANT ALL ON TABLES  TO dev_epigraph;


--
-- PostgreSQL database dump complete
--
