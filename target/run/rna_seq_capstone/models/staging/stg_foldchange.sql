
  create view "nf_da_onl_en_200726"."s_imrankhan"."stg_foldchange__dbt_tmp"
    
    
  as (
    

with cleaned as (
    select
        "Gene_ID",
        "fc_wt_nPvsP",
        "padj_wt_nPvsP",
        "fc_pdr2_nPvsP",
        "padj_pdr2_nPvsP",
        "fc_l1l2_nPvsP",
        "padj_l1l2_nPvsP",
        row_number() over (partition by "Gene_ID" order by "Gene_ID") as rn
    from "nf_da_onl_en_200726"."s_imrankhan"."foldchange_raw"
)

select
    "Gene_ID"::text as gene_id,
    "fc_wt_nPvsP"::float as fc_wt_nPvsP,
    "padj_wt_nPvsP"::float as padj_wt_nPvsP,
    "fc_pdr2_nPvsP"::float as fc_pdr2_nPvsP,
    "padj_pdr2_nPvsP"::float as padj_pdr2_nPvsP,
    "fc_l1l2_nPvsP"::float as fc_l1l2_nPvsP,
    "padj_l1l2_nPvsP"::float as padj_l1l2_nPvsP
from cleaned
where rn = 1
  );