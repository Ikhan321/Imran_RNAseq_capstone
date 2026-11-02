select DISTINCT
    "Gene_ID" as gene_id,
    gene_name,
    condition,
    expression
from {{ ref('expression_raw') }}
