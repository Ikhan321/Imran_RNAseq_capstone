
  
    

  create  table "nf_da_onl_en_200726"."s_imrankhan"."mart_foldchange_summary__dbt_tmp"
  
  
    as
  
  (
    with fc as (
    select distinct
        gene_id,
        fc_wt_nPvsP,
        padj_wt_nPvsP,
        fc_pdr2_nPvsP,
        padj_pdr2_nPvsP,
        fc_l1l2_nPvsP,
        padj_l1l2_nPvsP
    from "nf_da_onl_en_200726"."s_imrankhan"."stg_foldchange"
),

dedup as (
    select *,
        row_number() over (partition by gene_id order by gene_id) as rn
    from fc
)

select *
from dedup
where rn = 1
  );
  