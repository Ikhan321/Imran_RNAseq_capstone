

WITH annotation AS (
    -- One row per valid gene, with placeholder values already cleaned.
    SELECT
        gene_id,
        gene_name,
        gene_description,
        tf_family,
        gene_biotype,
        kog_description,
        kog_id
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_annotation_core"
),

foldchange AS (
    -- This is the base: keep fold-change results for every valid gene.
    SELECT *
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_foldchange"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'
),

expression AS (
    SELECT
        gene_id,
        gene_name,
        condition,
        expression_value
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_expression"
),

pdr2_down AS (
    SELECT DISTINCT gene_id
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_pdr2_downregulated"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'
),

pdr2_up AS (
    SELECT DISTINCT gene_id
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_pdr2_upregulated"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'
),

wt_down AS (
    SELECT DISTINCT gene_id
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_wt_downregulated"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'
),

wt_up AS (
    SELECT DISTINCT gene_id
    FROM "nf_da_onl_en_200726"."s_imrankhan"."stg_wt_upregulated"
    WHERE gene_id IS NOT NULL
      AND NULLIF(BTRIM(gene_id::text), '') IS NOT NULL
      AND BTRIM(gene_id::text) <> '.'
)

SELECT
    f.gene_id,

    COALESCE(a.gene_name, e.gene_name) AS gene_name,
    a.gene_description,
    a.tf_family,
    a.gene_biotype,
    a.kog_description,
    a.kog_id,

    -- Expression has multiple conditions per gene.
    e.condition,
    e.expression_value,

    -- Fold-change and adjusted p-value results for WT and pdr2.
    f.fc_wt_nPvsP,
    f.padj_wt_nPvsP,
    f.fc_pdr2_nPvsP,
    f.padj_pdr2_nPvsP,

    -- Flags from the processed up/down gene lists.
    CASE WHEN pdr2_down.gene_id IS NOT NULL THEN TRUE ELSE FALSE END
        AS pdr2_downregulated,
    CASE WHEN pdr2_up.gene_id IS NOT NULL THEN TRUE ELSE FALSE END
        AS pdr2_upregulated,
    CASE WHEN wt_down.gene_id IS NOT NULL THEN TRUE ELSE FALSE END
        AS wt_downregulated,
    CASE WHEN wt_up.gene_id IS NOT NULL THEN TRUE ELSE FALSE END
        AS wt_upregulated

FROM foldchange AS f

LEFT JOIN annotation AS a
    ON f.gene_id = a.gene_id

LEFT JOIN expression AS e
    ON f.gene_id = e.gene_id

LEFT JOIN pdr2_down
    ON f.gene_id = pdr2_down.gene_id

LEFT JOIN pdr2_up
    ON f.gene_id = pdr2_up.gene_id

LEFT JOIN wt_down
    ON f.gene_id = wt_down.gene_id

LEFT JOIN wt_up
    ON f.gene_id = wt_up.gene_id