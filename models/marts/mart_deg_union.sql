with l1l2_down as (
    select
        "Gene_ID" as gene_id,
        gene_name,
        gene_description
    from {{ ref('l1l2_downregulated_raw') }}
),
l1l2_up as (
    select
        "Gene_ID" as gene_id,
        gene_name,
        gene_description
    from {{ ref('l1l2_upregulated_raw') }}
)

select * from l1l2_down
union all
select * from l1l2_up


