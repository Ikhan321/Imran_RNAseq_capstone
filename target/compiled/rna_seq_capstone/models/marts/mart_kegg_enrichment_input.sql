

WITH gene_stats AS (

    -- Collapse the expression-level mart to one row per gene and comparison.
    SELECT DISTINCT
        gene_id,
        fc_wt_npvsp,
        padj_wt_npvsp,
        fc_pdr2_npvsp,
        padj_pdr2_npvsp
    FROM "nf_da_onl_en_200726"."s_imrankhan"."mart_full_join_v2"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'

),

comparisons AS (

    SELECT
        gene_id,
        'WT' AS genotype,
        fc_wt_npvsp AS log2_fold_change,
        padj_wt_npvsp AS padj
    FROM gene_stats

    UNION ALL

    SELECT
        gene_id,
        'PDR2' AS genotype,
        fc_pdr2_npvsp AS log2_fold_change,
        padj_pdr2_npvsp AS padj
    FROM gene_stats

),

pathways AS (

    SELECT DISTINCT
        gene_id,
        COALESCE(
            NULLIF(BTRIM(kegg_pathway_id::text), ''),
            'NAME:' || LOWER(BTRIM(kegg_pathway_name::text))
        ) AS pathway_key,
        kegg_pathway_id,
        kegg_pathway_name
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_annotation_pathway"
    WHERE gene_id IS NOT NULL
      AND (
          kegg_pathway_id IS NOT NULL
          OR kegg_pathway_name IS NOT NULL
      )

),

eligible_genes AS (

    -- The background consists of tested genes with a usable fold change.
    SELECT
        genotype,
        gene_id,
        log2_fold_change,
        padj,
        CASE
            WHEN padj < 0.05 AND log2_fold_change >= 1
                THEN 'Up in nP'
            WHEN padj < 0.05 AND log2_fold_change <= -1
                THEN 'Down in nP'
            ELSE 'Not DEG'
        END AS response_class
    FROM comparisons
    WHERE padj IS NOT NULL
      AND log2_fold_change IS NOT NULL

)

SELECT DISTINCT
    e.genotype,
    e.gene_id,
    e.log2_fold_change,
    e.padj,
    e.response_class,
    p.pathway_key,
    p.kegg_pathway_id,
    p.kegg_pathway_name
FROM eligible_genes AS e
INNER JOIN pathways AS p
    ON e.gene_id = p.gene_id