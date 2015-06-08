GEF Protected Area Database
===========================

# Installation

## Protected Planet Consumer

You should have already installed ProtectedPlanet Consumer following the [general guidelines](../README.md).

## .env File

The csv files that we need to run this project are on Amazon S3. In order to get them you will need to create a .env file in the project root with the AWS access keys. You can do it based on .env_example file.

## Build the Database

In order to create and populate the database using its seeds you can do the usual rails database setup:

```
rake db:setup
```

## Importing GEF Data

To import all the Data in csv that is coming from S3 you should run:

```
rake gef:import
```

# API

This project has a JSON API. You can use it search by GEF PMIS ID on:

```
http://#{host}/gef/api/areas?
```

You can use the following parameters:

* gef_pmis_id (GEF ID);
* primary_biome (Primary Biome);
* region (Region Name);
* iso3 (Country ISO 3 digit code);
* wdpa_id (WDPA ID);
* wdpa_name (WDPA Name).

Example:

```
http://#{host}/gef/api/area?gef/api/areas?gef_pmis_id=888999&primary_biome=Manbone+Biome&iso3=MBN&region=Manarctica&wdpa_id=999888
```


The API currently shows data from ProtectedPlanet (WDPA name, WDPA ID and url) ands from METT Assessments.

It consists in an array of assessments that meet the search parameters.
