# LIFE748 Assessment 2: Integrated Bioinformatics Pipeline for E. coli

## Overview
This repository contains the code, data directory structures, and analytical workflows for my LIFE748 Assessment 2 project. The primary aim of this assignment is to benchmark and apply state-of-the-art bioinformatics tools to characterize a clinical *Escherichia coli* isolate. 

The analysis is structured into three interconnected modules:
1. **Genomics (Part 1):** Benchmarking long-read genome assembly (Flye vs. SPAdes) and functional annotation (Prokka vs. Bakta) using PacBio HiFi data.
2. **Transcriptomics & Machine Learning (Part 2):** Applying unsupervised clustering and supervised classification models (SVM, LDA, Logistic Regression) to a Differential Expression Genes (DEG) count matrix to identify discriminative biological markers.
3. **Structural Bioinformatics (Part 3):** Predicting and validating the 3D structures of selected transcription factors (TreR and FeaR) using AlphaFold 3, and performing consensus validation of their DNA-binding interfaces using evolutionary (ConSurf) and deep-learning (GPSite) tools.

## Repository Structure

```text
LIFE748_Assessment2/
├── README.md                # This file
├── data/                    # Contains subfolders for input datasets and sequences
│   ├── Data.md            # Detailed rationale for data selection
│       
│              
│     
├── scripts/                 # Source code used for the analysis
│   ├── Part1_code.sh        # Bash script for assembly and annotation
│   ├── Part2_code.qmd       # Quarto/R document for Machine Learning workflow
│   ├── Part3.txt            # PyMOL rendering script for TreR
│                            # PyMOL rendering script for FeaR
└── results/                 # Final output figures, PAE plots, and benchmarking tables
