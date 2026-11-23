
  create view "nf_da_onl_en_200726"."s_imrankhan"."mart_foldchange_summary__dbt_tmp"
    
    
  as (
    

select
    f.gene_id,
    f.fc_wt_nPvsP,
    f.padj_wt_nPvsP,
    f.fc_pdr2_nPvsP,
    f.padj_pdr2_nPvsP,
    f.fc_l1l2_nPvsP,
    f.padj_l1l2_nPvsP
from "nf_da_onl_en_200726"."s_imrankhan"."stg_foldchange" as f
  );