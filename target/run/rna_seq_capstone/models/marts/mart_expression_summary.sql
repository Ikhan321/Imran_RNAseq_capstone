
  create view "nf_da_onl_en_200726"."s_imrankhan"."mart_expression_summary__dbt_tmp"
    
    
  as (
    

select
    e.gene_id,
    e.gene_name,
    e.condition,
    e.expression_value
from "nf_da_onl_en_200726"."s_imrankhan"."stg_expression" as e
  );