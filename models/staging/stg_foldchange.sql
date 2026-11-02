select DISTINCT
   
    foldchange_raw."Gene_ID" as gene_id,
    foldchange_raw."fc_wt_nPvsP" as fc_wt_nPvsP,
    foldchange_raw."padj_wt_nPvsP" as padj_wt_nPvsP,
    foldchange_raw."fc_pdr2_nPvsP" as fc_pdr2_nPvsP,
    foldchange_raw."padj_pdr2_nPvsP" as padj_pdr2_nPvsP,
    foldchange_raw."fc_l1l2_nPvsP" as fc_l1l2_nPvsP,
    foldchange_raw."padj_l1l2_nPvsP" as padj_l1l2_nPvsP
from {{ ref('foldchange_raw') }}

