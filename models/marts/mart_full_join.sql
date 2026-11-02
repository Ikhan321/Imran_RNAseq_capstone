with ann as (
    select DISTINCT * from {{ ref('stg_annotation') }}
),
expr as (
    select DISTINCT * from {{ ref('mart_expression_summary') }}
),
fc as (
    select DISTINCT * from {{ ref('mart_foldchange_summary') }}
),
deg as (
    select DISTINCT gene_id from {{ ref('mart_deg_union') }}
)

select *
from (
    select
        ann.gene_id,
        ann.gene_name,
        ann.gene_description,
        ann.family,
        ann.gene_biotype,
        ann.kegg_pathway_name,
        ann.kog_description,

        expr.WT_P,
        expr.WT_nP,
        expr.PDR2_P,
        expr.PDR2_nP,
        expr.l1l2_P,
        expr.l1l2_nP,

        fc.fc_wt_nPvSP,
        fc.padj_wt_nPvSP,
        fc.fc_pdr2_nPvSP,
        fc.padj_pdr2_nPvSP,
        fc.fc_l1l2_nPvSP,
        fc.padj_l1l2_nPvSP,

        case when deg.gene_id is not null then 1 else 0 end as is_deg,

        row_number() over (partition by ann.gene_id order by ann.gene_id) as rn
    from ann
    left join expr using (gene_id)
    left join fc using (gene_id)
    left join deg using (gene_id)
)
where rn = 1
