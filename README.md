# Ecommerce Analytics — DBT + Databricks Project

This project implements a complete Bronze → Silver → Gold data pipeline on Databricks using dbt (Data Build Tool).
It transforms raw ecommerce order data into a clean star-schema (dimensions & fact) ready for BI dashboards and analytics.

# Project Overview

This dbt project loads raw orders data from a Databricks Volume (Unity Catalog), cleans and enriches it, and builds:

    - ** Bronze Layer (Raw)**

Silver Layer (Cleaned & Modeled)

Gold Layer (Dimensional Warehouse)

The final output is:

dim_customers

dim_products

fact_orders (granular fact table with surrogate keys)

Optional future: dim_date, metrics layer, Superset dashboards