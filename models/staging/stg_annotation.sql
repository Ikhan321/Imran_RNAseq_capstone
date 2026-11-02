select distinct
    "Gene_ID"              as gene_id,
    "gene_name"            as gene_name,
    "gene_description"     as gene_description,
    "tf_family"            as tf_family,
    "gene_biotype"         as gene_biotype,
    "kegg_pathway_name"    as kegg_pathway_name,
    "KOG Description"      as kog_description
from {{ ref('annotation_raw') }}

