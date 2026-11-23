{{ config(materialized='view') }}

select
    f.gene_id,
    f.fc_wt_nPvsP,
    f.padj_wt_nPvsP,
    f.fc_pdr2_nPvsP,
    f.padj_pdr2_nPvsP,
    f.fc_l1l2_nPvsP,
    f.padj_l1l2_nPvsP
from {{ ref('stg_foldchange') }} as f
