**DATA DICTIONARY — RNAseq Capstone Project**


1. **Gene Annotation Columns**


| Column                                      | Description                              | Type    | Usage                             |
| ------------------------------------------- | ---------------------------------------- | ------- | --------------------------------- |
| **Gene_ID**                           | Unique gene identifier (e.g., AT1G01010) | string  | Key column for merging, filtering |
| **gene_name**                         | Short gene name (if available)           | string  | Display in dashboards             |
| **gene_description**                  | Functional description                   | string  | Biological interpretation         |
| **tf_family**                         | Transcription factor family              | string  | Optional grouping                 |
| **gene_biotype**                      | Gene type (protein-coding, etc.)         | string  | Filtering                         |
| **kegg_pathway_name**                 | KEGG pathway annotation                  | string  | Pathway dashboard                 |
| **KOG Description**                   | Functional category                      | string  | KOG dashboard                     |
| **range, Range%, sum, Avrg, express** | Precomputed summary stats                | numeric | Optional, not core to analysis    |


2. **Raw Expression Columns (FPKM)**

These are the **actual expression values** under +Pi (P) and –Pi (nP).

**WT**

| Column                      | Description                | Type  |
| --------------------------- | -------------------------- | ----- |
| **fpkm_WT_avg**       | WT expression under +Pi    | float |
| **fpkm_WT_stdeva**    | WT +Pi standard deviation  | float |
| **fpkm_WT_nP_avg**    | WT expression under –Pi   | float |
| **fpkm_WT_nP_stdeva** | WT –Pi standard deviation | float |

***pdr2***


| Column                        | Description                  | Type  |
| ----------------------------- | ---------------------------- | ----- |
| **fpkm_pdr2_P_avg**     | pdr2 expression under +Pi    | float |
| **fpkm_pdr2_P_stdeva**  | pdr2 +Pi standard deviation  | float |
| **fpkm_pdr2_nP_avg**    | pdr2 expression under –Pi   | float |
| **fpkm_pdr2_nP_stdeva** | pdr2 –Pi standard deviation | float |

**WT tissues (optional)**


| Column                  | Description         |
| ----------------------- | ------------------- |
| **fpkm_WT_S_avg** | WT shoot expression |
| **fpkm_WT_R_avg** | WT root expression  |


3. **Differential Expression Columns (log2 Fold Change)**

These are the  **core analysis columns** .

### **WT: –Pi vs +Pi**

| Column                                    | Description              |
| ----------------------------------------- | ------------------------ |
| **fpkm_WT_nPvsWT_P_log2foldchange** | WT fold change (nP vs P) |
| **fpkm_WT_nPvsWT_P_pvalue**         | WT p-value               |
| **fpkm_WT_nPvsWT_P_padjust**        | WT adjusted p-value      |

## ***pdr2*: –Pi vs +Pi**

| Column                                        | Description                |
| --------------------------------------------- | -------------------------- |
| **fpkm_pdr2_nPvspdr2_P_log2foldchange** | pdr2 fold change (nP vs P) |
| **fpkm_pdr2_nPvspdr2_P_pvalue**         | pdr2 p-value               |
| **fpkm_pdr2_nPvspdr2_P_padjust**        | pdr2 adjusted p-value      |

## *l1l2*: –Pi vs +Pi

| Column                                        | Description                |
| --------------------------------------------- | -------------------------- |
| **fpkm_l1l2_nPvsl1l2_P_log2foldchange** | l1l2 fold change (nP vs P) |
| **fpkm_l1l2_nPvsl1l2_P_pvalue**         | l1l2 p-value               |
| **fpkm_l1l2_nPvsl1l2_P_padjust**        | l1l2 adjusted p-value      |


4. **Genotype Comparison Columns**

**l1l2 vs WT**

| Column                                     | Description          |
| ------------------------------------------ | -------------------- |
| **fpkm_l1l2_PvsWT_P_log2foldchange** | l1l2 vs WT under +Pi |
| **fpkm_l1l2_PvsWT_P_pvalue**         | p-value              |
| **fpkm_l1l2_PvsWT_P_padjust**        | adjusted p-value     |

***pdr2* vs WT**

| Column                                     | Description          |
| ------------------------------------------ | -------------------- |
| **fpkm_pdr2_PvsWT_P_log2foldchange** | pdr2 vs WT under +Pi |
| **fpkm_pdr2_PvsWT_P_pvalue**         | p-value              |
| **fpkm_pdr2_PvsWT_P_padjust**        | adjusted p-value     |

***l1l2 vs pdr2***

| Column                                       | Description            |
| -------------------------------------------- | ---------------------- |
| **fpkm_l1l2_Pvspdr2_P_log2foldchange** | l1l2 vs pdr2 under +Pi |
| **fpkm_l1l2_Pvspdr2_P_pvalue**         | p-value                |
| **fpkm_l1l2_Pvspdr2_P_padjust**        | adjusted p-value       |

5. **Root vs Shoot (WT only)**

| Column                                   | Description      |
| ---------------------------------------- | ---------------- |
| **fpkm_WT_SvsWT_R_log2foldchange** | WT shoot vs root |
| **fpkm_WT_SvsWT_R_pvalue**         | p-value          |
| **fpkm_WT_SvsWT_R_padjust**        | adjusted p-value |
