with expr as (
    select distinct
        gene_id,
        gene_name,
        condition,
        expression
    from "nf_da_onl_en_200726"."s_imrankhan"."stg_expression"
),

pivoted as (
    select
        gene_id,
        gene_name,

        max(case when condition = 'WT_P' then expression end) as WT_P,
        max(case when condition = 'WT_nP' then expression end) as WT_nP,

        max(case when condition = 'pdr2_P' then expression end) as pdr2_P,
        max(case when condition = 'pdr2_nP' then expression end) as pdr2_nP,

        max(case when condition = 'l1l2_P' then expression end) as l1l2_P,
        max(case when condition = 'l1l2_nP' then expression end) as l1l2_nP,

        row_number() over (partition by gene_id order by gene_id) as rn
    from expr
    group by gene_id, gene_name
)

select *
from pivoted
where rn = 1