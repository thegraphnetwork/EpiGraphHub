# Overview of the EpiGraphHub Platform 

The EpigraphHub platform is composed by a Postgresql database server integrated with a customized Apache Superset web frontend for data access and exploration. 

## Database Server structure

Our database server is compised of three main databases as shown in the figure below, with different access priviledges. 

![server](../Documentation/images/db_access.png)

### *epigraphhub* database

The `epigraphhub` database contains exclusively public domain data, either generated internally by the project or integrated from other sources. It can be read by all users but only EpigraphHub analysts can write to it, creating or updating tables.

### *privatehub* database
The `privatehub` database is a database to which only EpigraphHub analysts can access. Writing privileges to specific schemas or tables are granted on a per project basis to maximize data security.

This database contains data made available to the Graph Network by partners through a specific usage agreement. 

Within this database data from different partners are kept on separate schemas in order to allow for optimal access control. 

### *sandbox* database
This database is to be used for testing and experimentation in database modeling. Any user has read and write privileges on it but no dataset is guaranteed to be persisted for long periods of time.

## Database roles

Access privileges are granted to database users through groups. Notice that this is only for direct database access. Access through EpiGraphHub's [web frontend](https://epigraphhub.org) is managed independently.

Two main database user groups have been created for this purpose:

* ***external:***
    group of users with read-only access to the epigraphhub database and full access to the sandbox. 
* ***hubbers:*** Group for analysts which are members of the Graph network and that have been cleared to access restricted datasets.
