
  
    

  create  table "nf_da_onl_en_200726"."s_imrankhan"."mart_deg_union__dbt_tmp"
  
  
    as
  
  (
    with l1l2_down as (
    select
        "Gene_ID" as gene_id,
        gene_name,
        gene_description
    from "nf_da_onl_en_200726"."s_imrankhan"."l1l2_downregulated_raw"
),
l1l2_up as (
    select
        "Gene_ID" as gene_id,
        gene_name,
        gene_description
    from "nf_da_onl_en_200726"."s_imrankhan"."l1l2_upregulated_raw"
)

select * from l1l2_down
union all
select * from l1l2_up
  );
  