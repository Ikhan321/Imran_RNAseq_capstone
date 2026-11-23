select distinct
    "Gene_ID"::text as gene_id,
    "gene_name"::text as gene_name,
    "gene_description"::text as gene_description
from {{ source('raw', 'wt_upregulated_raw') }}
