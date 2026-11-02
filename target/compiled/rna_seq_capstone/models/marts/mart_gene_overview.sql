with ann as (
    select * from "nf_da_onl_en_200726"."s_imrankhan"."stg_annotation"
),
expr as (
    select * from "nf_da_onl_en_200726"."s_imrankhan"."mart_expression_summary"
),
fc as (
    select * from "nf_da_onl_en_200726"."s_imrankhan"."mart_foldchange_summary"
)

select
    ann.gene_id,
    ann.gene_name,
    ann.gene_description,

    expr.WT_P,
    expr.WT_nP,
    expr.PDR2_P,
    expr.PDR2_nP,
    expr.l1l2_P,
    expr.l1l2_nP,

    fc.fc_wt_nPvsP,
    fc.padj_wt_nPvsP,
    fc.fc_pdr2_nPvsP,
    fc.padj_pdr2_nPvsP,
    fc.fc_l1l2_nPvsP,
    fc.padj_l1l2_nPvsP

from ann
left join expr using (gene_id)
left join fc using (gene_id)