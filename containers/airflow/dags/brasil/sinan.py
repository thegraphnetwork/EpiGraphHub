import shutil
import pendulum
import logging as logger

from glob import glob
from pathlib import Path
from datetime import timedelta

from airflow import DAG
from airflow.decorators import task
from airflow.operators.empty import EmptyOperator

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data._config import PYSUS_DATA_PATH
from epigraphhub.data.brasil.sinan import extract, loading


ENG = get_engine(credential_name=env.db.default_credential)
SCHEMA = 'brasil'
DISEASES = extract.diseases
DEFAULT_ARGS = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=2),
}


def task_flow_for(disease: str):
    def _count_table_rows(engine, table: str) -> int:
        """ 
        Counts table rows from brasil's Schema
        """
        with engine.connect() as conn:
            try:
                cur = conn.execute(f"SELECT COUNT(*) FROM {SCHEMA}.{table}")
                rowcount = cur.fetchone()[0]
            except Exception as e:
                if 'UndefinedTable' in str(e):
                    return 0
                else:
                    raise e
        return rowcount

    @task(task_id='start')
    def start(disease: str) -> int:
        logger.info(f'ETL started for {disease}')
        return _count_table_rows(ENG, DISEASES[disease].lower())

    @task(task_id='extract', retries=3)
    def download(disease: str) -> list:
        extract.download(disease)
        logger.info(f"Data for {disease} extracted")
        parquet_dirs = glob(f'{Path(PYSUS_DATA_PATH)/DISEASES[disease]}*')
        return parquet_dirs

    @task(task_id='upload')
    def upload(**kwargs) -> None:
        ti = kwargs['ti']
        parquet_dirs = ti.xcom_pull(task_ids='extract')
        try:
            loading.upload(parquet_dirs)
        except Exception as e:
            logger.error(e)
            raise e

    @task(task_id='diagnosis')
    def compare_tables_rows(disease: str, **kwargs) -> int:
        ti = kwargs['ti']
        ini_rows_amt = ti.xcom_pull(task_ids='start')
        end_rows_amt = _count_table_rows(ENG, DISEASES[disease].lower())
        
        new_rows = end_rows_amt - ini_rows_amt

        logger.info(
            f'{new_rows} new rows inserted into brasil.{disease}'
        )

        return new_rows

    @task(trigger_rule='all_done')
    def remove_parquets(**kwargs) -> None:
        ti = kwargs['ti']
        parquet_dirs = ti.xcom_pull(task_ids='extract')
        
        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f'{dir} removed')

    done = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    ini = start(disease)
    E = download(disease)
    L = upload()
    diagnosis = compare_tables_rows(disease)
    clean = remove_parquets()
    end = done

    ini >> E >> L >> diagnosis >> clean >> end


with DAG(
    dag_id=DISEASES['Animais Peçonhentos'], 
    default_args=DEFAULT_ARGS,
    tags=['Animais Peçonhentos', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 1),
    catchup=False,
    schedule_interval='@monthly',
) as ANIM:
    task_flow_for('Animais Peçonhentos')

with DAG(
    dag_id=DISEASES['Cancer'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Cancer', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 2),
    catchup=False,
) as CANC:
    task_flow_for('Cancer')

with DAG(
    dag_id=DISEASES['Botulismo'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Botulismo', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 3),
    catchup=False,
) as BOTU:
    task_flow_for('Botulismo')

with DAG(
    dag_id=DISEASES['Chagas'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Chagas', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 4),
    catchup=False,
) as CHAG:
    task_flow_for('Chagas')

with DAG(
    dag_id=DISEASES['Chikungunya'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Chikungunya', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 5),
    catchup=False,
) as CHIK:
    task_flow_for('Chikungunya')    

with DAG(
    dag_id=DISEASES['Colera'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Colera', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 6),
    catchup=False,
) as COLE:
    task_flow_for('Colera')    

with DAG(
    dag_id=DISEASES['Coqueluche'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Coqueluche', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 7),
    catchup=False,
) as COQU:
    task_flow_for('Coqueluche') 

with DAG(
    dag_id=DISEASES['Contact Communicable Disease'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Contact Communicable Disease', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 8),
    catchup=False,
) as ACBI:
    task_flow_for('Contact Communicable Disease') 

with DAG(
    dag_id=DISEASES['Acidentes de Trabalho'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Acidentes de Trabalho', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 9),
    catchup=False,
) as ACGR:
    task_flow_for('Acidentes de Trabalho') 

with DAG(
    dag_id=DISEASES['Dengue'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Dengue', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 10),
    catchup=False,
) as DENG:
    task_flow_for('Dengue') 

with DAG(
    dag_id=DISEASES['Difteria'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Difteria', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 11),
    catchup=False,
) as DIFT:
    task_flow_for('Difteria') 

with DAG(
    dag_id=DISEASES['Esquistossomose'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Esquistossomose', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 12),
    catchup=False,
) as ESQU:
    task_flow_for('Esquistossomose') 
 
with DAG(
    dag_id=DISEASES['Febre Amarela'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Febre Amarela', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 13),
    catchup=False,
) as FAMA:
    task_flow_for('Febre Amarela')    
                 
with DAG(
    dag_id=DISEASES['Febre Maculosa'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Febre Maculosa', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 14),
    catchup=False,
) as FMAC:
    task_flow_for('Febre Maculosa')    
                 
with DAG(
    dag_id=DISEASES['Febre Tifoide'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Febre Tifoide', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 15),
    catchup=False,
) as FTIF:
    task_flow_for('Febre Tifoide')    
        
with DAG(
    dag_id=DISEASES['Hanseniase'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Hanseniase', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 16),
    catchup=False,
) as HANS:
    task_flow_for('Hanseniase')    
         
with DAG(
    dag_id=DISEASES['Hantavirose'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Hantavirose', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 17),
    catchup=False,
) as HANT:
    task_flow_for('Hantavirose')    
         
with DAG(
    dag_id=DISEASES['Hepatites Virais'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Hepatites Virais', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 18),
    catchup=False,
) as HEPA:
    task_flow_for('Hepatites Virais')    
         
with DAG(
    dag_id=DISEASES['Intoxicação Exógena'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Intoxicação Exógena', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 19),
    catchup=False,
) as IEXO:
    task_flow_for('Intoxicação Exógena')    
         
with DAG(
    dag_id=DISEASES['Leishmaniose Visceral'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Leishmaniose Visceral', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 20),
    catchup=False,
) as LEIV:
    task_flow_for('Leishmaniose Visceral')    
        
with DAG(
    dag_id=DISEASES['Leptospirose'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Leptospirose', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 21),
    catchup=False,
) as LEPT:
    task_flow_for('Leptospirose')    
        
with DAG(
    dag_id=DISEASES['Leishmaniose Tegumentar'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Leishmaniose Tegumentar', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 22),
    catchup=False,
) as LTAN:
    task_flow_for('Leishmaniose Tegumentar')    
        
with DAG(
    dag_id=DISEASES['Malaria'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Malaria', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 23),
    catchup=False,
) as MALA:
    task_flow_for('Malaria')    
        
with DAG(
    dag_id=DISEASES['Meningite'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Meningite', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 24),
    catchup=False,
) as MENI:
    task_flow_for('Meningite')    
         
with DAG(
    dag_id=DISEASES['Peste'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Peste', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 25),
    catchup=False,
) as PEST:
    task_flow_for('Peste')    
         
with DAG(
    dag_id=DISEASES['Poliomielite'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Poliomielite', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 26),
    catchup=False,
) as PFAN:
    task_flow_for('Poliomielite')    
        
with DAG(
    dag_id=DISEASES['Raiva Humana'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Raiva Humana', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 27),
    catchup=False,
) as RAIV:
    task_flow_for('Raiva Humana')    
        
with DAG(
    dag_id=DISEASES['Sífilis Adquirida'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Sífilis Adquirida', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 1),
    catchup=False,
) as SIFA:
    task_flow_for('Sífilis Adquirida')    
         
with DAG(
    dag_id=DISEASES['Sífilis Congênita'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Sífilis Congênita', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 2),
    catchup=False,
) as SIFC:
    task_flow_for('Sífilis Congênita')    
        
with DAG(
    dag_id=DISEASES['Sífilis em Gestante'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Sífilis em Gestante', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 3),
    catchup=False,
) as SIFG:
    task_flow_for('Sífilis em Gestante')    
        
with DAG(
    dag_id=DISEASES['Tétano Acidental'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Tétano Acidental', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 4),
    catchup=False,
) as TETA:
    task_flow_for('Tétano Acidental')    
         
with DAG(
    dag_id=DISEASES['Tétano Neonatal'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Tétano Neonatal', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 5),
    catchup=False,
) as TETN:
    task_flow_for('Tétano Neonatal')    
        
with DAG(
    dag_id=DISEASES['Tuberculose'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Tuberculose', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 6),
    catchup=False,
) as TUBE:
    task_flow_for('Tuberculose')    
         
with DAG(
    dag_id=DISEASES['Violência Domestica'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Violência Domestica', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 7),
    catchup=False,
) as VIOL:
    task_flow_for('Violência Domestica')    
        
with DAG(
    dag_id=DISEASES['Zika'], 
    schedule_interval='@monthly',
    default_args=DEFAULT_ARGS,
    tags=['Zika', 'SINAN'],
    start_date= pendulum.datetime(2022, 2, 8),
    catchup=False,
) as ZIKA:
    task_flow_for('Zika')    
        