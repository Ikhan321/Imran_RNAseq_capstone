
  create view "nf_da_onl_en_200726"."s_imrankhan"."stg_expression__dbt_tmp"
    
    
  as (
    select DISTINCT
    "Gene_ID" as gene_id,
    gene_name,
    condition,
    expression
from "nf_da_onl_en_200726"."s_imrankhan"."expression_raw"
  );