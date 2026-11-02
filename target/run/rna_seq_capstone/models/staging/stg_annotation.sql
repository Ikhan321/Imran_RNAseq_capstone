
  create view "nf_da_onl_en_200726"."s_imrankhan"."stg_annotation__dbt_tmp"
    
    
  as (
    select DISTINCT
    "Gene_ID" as gene_id,
    "gene_name" as gene_name,
    "gene_description" as gene_description
from "nf_da_onl_en_200726"."s_imrankhan"."annotation_raw"
  );