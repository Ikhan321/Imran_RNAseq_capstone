{{ config(materialized='view') }}

with cleaned as (
    select
        "Gene_ID",
        "gene_name",
        "gene_description",
        "tf_family",
        "gene_biotype",
        "kegg_pathway_name",
        "KOG Description",
        "range",
        "Range%",
        "sum",
        "Avrg",
        "express",
        row_number() over (partition by "Gene_ID" order by "Gene_ID") as rn
    from {{ source('raw', 'annotation_raw') }}
)

select
    "Gene_ID"::text as gene_id,
    "gene_name"::text as gene_name,
    "gene_description"::text as gene_description,
    "tf_family"::text as tf_family,
    "gene_biotype"::text as gene_biotype,
    "kegg_pathway_name"::text as kegg_pathway_name,
    "KOG Description"::text as kog_description,
    "range"::text as range_value,
    "Range%"::text as range_percent,
    "sum"::text as sum_value,
    "Avrg"::text as average_value,
    "express"::text as express_value
from cleaned
where rn = 1


