#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0
label: CellRanger 3.0.2 pipeline
inputs:
  - id: sample_id
    label: "Sample ID"
    type: string
  - id: fastq_dirs
    label: "FASTQ directories"
    type: Directory[]
outputs:
  - id: cellranger_results_dir
    outputSource: cellranger/results_dir
    type: Directory
    label: "CellRanger output"
  - id: qc_checks
    outputSource: qc_check/qc_checks
    type: File
    label: QC metrics by cell and gene
  - id: filter_normalize
    outputSource: qc_check/qc_checks
    type: File
    label: QC metrics by cell and gene
steps:
  - id: cellranger
    in:
      - id: sample_id
        source: sample_id
      - id: fastq_dirs
        source: fastq_dirs
    out:
      - results_dir
    run: alignment-steps/align-reads.cwl
    label: CellRanger
  - id: qc_check
    in:
      - id: cellranger_results_dir
        source: cellranger/results_dir
    out:
      - qc_checks
    run: steps/qc_check.cwl
    label: Scanpy QC metrics
  - id: filter_normalize
    in:
      - id: cellranger_results_dir
        source: cellranger/results_dir
    out:
      - filtered_normalized
    run: steps/filter_normalize.cwl
    label: Additional filtering and normalization
  - id: dim_reduction_clustering
    in:
      - id: filter_normalize
        source: filter_normalize/filtered_normalized
    out:
      - dim_reduced_clustered
    run: steps/dim_reduction_clustering.cwl
    label: Dimensionality reduction and clustering
  - id: cluster_diffexpr
    in:
      - id: dim_reduced_clustered
        source: dim_reduction_clustering/dim_reduced_clustered
    out:
      - cluster_diffexpr
    run: steps/cluster_diffexpr.cwl
    label: Dimensionality reduction and clustering
