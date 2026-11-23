select distinct
    "Gene_ID"::text as gene_id,
    "gene_name"::text as gene_name,
    "gene_description"::text as gene_description
from "nf_da_onl_en_200726"."s_imrankhan"."wt_upregulated_raw"