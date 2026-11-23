{{ config(materialized='view') }}

with annotation as (
    select *
    from {{ ref('stg_annotation') }}
),

expression as (
    select *
    from {{ ref('stg_expression') }}
),

foldchange as (
    select *
    from {{ ref('stg_foldchange') }}
),

l1l2_down as (
    select gene_id
    from {{ ref('stg_l1l2_downregulated') }}
),

l1l2_up as (
    select gene_id
    from {{ ref('stg_l1l2_upregulated') }}
),

pdr2_down as (
    select gene_id
    from {{ ref('stg_pdr2_downregulated') }}
),

pdr2_up as (
    select gene_id
    from {{ ref('stg_pdr2_upregulated') }}
),

wt_down as (
    select gene_id
    from {{ ref('stg_wt_downregulated') }}
),

wt_up as (
    select gene_id
    from {{ ref('stg_wt_upregulated') }}
)

select
    f.gene_id as gene_id,

    coalesce(a.gene_name, e.gene_name) as gene_name,
    a.gene_description,
    a.tf_family,
    a.gene_biotype,
    a.kegg_pathway_name,
    a.kog_description,
    a.range_value,
    a.range_percent,
    a.sum_value,
    a.average_value,
    a.express_value,

    -- Expression can have multiple condition rows for each gene.
    e.condition,
    e.expression_value,

    -- Processed fold-change results
    f.fc_wt_nPvsP,
    f.padj_wt_nPvsP,
    f.fc_pdr2_nPvsP,
    f.padj_pdr2_nPvsP,
    f.fc_l1l2_nPvsP,
    f.padj_l1l2_nPvsP,

    -- Existing flag fields
    case when l1l2_down.gene_id is not null then true else false end
        as l1l2_downregulated,
    case when l1l2_up.gene_id is not null then true else false end
        as l1l2_upregulated,

    case when pdr2_down.gene_id is not null then true else false end
        as pdr2_downregulated,
    case when pdr2_up.gene_id is not null then true else false end
        as pdr2_upregulated,

    case when wt_down.gene_id is not null then true else false end
        as wt_downregulated,
    case when wt_up.gene_id is not null then true else false end
        as wt_upregulated

from foldchange f
left join annotation a
    on f.gene_id = a.gene_id
left join expression e
    on f.gene_id = e.gene_id
left join l1l2_down
    on f.gene_id = l1l2_down.gene_id
left join l1l2_up
    on f.gene_id = l1l2_up.gene_id
left join pdr2_down
    on f.gene_id = pdr2_down.gene_id
left join pdr2_up
    on f.gene_id = pdr2_up.gene_id
left join wt_down
    on f.gene_id = wt_down.gene_id
left join wt_up
    on f.gene_id = wt_up.gene_id