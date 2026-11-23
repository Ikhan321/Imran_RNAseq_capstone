{{ config(materialized='view') }}

with cleaned as (
    select
        trim("Gene_ID")::text as gene_id,
        trim("gene_name")::text as gene_name,
        trim("condition")::text as condition,
        "expression"::float as expression_value
    from {{ source('raw', 'expression_raw') }}
    where trim("Gene_ID") <> ''
      and trim("Gene_ID") <> '.'
      and "expression" is not null
      and trim("condition") <> ''          -- <— NEW
      and "condition" is not null          -- <— NEW
),

dedup as (
    select
        gene_id,
        gene_name,
        condition,
        avg(expression_value) as expression_value,
        row_number() over (
            partition by gene_id, condition
            order by gene_id, condition
        ) as rn
    from cleaned
    group by gene_id, gene_name, condition
)

select
    gene_id,
    gene_name,
    condition,
    expression_value
from dedup
where rn = 1
