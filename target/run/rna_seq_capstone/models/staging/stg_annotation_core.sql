
  create view "nf_da_onl_en_200726"."s_imrankhan"."stg_annotation_core__dbt_tmp"
    
    
  as (
    WITH cleaned AS (

    SELECT
        CASE
            WHEN LOWER(BTRIM("Gene_ID"::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM("Gene_ID"::text)
        END AS gene_id,

        CASE
            WHEN LOWER(BTRIM(gene_name::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(gene_name::text)
        END AS gene_name,

        CASE
            WHEN LOWER(BTRIM(gene_description::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(gene_description::text)
        END AS gene_description,

        CASE
            WHEN LOWER(BTRIM(tf_family::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(tf_family::text)
        END AS tf_family,

        CASE
            WHEN LOWER(BTRIM(gene_biotype::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM(gene_biotype::text)
        END AS gene_biotype,

        CASE
            WHEN LOWER(BTRIM("KOG Description"::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM("KOG Description"::text)
        END AS kog_description,

        CASE
            WHEN LOWER(BTRIM("KOG ID"::text))
                 IN ('', '.', 'na', 'n/a', 'null', 'none', '-')
                THEN NULL
            ELSE BTRIM("KOG ID"::text)
        END AS kog_id

    FROM "nf_da_onl_en_200726"."s_imrankhan"."annotation_core_raw"

)

SELECT
    gene_id,
    STRING_AGG(DISTINCT gene_name, ' | ' ORDER BY gene_name) AS gene_name,
    STRING_AGG(DISTINCT gene_description, ' | ' ORDER BY gene_description)
        AS gene_description,
    STRING_AGG(DISTINCT tf_family, ' | ' ORDER BY tf_family) AS tf_family,
    STRING_AGG(DISTINCT gene_biotype, ' | ' ORDER BY gene_biotype)
        AS gene_biotype,
    STRING_AGG(DISTINCT kog_description, ' | ' ORDER BY kog_description)
        AS kog_description,
    STRING_AGG(DISTINCT kog_id, ' | ' ORDER BY kog_id) AS kog_id
FROM cleaned
WHERE gene_id IS NOT NULL
GROUP BY gene_id
  );