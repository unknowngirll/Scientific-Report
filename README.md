# Data Directory Overview

This directory contains the input datasets utilized across the three parts of the **LIFE748 Assessment 2** project. The data is organized chronologically based on the analysis pipeline, starting from raw genomics data to downstream structural biology models.

Below is a detailed justification of the data used at each stage of the analysis:

## Part 1: Genome Assembly and Annotation (`part1_genomics/`)
**Data Used:** * PacBio HiFi sequencing reads (Clinical E. coli/Shigella isolate: GN3 / GN6 / GN9) at ~30x coverage.

**Why this data was used:**
To benchmark state-of-the-art genome assembly tools (Flye vs. SPAdes) and annotation pipelines (Prokka vs. Bakta). PacBio HiFi reads were specifically chosen because their long-read, high-accuracy nature is essential for resolving repetitive regions in prokaryotic genomes and generating highly contiguous, single-contig assemblies. This raw data mimics a real-world clinical scenario (septic patient) to evaluate the core facility's diagnostic capabilities.

---

##  Part 2: Machine Learning Analysis (`part2_ml/`)
**Data Used:** * Pre-processed Differential Expression Gene (DEG) count matrix.

**Why this data was used:**
This dataset contains the gene expression profiles of *E. coli* under two distinct experimental conditions. It serves as the foundational input for our machine learning pipeline. We utilized this specific matrix to train and evaluate supervised classification models (Logistic Regression, LDA, and SVM) and to perform unsupervised clustering (k-means/hierarchical). The ultimate goal of using this data was to identify the most biologically informative markers that can robustly discriminate between the two stress/experimental conditions.

---

## Part 3: Structural Bioinformatics (`part3_structural/`)
**Data Used:**
* **Primary Sequences (FASTA):** Amino acid sequences of selected Transcription Factors (TFs) like TreR and FeaR, extracted from the Part 1 Bakta/Prokka annotations.
* **AlphaFold 3 Models (.pdb):** High-confidence predicted 3D structures and their associated PAE (Predicted Aligned Error) JSON files.
* **Experimental Reference Structures (.pdb):** Homologous structures fetched via Foldseek (e.g., PDB `4XXH` for TreR and `5NLA` for FeaR).
* **Consensus Validation Data (.pdb):** Output files from GPSite (AI-based DNA-binding prediction) and ConSurf (evolutionary conservation scores).

**Why this data was used:**
Since structural characterization is crucial for understanding the regulatory roles of the identified DEGs (from Part 2), we transitioned from sequence to structure. 
1. **AlphaFold Data** was used to model the uncharacterized proteins.
2. **Experimental PDBs (4XXH/5NLA)** were required to benchmark the structural alignment (RMSD/TM-Score) and validate the AlphaFold predictions.
3. **GPSite and ConSurf Data** were integrated into PyMOL to perform a "Triple-Consensus Validation." By mapping AI probabilities and evolutionary conservation scores onto the structural coordinates, we confidently identified the functional Helix-Turn-Helix (HTH) DNA-binding interfaces.
