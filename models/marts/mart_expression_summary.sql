{{ config(materialized='view') }}

select
    e.gene_id,
    e.gene_name,
    e.condition,
    e.expression_value
from {{ ref('stg_expression') }} as e
