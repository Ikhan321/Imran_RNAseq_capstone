# XYZ2 and the Phosphate-Starvation Response

An RNA-seq capstone exploring how phosphate limitation is associated with gene-expression responses in wild-type (*WT*) and *xyz2* plants, with a reproducible data workflow and Tableau dashboards for communicating the results.

## Project overview

This project compares gene-expression responses under phosphate-replete (+Pi) and phosphate-starvation (−Pi) conditions in WT and *xyz2*. It asks whether the two genotypes show similar response patterns, which genes change most strongly, and how candidate genes connect to annotated transcription-factor families and KEGG pathways.

The analysis is exploratory and descriptive. The separate WT and *xyz2* differential-expression results do not, by themselves, establish that a response is statistically different between genotypes. A genotype-by-phosphate interaction test is needed to test that directly.

## Questions explored

- Which genes show larger expression changes and stronger statistical evidence in WT and *xyz2*?
- How often do genes change in the same direction in both genotypes?
- Which annotated gene families and pathways appear among the selected response genes?
- What follow-up analysis would directly test whether XYZ2 status changes the phosphate response?

## Analysis workflow

1. **Load and organize** gene-count data and sample metadata.
2. **Clean and validate in Python** by checking data structure, identifiers, sample information, and values, then reshaping tables for analysis.
3. **Explore the data** with basic summaries and distribution checks to understand the data before comparing responses.
4. **Model tables with SQL and dbt** to organize the analysis-ready results and connect expression results with annotation data.
5. **Annotate candidates** with available gene names, descriptions, transcription-factor family labels, and KEGG pathway labels.
6. **Explore and communicate** the results in Tableau dashboards and a PowerPoint presentation.

## Selected results

- The project dataset contains **32,833 distinct genes**.
- At the stated **FDR < 0.05** threshold, **888 genes** are significant in the WT comparison and **6,970 genes** in the *xyz2* comparison. These counts include significant results of different effect sizes.
- Among **20,800 genes** with fold-change data in both genotypes, **11,815 (56.8%)** have changes in the same direction.

These are summaries of the current project tables. The 56.8% figure describes direction agreement; it does not mean that those genes are significant in both comparisons. Differences in the numbers of significant genes are also not, on their own, a formal test that the genotypes respond differently.

## Statistical terms

- **Fold change (FC)** describes how much expression differs between conditions. A log₂ fold change of +1 corresponds to a twofold increase; −1 corresponds to a twofold decrease.
- **False discovery rate (FDR)** adjusts for testing many genes at once and estimates the expected proportion of false positives among results called significant. The project uses FDR < 0.05 as a significance threshold.
- **Genotype-by-condition interaction** tests whether the effect of phosphate condition differs between WT and *xyz2*. This is the appropriate next test for a genotype-specific response claim.

## Tools

Python · SQL · dbt · Tableau · Git/GitHub · RNA-seq and transcriptomic analysis

## Project materials

The repository contains the project source materials and analysis deliverables. See the repository folders and files for the available notebooks, SQL/dbt models, Tableau workbook, figures, and presentation.

- **Tableau Public dashboard:** _Add the published dashboard URL here when available._
- **Presentation:** _Add a link to the final presentation file here if you want it directly accessible from the README._

## Limitations and next steps

The current comparisons are descriptive across genotype-specific results. To test whether XYZ2 status changes the phosphate response, fit a joint model that includes genotype, phosphate condition, and their interaction, with the appropriate sample-level design and replication. Follow with pathway-enrichment analysis using a clearly defined tested-gene background, then validate selected candidate genes with an independent method such as qPCR.

Gene-family and pathway labels depend on the available annotations; they provide biological context, not proof of mechanism. RNA-seq measures RNA abundance and does not directly measure protein abundance or activity.

## References

- Ticconi, C. A. et al. (2004). “Arabidopsis xyz2 reveals a phosphate-sensitive checkpoint in root development.” *The Plant Journal*, 37(6), 801–814. [https://doi.org/10.1111/j.1365-313X.2004.02005.x](https://doi.org/10.1111/j.1365-313X.2004.02005.x)
- Müller, J. et al. (2015). “Iron-dependent callose deposition adjusts root meristem maintenance to phosphate availability.” *Developmental Cell*, 33(2), 216–230. [https://doi.org/10.1016/j.devcel.2015.02.007](https://doi.org/10.1016/j.devcel.2015.02.007)

---

Created as a data-analytics capstone project. Results and interpretations should be read in the context of the analysis design and limitations described above.

