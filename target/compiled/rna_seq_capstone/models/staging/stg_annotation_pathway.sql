WITH cleaned AS (

    SELECT
        CASE
            WHEN LOWER(BTRIM("Gene_ID"::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM("Gene_ID"::text)
        END AS gene_id,

        CASE
            WHEN LOWER(BTRIM(kegg_pathway_gene_id::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(kegg_pathway_gene_id::text)
        END AS kegg_pathway_gene_id,

        CASE
            WHEN LOWER(BTRIM(kegg_pathway_id::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(kegg_pathway_id::text)
        END AS kegg_pathway_id,

        CASE
            WHEN LOWER(BTRIM(kegg_pathway_name::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(kegg_pathway_name::text)
        END AS kegg_pathway_name

    FROM "nf_da_onl_en_200726"."s_imrankhan"."annotation_core_raw"

)

SELECT DISTINCT
    gene_id,
    kegg_pathway_gene_id,
    kegg_pathway_id,
    kegg_pathway_name
FROM cleaned
WHERE gene_id IS NOT NULL
  AND (
      kegg_pathway_gene_id IS NOT NULL
      OR kegg_pathway_id IS NOT NULL
      OR kegg_pathway_name IS NOT NULL
  )